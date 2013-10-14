name := "helloplay"

version := "1.0-SNAPSHOT"

libraryDependencies ++= Seq(
  javaJdbc,
  javaEbean,
  cache
)

play.Project.playJavaSettings

requireJs += "signup.js"

requireJsShim += "signup.js"
