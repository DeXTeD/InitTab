
class BlocksCompositeView extends Backbone.Marionette.CompositeView
	itemView: BlockItemView
	template: "#BlocksComposite-template"
	itemViewContainer: "[data-blocks]"

	initialize: ->
		@listenTo @model, 'change:query', _.debounce @render, 50


	addItemView: (item, view, index) ->
		q = @model.get('query')
		if q
			return unless item.hasString q
		super

