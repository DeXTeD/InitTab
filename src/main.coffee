App = new Backbone.Marionette.Application()

window.App = App

App.addRegions
	mainRegion: "#main"
	searchRegion: "#search"

App.addInitializer (options) ->

	body = $ 'body'
	key = body.data 'key'

	blockCollection = new BlocksCollection key: key
	blockCollection.fetch
		prefill: yes
		expires: false

	compositeModel = new CompositeModel

	searchView = new NavItemView
		model: compositeModel

	blocksCompositeView = new BlocksCompositeView
		model: compositeModel
		collection: blockCollection

	App.mainRegion.show blocksCompositeView.render()
	App.blocks = blocksCompositeView

	App.vent.on 'new', ->
		form = new BlockFormItemView
			model: new BlockModel
		body.append form.render().el

	App.vent.on 'edit', (model) ->
		form = new BlockFormItemView
			model: model
		body.append form.render().el

	App.vent.on 'open', (url) ->
		window.location = url

	App.vent.on 'search', (query) ->
		window.location = 'https://www.google.com/search?q='+encodeURIComponent(query)

Backbone.emulateHTTP = yes
App.start()
