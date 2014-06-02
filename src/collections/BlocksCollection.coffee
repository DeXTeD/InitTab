
class BlocksCollection extends Backbone.Collection
	model: BlockModel
	url: 'data/index.php'

	_searching: no
	comparator: (model) ->
		if @searching
			return -model.get('score')
		else
			return model.get('position')


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