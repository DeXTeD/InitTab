angular.module 'App', ['ngRoute', 'angular-sortable-view']


.factory 'userData', ->
	window.user


.factory 'gridData', [
	'$http', 'userData', '$q',
	($http,   userData,   $q) ->
		# deferred = $q.defer()
		# resolve = (data, status, headers, config) -> deferred.resolve data
		url = (action = '') ->
			action = '&action='+action if action
			'db.php?user='+userData.key+action

		cache = null


		# promise = deferred.promise

		# console.log 'promise', promise

		get: ->
			if cache
				return success: (cb) ->
					cb cache, 'cache'

			$http.get url()
			.success (data, status, headers, config) ->
				cache = data

		set: (data) ->
			cache = data

		sort: (ids) ->
			$http.post url('sort'), {ids}
			.success (data, status, headers, config) ->
				cache = data

		create: (block) ->
			$http.post url('create'), block
			.success (data, status, headers, config) ->
				cache = data

		remove: (block) ->
			$http.post url('remove'), block
			.success (data, status, headers, config) ->
				cache = data

		edit: (block) ->
			$http.post url('edit'), block
			.success (data, status, headers, config) ->
				cache = data
	]


.filter 'find', ->
	(items, query) ->
		return items unless query
		_ items
		.sortBy (item) ->
			item.score = item.title.score query
			-item.score

		.filter (item) ->
			item.score > 0.3


.config [
	'$routeProvider',
	($routeProvider) ->
		$routeProvider

			.when '/edit/:id',
				controller: 'EditController'
				templateUrl: 'detail.html'

			.when '/remove/:id',
				controller: 'RemoveController'
				templateUrl: 'remove.html'

			.when '/new',
				controller: 'CreateController'
				templateUrl: 'detail.html'

			.otherwise
				controller: 'GridController'
				templateUrl: 'grid.html'
	]


.controller 'GridController', [
	'$scope', '$http', 'gridData', 'userData',
	($scope,   $http,   gridData,   userData) ->
		console.log "gridData", gridData
		gridData.get().success (list) ->
			$scope.list = list

		$scope.onSort = ($item, $partFrom, $partTo, $indexFrom, $indexTo) ->
			ids = _.pluck $partTo, 'id'
			gridData.sort ids
	]


.controller 'CreateController', [
	'$scope', '$http', '$location', 'gridData',
	($scope,   $http,   $location,   gridData) ->
		$scope.block = {}
		$scope.save = ->
			gridData.create $scope.block
			.success -> $location.url '/'
	]


.controller 'EditController', [
	'$scope', '$http', '$routeParams', '$location', 'gridData',
	($scope,   $http,   $routeParams,   $location,   gridData) ->
		gridData.get().success (list) ->
			$scope.list = list

			id = $routeParams.id
			$scope.block = _.findWhere $scope.list, id: +id

		$scope.save = ->
			gridData.edit $scope.block
			.success -> $location.url '/'
	]


.controller 'RemoveController', [
	'$scope', '$http', '$routeParams', '$location', 'gridData',
	($scope,   $http,   $routeParams,   $location,   gridData) ->
		gridData.get().success (list) ->
			$scope.list = list
			id = $routeParams.id
			$scope.block = _.findWhere $scope.list, id: +id

		$scope.remove = ->
			gridData.remove $scope.block
			.success -> $location.url '/'
	]