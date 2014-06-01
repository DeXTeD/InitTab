
class BlockModel extends Backbone.Model

	defaults:
		title: ''
		thumbnail: ''
		score: 0

	hasString: (q) ->
		string = @get('title')
		score = string.score q
		@set {score}, silent: yes
		return score > 0.2