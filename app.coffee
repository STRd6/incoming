# BEGIN Boring section
Express = require "express"
app = Express()

app.use require('body-parser').json()
app.use require('body-parser').text()
app.use require('body-parser').urlencoded()

# Would listening here block someone from
# running their own stock express app
# without using HyperWeb magic?
app.listen process.env.PORT or 5000

post = (path, cb) ->
  app.post path, cb

get = (path, cb) ->
  app.get path, cb

# END Boring section
# Boring section should be handled by HyperWeb for you

postEmail = require "./post_email"

get "/hello", (req, res) ->
  res.send "heyy"

post "/", (req, res) ->
  {mandrill_events} = req.body

  unless mandrill_events
    res
    .status 400
    .send "Not cool"
    return

  events = JSON.parse(mandrill_events)

  events.map postEmail

  res
  .status 204
  .send()

post "/email", (req, res) ->
  data = req.body

  console.log data

  res.send "OK"
