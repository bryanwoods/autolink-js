autoLink = (options...) ->
  url_pattern =
    /(^|\s)(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|]\b)/ig

  if options.length > 0
    option = options[0]
    callbackOption = option.callback

    if callbackOption? and typeof callbackOption is 'function'
      callback = callbackOption
      delete option.callback

    link_attributes = ''

    for key, value of option
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, (match, space, url) ->
      returnCallback = callback and callback(url)

      link = returnCallback or "<a href='#{url}'#{link_attributes}>#{url}</a>"
      "#{space}#{link}"
  else
    @replace url_pattern, "$1<a href='$2'>$2</a>"

String.prototype['autoLink'] = autoLink
