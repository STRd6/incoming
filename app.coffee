H = require "hyperweb"
app = H.blastOff()

postEmail = require "./post_email"

get "/hello", ->
  "heyy"

post "/", ({mandrill_events}) ->
  unless mandrill_events
    throw "Not cool"

  events = JSON.parse(mandrill_events)

  events.map postEmail

  "OK"

post "/email", (data) ->
  console.log data

  "OK"
