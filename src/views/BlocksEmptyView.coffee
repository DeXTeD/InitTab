
class BlocksEmptyView extends Backbone.Marionette.ItemView
	template: "#BlocksEmpty-template"
	className: 'blockEmpty'

	events:
		'click': 'onClick'

	onClick: ->
		App.vent.trigger 'search', @model.get('query')