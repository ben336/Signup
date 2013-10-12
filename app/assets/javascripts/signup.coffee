require ["routes","controllers"], (routes) ->
	
	body = document.getElementsByTagName("body")[0]
	angular.bootstrap body, ["signup"]