require ["routes","services","controllers"], (routes) ->
	angular.module("signup", ["signUpServices"]).config(["$routeProvider", routes]);
	body = document.getElementsByTagName("body")[0]
	angular.bootstrap body, ["signup"]