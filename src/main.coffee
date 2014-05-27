App = new Backbone.Marionette.Application()

window.App = App

App.addRegions
	mainRegion: "#main"
	asideRegion: "#aside"

App.addInitializer (options) ->
	blockCollection = new BlocksCollection
	blockCollection.fetch()
	blocksCompositeView = new BlocksCompositeView
		model: new BlocksCompositeModel
		collection: blockCollection

	App.mainRegion.show blocksCompositeView.render()
	App.blocks = blocksCompositeView


console.log "---------- START ----------"

App.start()