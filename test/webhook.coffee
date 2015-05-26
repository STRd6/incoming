nock = require "nock"
postEmail = require "../post_email"

sampleEvent = require "./sample_event"

describe "posting an email", ->
  it "should post to the url given in the email address", (done) ->
    nock("http://example.hyperweb.space")
    .post("/email")
    .reply(200)

    postEmail(JSON.parse(sampleEvent.mandrill_events)[0])
    .then ->
      done()
    .fail (e) ->
      console.error e
      done(e)

  it "should not post to weird or invalid subdomains", (done) ->
    postEmail
      msg:
        to: "invalid.subdomain@hyperweb.space"
    .fail (error) ->
      assert.equal error, "Invalid subdomain"
      done()
