package event


import (
    "appengine"
    "appengine/datastore"
    "appengine/user"
    "html/template"
    "net/http"
    "crypto/rand"
    "fmt"
    "io"
    "encoding/json"
)

type Group struct {
    ID string
    Name  string
    Description string
    Users   []string
}

func init() {
    http.HandleFunc("/grouplist", groupsPage)
    http.HandleFunc("/addgroup", addGroup)
    http.HandleFunc("/eventspage", eventsPage)
}

func groupsPage(w http.ResponseWriter, r *http.Request) {
    c := appengine.NewContext(r)
    u := user.Current(c)
    if u == nil {
        url, err := user.LoginURL(c, r.URL.String())
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }
        w.Header().Set("Location", url)
        w.WriteHeader(http.StatusFound)
        return
    }
    q := datastore.NewQuery("Group").Order("Name").Limit(10)
    
    groups := make([]Group, 0, 10)
    if _, err := q.GetAll(c, &groups); err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    jsonanswer, err := json.Marshal(groups) 
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
    fmt.Fprintf(w, "%s", jsonanswer)
}

func eventsPage(w http.ResponseWriter, r *http.Request) {
    c := appengine.NewContext(r)
    u := user.Current(c)
    if u == nil {
        url, err := user.LoginURL(c, r.URL.String())
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }
        w.Header().Set("Location", url)
        w.WriteHeader(http.StatusFound)
        return
    }
    id := r.FormValue("groupid")
    q := datastore.NewQuery("Group").Filter("ID =",id)
    t := q.Run(c)
    var g Group
    for {
        _, err := t.Next(&g)
        if err == datastore.Done {
        break // No further entities match the query.
        }
        if err != nil {
                c.Errorf("fetching next Person: %v", err)
        break
    }
    if err := eventsPageTemplate.Execute(w, g); err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
}

}

var groupsPageTemplate = template.Must(template.New("book").Parse(groupsPageTemplateHTML))

const groupsPageTemplateHTML = `
<html>
  <body>
    {{range .}}
      <a href="/eventspage?groupid={{.ID}}">
      {{with .Name}}
        <h3><b>{{.}}</h3>
      {{else}}
        <h3>Unnamed Group:</h3>
      {{end}}
      </a>
      <pre>{{.Description}}</pre>
    {{end}}
    <form action="/addgroup" method="post">
      <div><input name="name"></input></div>
      <div><textarea name="description" rows="3" cols="60"></textarea></div>
      <div><input type="submit" value="Add Group"></div>
    </form>
  </body>
</html>
`

var eventsPageTemplate = template.Must(template.New("book").Parse(eventsPageTemplateHTML))

const eventsPageTemplateHTML = `
<html>
  <body>
      {{with .Name}}
        <h3><b>{{.}}</h3>
      {{else}}
        <h3>Unnamed Group:</h3>
      {{end}}
      <pre>{{.Description}}</pre>
  </body>
</html>
`

func addGroup(w http.ResponseWriter, r *http.Request) {
    c := appengine.NewContext(r)
    uuid,err := newUUID()
    // TODO: this is not a good long term solution.
    if err != nil {
        uuid = "0"   
    }
    g := Group{
        ID: uuid,
        Name: r.FormValue("name"),
        Description: r.FormValue("description"),
    }
    _, err = datastore.Put(c, datastore.NewIncompleteKey(c, "Group", nil), &g)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    http.Redirect(w, r, "/", http.StatusFound)
}

func newUUID() (string, error) {
    uuid := make([]byte, 16)
    n, err := io.ReadFull(rand.Reader, uuid)
    if n != len(uuid) || err != nil {
        return "", err
    }
    // variant bits; see section 4.1.1
    uuid[8] = uuid[8]&^0xc0 | 0x80
    // version 4 (pseudo-random); see section 4.1.3
    uuid[6] = uuid[6]&^0xf0 | 0x40
    return fmt.Sprintf("%x-%x-%x-%x-%x", uuid[0:4], uuid[4:6], uuid[6:8], uuid[8:10], uuid[10:]), nil
}
