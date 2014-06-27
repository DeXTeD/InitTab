
class BlocksCollection extends Backbone.Collection
	model: BlockModel
	url: 'data/index.php/'

	initialize: (config) ->
		@url+= config.key

	_searching: no
	comparator: (model) ->
		if @_searching
			return - Math.round model.get('score')*100
		else
			return (model.get('position')+1)*1000+model.get('id')


	getBest: ->
		best = null
		@each (model) ->
			if not best or best.get('score') < model.get('score')
				best = model
		best


	count: ->
		@where(visible: yes).length

	isSearching: (@_searching) ->
		this