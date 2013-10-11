define ->

	eventResource = ($resource) ->
	  $resource("/assets/event.json", {}, { query: { method:'GET', params:{}, isArray:false}})

	angular.module("signUpServices", ["ngResource"]).factory('Event', eventResource);
