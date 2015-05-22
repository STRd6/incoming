# BEGIN Boring section
Request = require "request"

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
# END Boring section
# Boring section should be handled by HyperWeb for you

post "/", (req, res) ->
  {mandrill_events} = req.body

  mandrill_events = JSON.parse(mandrill_events)
  console.dir req.body
  console.dir mandrill_events

  mandrill_events.forEach ({msg}) ->
    {to, text} = msg

    subdomain = to[0][0].split('@')[0]

    Request.post "http://#{subdomain}.hyperweb.space/email",
      json:
        message: text
    , (error, response, body) ->
      console.log body

    console.log "-----"
    console.log to
    console.log text

  res.send "Cool"

post "/email", (req, res) ->
  data = req.body

  console.log data

  res.send "OK"
