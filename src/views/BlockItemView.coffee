
class BlockItemView extends Backbone.Marionette.ItemView
	template: "#BlockItem-template"
	className: 'block'

	# events:
	# 	'click': 'onClick'

	# onClick: (event) ->
	# 	event.preventDefault()
	# 	alert(1)

	# onRender: ->
	# 	console.log "One block render"
	# 	@$el.attr
	# 		'data-row': @model.get('row')
	# 		'data-col': @model.get('col')
	# 		'data-sizex': @model.get('sizex')
	# 		'data-sizey': @model.get('sizey')
