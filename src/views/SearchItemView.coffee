KEY_ESC = 27
KEY_ENTER = 13

class SearchItemView extends Backbone.Marionette.ItemView
	el: "#search"
	ui: input: 'input'
	events:
		'keyup @ui.input': 'changeQuery'

	changeQuery: (event) ->
		val = $.trim event.currentTarget.value

		if event.keyCode is KEY_ENTER
			App.vent.trigger 'enter'

		if event.keyCode is KEY_ESC
		 	val = event.currentTarget.value = ''
			App.vent.trigger 'esc'

		@model.set query: val
