autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    callback = options[0].callback if options[0].callback and Object.prototype.toString.call(options[0].callback) is '[object Function]'
    delete options[0].callback

    link_attributes = ''

    for key, value of options[0]
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, (match, url) -> callback && callback(url) || "<a href='#{url}'#{link_attributes}>#{url}</a>"

  else
    @replace url_pattern, "<a href='$1'>$1</a>"

String.prototype['autoLink'] = autoLink
