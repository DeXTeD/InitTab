
class BlockModel extends Backbone.Model

	defaults:
		title: ''
		thumbnail: ''
		url: ''
		score: 0
		visible: yes

	search: (q) ->
		string = @get('title')
		score = string.score q
		visible = score > 0.15
		@set {score, visible}, silent: yes
		return visible

	cleanSearch: ->
		@set
			score: 0
			visible: yes