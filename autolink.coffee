autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    link_attributes = ''

    for key, value of options[0]
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, "<a href='$1' " + link_attributes.trim() + ">$1</a>"

  else
    @replace url_pattern, "<a href='$1'>$1</a>"

String.prototype['autoLink'] = autoLink
