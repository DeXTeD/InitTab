
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

		@listenTo @collection, 'change:position', (model, position) ->
			@collection.sort()
			@render()

		# Podmieniamy model i kolekcje EmptyViewa
		@on 'before:item:added', (view) ->
			if view instanceof BlocksEmptyView
				view.model = @model
				view.collection = @collection

		# @on 'after:item:added', ->
		# 	console.log "sort"
		# 	@collection.sort()
		# 	# @render()


	getEmptyView: ->
		BlocksEmptyView

	# https://github.com/marionettejs/backbone.marionette/wiki/Adding-support-for-sorted-collections
	appendHtml: (collectionView, itemView, index) ->
		if (collectionView.isBuffering)
			collectionView._bufferedChildren.push itemView

		childrenContainer = if collectionView.isBuffering then $(collectionView.elBuffer) else this.getItemViewContainer(collectionView)
		children = childrenContainer.children()
		if (children.size() <= index)
			childrenContainer.append itemView.el
		else
			children.eq(index).before itemView.el


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


