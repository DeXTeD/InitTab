App = new Backbone.Marionette.Application()

window.App = App

App.addRegions
	mainRegion: "#main"
	searchRegion: "#search"

App.addInitializer (options) ->

	blockCollection = new BlocksCollection
	blockCollection.fetch()

	compositeModel = new CompositeModel

	searchView = new SearchItemView
		model: compositeModel

	blocksCompositeView = new BlocksCompositeView
		model: compositeModel
		collection: blockCollection

	App.mainRegion.show blocksCompositeView.render()
	App.blocks = blocksCompositeView

	App.vent.on 'open', (url) ->
		window.location = url

	App.vent.on 'search', (query) ->
		window.location = 'https://www.google.com/search?q='+encodeURIComponent(query)


console.log "---------- START ----------"

App.start()