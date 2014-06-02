
class BlocksEmptyView extends Backbone.Marionette.ItemView
	template: "#BlocksEmpty-template"
	className: 'blockEmpty'

	events:
		'click': 'onClick'

	onClick: ->
		query = @model.get('query')
		App.vent.trigger 'search', query if query

	serializeData: ->
		model: @model.toJSON()
		collection: @collection.toJSON()