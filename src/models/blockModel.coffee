
class BlockModel extends Backbone.Model

	hasString: (q) ->
		string = @get('title')
		return string.score(q) > 0.2