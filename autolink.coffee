autoLink = (options...) ->
  linkAttributes = ''
  option = options[0]
  pattern =
    /(^|\s)((?:https?|ftp):\/\/[\-A-Z0-9+\u0026@#\/%?=~_|!:,.;]*[\-A-Z0-9+\u0026@#\/%=~_|])/gi

  return @replace pattern, "$1<a href='$2'>$2</a>" unless options.length > 0

  if option['callback']? and typeof option['callback'] is 'function'
    callbackThunk = option['callback']
    delete option['callback']

  linkAttributes += " #{key}='#{value}'" for key, value of option

  @replace pattern, (match, space, url) ->
    returnCallback = callbackThunk and callbackThunk(url)
    link = returnCallback or "<a href='#{url}'#{linkAttributes}>#{url}</a>"

    "#{space}#{link}"

String.prototype['autoLink'] = autoLink
