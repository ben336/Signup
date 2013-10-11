define ->

	# Controllers

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



	window.EventCtrl  = ($scope, $routeParams,Event) ->
		id = $routeParams.eventId
		$scope.event = Event.query()

