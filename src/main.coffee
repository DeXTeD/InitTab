angular.module 'App', ['ngRoute', 'angular-sortable-view']


.factory 'userData', ->
	window.user

.factory 'keyCodes', ->
	(code) ->
		keys =
			13: 'enter'
			27: 'esc'
			32: 'space'
			37: 'left'
			38: 'up'
			39: 'right'
			40: 'down'
		keys[code]

.factory 'gridData', [
	'$http', 'userData', '$q',
	($http,   userData,   $q) ->
		url = (action = '') ->
			action = '&action='+action if action
			'db.php?user='+userData.key+action

		cache = null

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
	'$scope', '$http', '$filter', 'gridData', 'keyCodes', 'userData',
	($scope,   $http,   $filter,   gridData,   keyCodes,   userData) ->
		allItems = []
		gridData.get().success (items) ->
			$scope.items = items
			allItems = items

		select = (item) ->
			return false unless item
			if $scope.selected
				$scope.selected.selected = no
			$scope.selected = item
			$scope.selected.selected = yes

		selectNext = ->
			index = $scope.items.indexOf $scope.selected
			console.log 'index', index
			select $scope.items[++index]

		selectPrev = ->
			index = $scope.items.indexOf $scope.selected
			console.log 'index', index
			select $scope.items[--index]

		open = ->
			toOpen = $scope.selected or $scope.items[0]
			window.location = toOpen.url

		clear = ->
			$scope.search $scope.q = ''

		$scope.onSort = ($item, $partFrom, $partTo, $indexFrom, $indexTo) ->
			ids = _.pluck $partTo, 'id'
			gridData.sort ids

		$scope.search = (q) ->
			$scope.items = $filter('find') allItems, q
			select $scope.items[0]

		$scope.keyup = ($event) ->
			key = keyCodes $event.keyCode
			open()			if key is 'enter'
			clear()			if key is 'esc'
			selectNext()	if key in ['right', 'down']
			selectPrev()	if key in ['left', 'up']
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
		gridData.get().success (items) ->
			$scope.items = items

			id = $routeParams.id
			$scope.block = _.findWhere $scope.items, id: +id

		$scope.save = ->
			gridData.edit $scope.block
			.success -> $location.url '/'
	]


.controller 'RemoveController', [
	'$scope', '$http', '$routeParams', '$location', 'gridData',
	($scope,   $http,   $routeParams,   $location,   gridData) ->
		gridData.get().success (items) ->
			$scope.items = items
			id = $routeParams.id
			$scope.block = _.findWhere $scope.items, id: +id

		$scope.remove = ->
			gridData.remove $scope.block
			.success -> $location.url '/'
	]