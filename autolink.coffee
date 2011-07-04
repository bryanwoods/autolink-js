String.prototype.autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    result = ''

    for key, value of options[0]
      result += " #{key}='#{value}'"

    @replace url_pattern, "<a href='$1' " + result.trim() + ">$1</a>"

  else
    @replace url_pattern, "<a href='$1'>$1</a>"
