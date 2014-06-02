
class BlockFormItemView extends Backbone.Marionette.ItemView
	template: "#BlockItemForm-template"
	className: "popup"

	ui:
		form: "form"
		inputs: ":input"

	events:
		'submit @ui.form': 'submit'

	submit: ->
		App.blocks.collection.add @model
		data = {}
		_.each @ui.form.serializeArray(), (input) ->
			data[input.name] = input.value
		@model.save data
		@close()
