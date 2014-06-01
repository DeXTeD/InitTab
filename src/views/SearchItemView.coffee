KEY_ESC = 27
KEY_ENTER = 13

class SearchItemView extends Backbone.Marionette.ItemView
	el: "#search"
	ui: input: 'input'
	events:
		'keyup @ui.input': 'changeQuery'

	changeQuery: (event) ->
		val = event.currentTarget.value

		if event.keyCode is KEY_ENTER
			App.vent.trigger 'enter'

		if event.keyCode is KEY_ESC
		 	val = ''
			App.vent.trigger 'esc'

		val = $.trim val
		@model.set 'query', event.currentTarget.value = val
