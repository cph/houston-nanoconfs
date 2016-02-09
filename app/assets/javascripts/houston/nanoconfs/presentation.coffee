$ ->
  if $('#nanoconf-description').length > 0
    activateLazyUpdates()
    activateMarkdownPreview()

updateMarkdownPreview = (text) ->
  markdown_text = App.mdown(text)
  markdown_text = "Nothing to Preview" if markdown_text is ""
  $(".markdown-body").html(markdown_text)

activateLazyUpdates = ->
  lazyUpdate = _.debounce((->
    updateMarkdownPreview(@value)
  ), 500)

  $('#nanoconf-description').keyup(lazyUpdate)

activateMarkdownPreview = ->
  $description = $('#nanoconf-description').val()
  updateMarkdownPreview($description)
