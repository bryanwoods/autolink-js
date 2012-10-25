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
