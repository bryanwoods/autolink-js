autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    option = options[0]
    callbackOption = option.callback

    if callbackOption? and typeof callbackOption is 'function'
      callback = callbackOption
      delete option.callback

    link_attributes = ''

    for key, value of option
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, (match, url) ->
      returnCallback = callback and callback(url)

      returnCallback or "<a href='#{url}'#{link_attributes}>#{url}</a>"
  else
    @replace url_pattern, "<a href='$1'>$1</a>"

String.prototype['autoLink'] = autoLink
