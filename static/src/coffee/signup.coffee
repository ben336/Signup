
routefunc = ($routeProvider) ->
	groupsTemplate = 
		templateUrl: '/static/partials/groups.html'
		controller: GroupListCtrl
	eventsTemplate = 
		templateUrl: '/static/partials/events.html' 
		controller: EventListCtrl
	eventTemplate = 
		templateUrl: '/static/partials/event.html' 
		controller:EventCtrl

	$routeProvider.when('/groups', groupsTemplate).
      when('/groups/:groupId', eventsTemplate).
      when('/events/:eventId', eventTemplate).
      otherwise({redirectTo: '/groups'});

angular.module('signup', []).config(['$routeProvider', routefunc]);


window.GroupListCtrl  = ($scope) ->
	$scope.groups = [
		{ID:"ABC123",Name:"4PM Saturday, WCC Offering Team",Description:"The Offering Team for the Summit West Club Campus Saturday service."}
		{ID:"ABC124",Name:"9AM Sunday, WCC Offering Team",Description:"The Offering Team for the first Summit West Club Campus Sunday service."}
		{ID:"ABC125",Name:"11AM Sunday, WCC Offering Team",Description:"The Offering Team for the second Summit West Club Campus Sunday service."}
	]


window.EventListCtrl  = ($scope, $routeParams) ->
	id = $routeParams.groupId;
	events = [
		{EventID:"1",GroupID:"ABC123",Name:"Offering Collection", Date:"9/22/2013",Description:"Collecting for Offering"}
		{EventID:"2",GroupID:"ABC124",Name:"Offering Collection", Date:"9/22/2013",Description:"Collecting for Offering"}
		{EventID:"3",GroupID:"ABC124",Name:"Offering Collection", Date:"9/22/2013",Description:"Collecting for Offering and Communion"}
		{EventID:"4",GroupID:"ABC125",Name:"Offering Collection", Date:"9/22/2013",Description:"Collecting for Offering"}		
	]
	$scope.events = (event for event in events when event.GroupID is id)



window.EventCtrl  = ($scope, $routeParams) ->
	id = $routeParams.eventId;
	event = { 	
		ID:"1",
		Name:"Offering Collection", 
		Date:"9/22/2013",
		Description:"Collecting for Offering"
		Roles:[
			{ role:"Collector 1" , volunteer: "John Doe"},
			{ role:"Collector 2" , volunteer: "John Smith"},
			{ role:"Collector 3" , volunteer: null},
			{ role:"Collector 4" , volunteer: "Ben McCormick"},
			{ role:"Collector 5" , volunteer: null},
			{ role:"Collector 6" , volunteer: null},
			{ role:"Collector 7" , volunteer: null},
			{ role:"Collector 8" , volunteer: null}
		]}
	$scope.event = event