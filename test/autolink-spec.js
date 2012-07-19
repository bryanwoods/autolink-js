(function() {

  describe("autolink", function() {
    it("can be called on a string", function() {
      return expect("hi there".autoLink()).toBeDefined();
    });
    it("does not alter a string with no URL present", function() {
      return expect("hi again".autoLink()).toEqual("hi again");
    });
    it("returns the string with the URLs hyperlinked", function() {
      return expect("Check out this search engine http://google.com".autoLink()).toEqual("Check out this search engine <a href='http://google.com'>" + "http://google.com</a>");
    });
    it("does not hyperlink additional non-URL text", function() {
      return expect("LMSTFY: http://google.com and RTFM".autoLink()).toEqual("LMSTFY: <a href='http://google.com'>http://google.com</a> and RTFM");
    });
    it("correctly hyperlinks text with multiple URLs", function() {
      return expect("Google is http://google.com and Twitter is http://twitter.com".autoLink()).toEqual("Google is <a href='http://google.com'>http://google.com</a> and " + "Twitter is <a href='http://twitter.com'>http://twitter.com</a>");
    });
    it("correctly hyperlinks URLs, regardless of TLD", function() {
      return expect("Click here http://bit.ly/1337 now".autoLink()).toEqual("Click here <a href='http://bit.ly/1337'>http://bit.ly/1337</a> now");
    });
    it("correctly hyperlinks URLs, regardless of subdomain", function() {
      return expect("Check it: http://some.sub.domain".autoLink()).toEqual("Check it: <a href='http://some.sub.domain'>http://some.sub.domain</a>");
    });
    it("correctly handles punctuation", function() {
      return expect("Go here now http://google.com!".autoLink()).toEqual("Go here now <a href='http://google.com'>http://google.com</a>!");
    });
    it("sets link attributes based on the options provided", function() {
      return expect("Google it: http://google.com".autoLink({
        target: "_blank"
      })).toEqual("Google it: <a href='http://google.com' target='_blank'>" + "http://google.com</a>");
    });
    it("sets multiple link attributes if more than one is given", function() {
      return expect("Google it: http://google.com".autoLink({
        target: "_blank",
        rel: "nofollow"
      })).toEqual("Google it: <a href='http://google.com' target='_blank' " + "rel='nofollow'>http://google.com</a>");
    });
    describe("callback option", function() {
      it("can be passed to redefine how link will be rendered", function() {
        return expect("Google it: http://google.com".autoLink({
          callback: function(url) {
            return "[" + url + "](" + url + ")";
          }
        })).toEqual("Google it: [http://google.com](http://google.com)");
      });
      it("can accept other parameters", function() {
        return expect("Google it: http://google.com".autoLink({
          target: "_blank",
          rel: "nofollow",
          callback: function(url) {
            return "<a href='" + url + "'>" + url + "</a>";
          }
        })).toEqual("Google it: <a href='http://google.com'>http://google.com</a>");
      });
      return it("can return nothing", function() {
        return expect("Google it: http://google.com".autoLink({
          callback: function(url) {
            if (/\.(gif|png|jpe?g)$/i.test(url)) {
              return "<img src='" + url + "' alt='" + url + "'>";
            }
          }
        })).toEqual("Google it: <a href='http://google.com'>http://google.com</a>");
      });
    });
    return describe("html", function() {
      it("will not affect images at end", function() {
        return expect("Image <img src='http://example.com/logo.png'>".autoLink()).toEqual("Image <img src='http://example.com/logo.png'>");
      });
      it("will not affect images at beginning", function() {
        return expect("<img src='http://example.com/logo.png'> image".autoLink()).toEqual("<img src='http://example.com/logo.png'> image");
      });
      return it("will not affect anchors", function() {
        return expect("Anchor <a href='http://example.com'>http://example.com</a>".autoLink()).toEqual("Anchor <a href='http://example.com'>http://example.com</a>");
      });
    });
  });

}).call(this);
