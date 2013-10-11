define ["controllers"] , ->

	routefunc = ($routeProvider) ->
		groupsTemplate = 
			templateUrl: '/assets/partials/groups.html'
			controller: GroupListCtrl
		eventsTemplate = 
			templateUrl: '/assets/partials/events.html' 
			controller: EventListCtrl
		eventTemplate = 
			templateUrl: '/assets/partials/event.html' 
			controller:EventCtrl

		$routeProvider.when('/groups', groupsTemplate).
			when('/groups/:groupId', eventsTemplate).
			when('/events/:eventId', eventTemplate).
			otherwise({redirectTo: '/groups'});