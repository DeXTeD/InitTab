
class BlockFormItemView extends Backbone.Marionette.ItemView
	template: "#BlockItemForm-template"
	className: "popup"

	ui:
		inputs: ":input"
		edit: "[data-edit]"

	events:
		'click @ui.destroy': 'destroy'

	modelEvents:
		"change:url": "render"
		"change:title": "render"
		"change:thumbnail": "render"

	destroy: ->
		@model.destroy()
