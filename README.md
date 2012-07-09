## autolink-js

autolink-js is a small (about half a kilobyte), simple, and tested JavaScript tool that takes
a string of text, finds URLs within it, and hyperlinks them.

### Why bother releasing such a tiny little method?

I recently needed to find and hyperlink URLs in user-submitted text
and was surprised to find that doing what seemed like such a simple task wasn't already a
Solved Problem. Different regex solutions led to different unwanted side
effects, and other utilities were far, far more complex and feature rich
than I needed.

### Basic Usage

autolink-js adds an autoLink() method to JavaScript's String prototype,
so you can use it on any JavaScript string. Take a look at the tests,
but essentially, after including either autolink.js or autolink-min.js
to your page, it works like this:

```javascript
// Input
"This is a link to Google http://google.com".autoLink()

// Output
"This is a link to Google <a href='http://google.com'>http://google.com</a>"
```

### Additional Options

You can pass any additional HTML attributes to the anchor tag with a JavaScript object, like this:

```javascript
// Input
"This is a link to Google http://google.com".autoLink({ target: "_blank", rel: "nofollow", id: "1" })

// Output
"This is a link to Google <a href='http://google.com' target='_blank' rel='nofollow' id='1'>http://google.com</a>"
```

#### Callback

Callback option can be used to redefine how links will be rendered.

```javascript
// Input
"This is a link to image http://example.com/logo.png".autoLink({
  callback: function(url) {
    return /\.(gif|png|jpe?g)$/i.test(url) ? '<img src="' + url + '">' : null;
  }
});

// Output
"This is a link to image <img src='http://example.com/logo.png'>"
```

### Example

Open example/example.html in your web browser and view the source for a simple but
full-featured example of using with jQuery.

### Running the tests

After cloning this repository, simply open test/suite.html in your web
browser. The tests will run automatically.
