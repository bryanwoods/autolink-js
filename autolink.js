(function() {
  var __slice = Array.prototype.slice;
  String.prototype.autoLink = function() {
    var key, link_attributes, options, url_pattern, value, _ref;
    options = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    url_pattern = /(\b(https?):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    if (options.length > 0) {
      link_attributes = '';
      _ref = options[0];
      for (key in _ref) {
        value = _ref[key];
        link_attributes += " " + key + "='" + value + "'";
      }
      return this.replace(url_pattern, "<a href='$1' " + link_attributes.trim() + ">$1</a>");
    } else {
      return this.replace(url_pattern, "<a href='$1'>$1</a>");
    }
  };
}).call(this);
