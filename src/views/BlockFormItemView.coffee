
class BlockFormItemView extends Backbone.Marionette.ItemView
	template: "#BlockItemForm-template"
	className: "popup"

	ui:
		form: "form"
		inputs: ":input"
		close: "[data-close]"

	events:
		'submit @ui.form': 'submit'
		'click @ui.close': 'destroy'

	submit: (event) ->
		event.preventDefault()
		App.blocks.collection.add @model
		data = {}
		_.each @ui.form.serializeArray(), (input) ->
			data[input.name] = input.value
		@model.save data
		@destroy()
