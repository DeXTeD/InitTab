KEY_ESC = 27
KEY_ENTER = 13

class SearchItemView extends Backbone.Marionette.ItemView
	el: "#search"
	ui: input: 'input'
	events:
		'keyup @ui.input': 'changeQuery'

	changeQuery: (event) ->
		val = event.currentTarget.value
		console.log val
		alert('TODO') if event.keyCode is KEY_ENTER
		val = '' if event.keyCode is KEY_ESC
		@model.set 'query', event.currentTarget.value = val
