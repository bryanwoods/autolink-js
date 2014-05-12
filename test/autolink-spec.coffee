describe "autolink", ->
  it "can be called on a string", ->
    expect("hi there".autoLink()).toBeDefined()

  it "does not alter a string with no URL present", ->
    expect("hi again".autoLink()).toEqual("hi again")

  it "returns the string with the URLs hyperlinked", ->
    expect("Check out this search engine http://google.com".autoLink()).
    toEqual(
      "Check out this search engine <a href='http://google.com'>" +
      "http://google.com</a>"
    )

  it "does not hyperlink additional non-URL text", ->
    expect("LMSTFY: http://google.com and RTFM".autoLink()).
    toEqual(
      "LMSTFY: <a href='http://google.com'>http://google.com</a> and RTFM"
    )

  it "correctly hyperlinks text with multiple URLs", ->
    expect(
      "Google is http://google.com and Twitter is http://twitter.com".autoLink()
    ).toEqual(
      "Google is <a href='http://google.com'>http://google.com</a> and " +
      "Twitter is <a href='http://twitter.com'>http://twitter.com</a>"
    )

  it "correctly hyperlinks URLs, regardless of TLD", ->
    expect("Click here http://bit.ly/1337 now".autoLink()).
    toEqual(
      "Click here <a href='http://bit.ly/1337'>http://bit.ly/1337</a> now"
    )

  it "correctly hyperlinks URLs, regardless of subdomain", ->
    expect("Check it: http://some.sub.domain".autoLink()).
    toEqual(
      "Check it: <a href='http://some.sub.domain'>http://some.sub.domain</a>"
    )

  it "correctly handles punctuation", ->
    expect("Go here now http://google.com!".autoLink()).
    toEqual(
      "Go here now <a href='http://google.com'>http://google.com</a>!"
    )

  it "correctly handles hash character(#)", ->
    expect("Go here now http://google.com/#query=index".autoLink()).
    toEqual(
      "Go here now <a href='http://google.com/#query=index'>http://google.com/#query=index</a>"
    )

  it "correctly handles escaped fragment character(#!)", ->
    expect("Go here now http://twitter.com/#!/PostDeskUK".autoLink()).
    toEqual(
      "Go here now <a href='http://twitter.com/#!/PostDeskUK'>http://twitter.com/#!/PostDeskUK</a>"
    )

  it "correctly handles parentheses ()", ->
    expect("My favorite Wikipedia Article http://en.wikipedia.org/wiki/Culture_of_honor_(Southern_United_States)".autoLink()).
    toEqual(
      "My favorite Wikipedia Article <a href='http://en.wikipedia.org/wiki/Culture_of_honor_(Southern_United_States)'>http://en.wikipedia.org/wiki/Culture_of_honor_(Southern_United_States)</a>"
    )

  it "allows single right quotes", ->
    expect("Safety for Syria’s Women http://www.rescue.org/press-releases/syria’s-women-and-girls-continue-face-chaos-and-danger-fearing-their-safety-18565".autoLink()).
      toEqual(
        "Safety for Syria’s Women <a href='http://www.rescue.org/press-releases/syria’s-women-and-girls-continue-face-chaos-and-danger-fearing-their-safety-18565'>http://www.rescue.org/press-releases/syria’s-women-and-girls-continue-face-chaos-and-danger-fearing-their-safety-18565</a>"
      )


  it "correctly handles FTP links", ->
    expect("Click here ftp://ftp.google.com".autoLink()).
    toEqual(
      "Click here <a href='ftp://ftp.google.com'>ftp://ftp.google.com</a>"
    )

  it "sets link attributes based on the options provided", ->
    expect("Google it: http://google.com".autoLink(target: "_blank")).
    toEqual(
      "Google it: <a href='http://google.com' target='_blank'>" +
      "http://google.com</a>"
    )

  it "sets multiple link attributes if more than one is given", ->
    expect(
      "Google it: http://google.com".autoLink(target: "_blank", rel: "nofollow")
    ).toEqual(
      "Google it: <a href='http://google.com' target='_blank' " +
      "rel='nofollow'>http://google.com</a>"
    )

  xit "correctly handles surrounding HTML tags", ->
    expect("<p>http://nba.com</p>".autoLink()).
    toEqual("<p><a href='http://nba.com'>http://nba.com</a></p>")

  it "can begin with a hyperlink", ->
    expect("http://google.com That is a link to Google".autoLink()).
      toEqual(
        "<a href='http://google.com'>http://google.com</a> " +
        "That is a link to Google"
      )

  it "can have a hyperlink as first part of a new line", ->
    expect("I think I can help you.\nhttp://google.com That is a link to Google".autoLink()).
      toEqual(
        "I think I can help you.\n" +
        "<a href='http://google.com'>http://google.com</a> " +
        "That is a link to Google"
      )

  it "can have a hyperlink as first part of a new HTML line", ->
    expect("I think I can help you.<br>http://google.com That is a link to Google".autoLink()).
      toEqual(
        "I think I can help you.<br>" +
        "<a href='http://google.com'>http://google.com</a> " +
        "That is a link to Google"
      )

  describe "callback option", ->
    it "can be passed to redefine how link will be rendered", ->
      expect("Google it: http://google.com"
      .autoLink({callback: (url) -> "[#{url}](#{url})"}))
      .toEqual("Google it: [http://google.com](http://google.com)")

    it "can accept other parameters", ->
      expect("Google it: http://google.com"
      .autoLink({target: "_blank", rel: "nofollow", callback: (url) -> "<a href='#{url}'>#{url}</a>"}))
      .toEqual("Google it: <a href='http://google.com'>http://google.com</a>")

    it "can return nothing", ->
      expect("Google it: http://google.com"
      .autoLink({callback: (url) -> "<img src='#{url}' alt='#{url}'>" if /\.(gif|png|jpe?g)$/i.test(url)}))
      .toEqual("Google it: <a href='http://google.com'>http://google.com</a>")

  describe "html", ->
    it "will not affect images", ->
      expect("Image <img src='http://example.com/logo.png'>".autoLink())
      .toEqual("Image <img src='http://example.com/logo.png'>")
    it "will not affect anchors", ->
      expect("Anchor <a href='http://example.com'>http://example.com</a>".autoLink())
      .toEqual("Anchor <a href='http://example.com'>http://example.com</a>")
    it "will still work", ->
      expect("Anchor <a href='http://example.com'>http://example.com</a> to http://example.com".autoLink())
      .toEqual("Anchor <a href='http://example.com'>http://example.com</a> to <a href='http://example.com'>http://example.com</a>")
