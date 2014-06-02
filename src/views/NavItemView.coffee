KEY_ESC = 27
KEY_ENTER = 13

class NavItemView extends Backbone.Marionette.ItemView
	el: "#search"
	ui:
		add: '[data-add]'
		search: 'input'

	events:
		'keyup @ui.search': 'changeQuery'
		'click @ui.add': 'addNew'


	changeQuery: (event) ->
		val = $.trim event.currentTarget.value

		if event.keyCode is KEY_ENTER
			App.vent.trigger 'enter'

		if event.keyCode is KEY_ESC
		 	val = event.currentTarget.value = ''
			App.vent.trigger 'esc'

		@model.set query: val


	addNew: ->
		App.vent.trigger 'new'
