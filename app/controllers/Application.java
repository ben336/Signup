package controllers;

import play.*;
import play.mvc.*;
import models.Team;

import views.html.*;

public class Application extends Controller {

    public static Result index() {
        return ok(index.render());
    }

    public static Result addTeam() {
    	Team team = new Team();
    	team.name = "test";
    	team.description  = "Descriptive text";
    	Team.create(team);
    	return ok("Added Team " + team.id);
    }

    public static Result getGroups() {
    	return null;
    }

}
