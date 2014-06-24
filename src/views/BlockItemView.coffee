
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

	# destroy: ->
	# 	@model.destroy()

	edit: ->
		App.vent.trigger 'edit', @model

	onRender: ->
		isHighlight = @model.cid is @model.collection.highlight?.cid
		# if isHighlight
		# 	@className = "block block--highlight"
		# else
		# 	@className = "block"
		# console.log "onBeforeRender", isHighlight, @className
		# @model.set highlight: isHighlight
		if isHighlight
			@$el.addClass "block--highlight"
