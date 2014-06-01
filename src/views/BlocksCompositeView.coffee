
class BlocksCompositeView extends Backbone.Marionette.CompositeView
	itemView: BlockItemView
	template: "#BlocksComposite-template"
	itemViewContainer: "[data-blocks]"

	initialize: ->
		@listenTo App.vent, 'enter', @openBest
		@listenTo @model, 'change:query', _.debounce (model, query) ->
			if query
				@collection.isSearching(yes).each (model) ->
					model.search query
			else
				@collection.isSearching(no).each (model) ->
					model.cleanSearch()

			@collection.sort()
			@render()
		, 50


		# Podmieniamy model EmptyViewa
		@on 'before:item:added', (view) ->
			if view instanceof BlocksEmptyView
				view.model = @model


	getEmptyView: ->
		BlocksEmptyView

	# showEmptyView: ->
	# 	EmptyView = @getEmptyView()

	# 	if EmptyView and not @_showingEmptyView
	# 		@_showingEmptyView = yes
	# 		@addItemView @model, EmptyView, 0


	addItemView: (item, view, index) ->
		return if item.get('visible') is no
		super


	openBest: ->
		if @isEmpty()
			App.vent.trigger 'search', @model.get('query')
		else
			best = @collection.getBest()
			App.vent.trigger 'open', best.get('url')


	isEmpty: ->
		@collection.count() < 1


