
class BlockModel extends Backbone.Model

	defaults:
		title: ''
		thumbnail: ''
		url: ''
		score: 0
		position: 0
		visible: yes
		highlight: no

	search: (q) ->
		string = @get('title')
		score = string.score q
		visible = score > 0.15
		@set {score, visible}, silent: yes
		return {score, visible}

	cleanSearch: ->
		@set
			score: 0
			visible: yes