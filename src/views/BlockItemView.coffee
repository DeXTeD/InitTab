
class BlockItemView extends Backbone.Marionette.ItemView
	template: "#BlockItem-template"
	className: "block"

	ui:
		destroy: "[data-destroy]"
		edit: "[data-edit]"

	events:
		'click @ui.destroy': 'destroy'
		'click @ui.edit': 'edit'

	modelEvents:
		"change:url": "render"
		"change:title": "render"
		"change:thumbnail": "render"

	destroy: ->
		@model.destroy()

	edit: ->
		App.vent.trigger 'edit', @model
