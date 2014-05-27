
KEY_ESC = 27
KEY_ENTER = 13

class BlockItemView extends Backbone.Marionette.ItemView
	template: "#BlockItem-template"
	className: 'block'
	events:
		'click': 'onClick'

	onClick: (event) ->
		event.preventDefault()
		alert(1)

	# onRender: ->
	# 	console.log "One block render"
	# 	@$el.attr
	# 		'data-row': @model.get('row')
	# 		'data-col': @model.get('col')
	# 		'data-sizex': @model.get('sizex')
	# 		'data-sizey': @model.get('sizey')


class BlocksCompositeView extends Backbone.Marionette.CompositeView
	itemView: BlockItemView
	template: "#BlocksComposite-template"
	itemViewContainer: "[data-blocks]"

	ui: search: '#search'
	events:
		'keyup @ui.search': 'changeQuery'

	initialize: ->
		@listenTo @model, 'change:query', ->
			@$itemViewContainer.empty()
			@showCollection()

	changeQuery: _.debounce (event) ->
		val = event.currentTarget.value
		alert('TODO') if event.keyCode is KEY_ENTER
		val = '' if event.keyCode is KEY_ESC
		@model.set 'query', event.currentTarget.value = val
	, 100

	addItemView: (item, view, index) ->
		q = @model.get('query')
		if q
			return unless item.hasString q
		super

