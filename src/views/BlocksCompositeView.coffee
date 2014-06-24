
class BlocksCompositeView extends Backbone.Marionette.CompositeView
	template: "#BlocksComposite-template"
	childView: BlockItemView
	childViewContainer: "[data-blocks]"

	initialize: ->
		@listenTo App.vent, 'enter', @openBest
		@listenTo @model, 'change:query', _.debounce (model, query) ->
			if query
				best =
					model: null
					score: null

				@collection.isSearching(yes).each (model) ->
					results = model.search query
					if not best.model or best.score < results.score
						best.model = model
						best.score = results.score

				# zapisujemy najlepszy klocek
				@collection.highlight = best.model
			else
				@collection.highlight = false
				@collection.isSearching(no).each (model) ->
					model.cleanSearch()

			@collection.sort()
			@render()
		, 50

		@listenTo @collection, 'change:position', (model, position) ->
			@collection.sort()
			@render()

		@collection.sort()


	getEmptyView: ->
		BlocksEmptyView

	isEmpty: ->
		@collection.count() < 1

	emptyViewOptions: ->
		collection: @collection
		model: @model


	addChild: (item, view, index) ->
		return if item.get('visible') is no
		super


	openBest: ->
		if @isEmpty()
			App.vent.trigger 'search', @model.get('query')
		else
			best = @collection.getBest()
			App.vent.trigger 'open', best.get('url')
