(function() {
  var autoLink,
    __slice = Array.prototype.slice;

  autoLink = function() {
    var callback, callbackOption, key, link_attributes, option, options, url_pattern, value;
    options = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    url_pattern = /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig;
    if (options.length > 0) {
      option = options[0];
      callbackOption = option.callback;
      if ((callbackOption != null) && typeof callbackOption === 'function') {
        callback = callbackOption;
        delete option.callback;
      }
      link_attributes = '';
      for (key in option) {
        value = option[key];
        link_attributes += " " + key + "='" + value + "'";
      }
      return this.replace(url_pattern, function(match, url) {
        var returnCallback;
        returnCallback = callback && callback(url);
        return returnCallback || ("<a href='" + url + "'" + link_attributes + ">" + url + "</a>");
      });
    } else {
      return this.replace(url_pattern, "<a href='$1'>$1</a>");
    }
  };

  String.prototype['autoLink'] = autoLink;

}).call(this);
