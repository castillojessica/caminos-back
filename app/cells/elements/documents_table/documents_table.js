CDLV.Components['documents/table'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
      this,
      'addDocument',
      'removeDocument'
    )
    var $template = this.$el.find('#document-template')
    this.template = _.template($template.html())
    $template.remove()

    this.$tableBody = this.$el.find('.documents-table-body')

    CDLV.pubSub.on({
      'document:add': this.addDocument,
      'document:remove': this.removeDocument
    })
  },

  addDocument: function(data){
    this.$tableBody.append( this.template(data.response) )
  },

  removeDocument: function(documentId){
    this.$tableBody.find('#'+documentId).remove()
  }
})