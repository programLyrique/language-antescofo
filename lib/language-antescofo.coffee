AntescofoView = require './language-antescofo-view'
{CompositeDisposable} = require 'atom'

module.exports = Antescofo =
  language-antescofoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @language-antescofoView = new AntescofoView(state.language-antescofoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @language-antescofoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-antescofo:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @language-antescofoView.destroy()

  serialize: ->
    language-antescofoViewState: @language-antescofoView.serialize()

  toggle: ->
    console.log 'Antescofo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
