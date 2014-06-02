
class BlockItemView extends Backbone.Marionette.ItemView
	template: "#BlockItem-template"
	className: "block"

	ui:
		destroy: "[data-destroy]"
		edit: "[data-edit]"

	events:
		'click @ui.destroy': 'destroy'

	modelEvents:
		"change:url": "render"
		"change:title": "render"
		"change:thumbnail": "render"

	destroy: ->
		@model.destroy()
