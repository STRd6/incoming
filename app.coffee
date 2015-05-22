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
# END Boring section
# Boring section should be handled by HyperWeb for you

post "/", (req, res) ->
  {mandrill_events} = req.body

  console.dir req.body
  console.dir mandrill_events

  mandrill_events.forEach ({msg}) ->
    {to, text} = msg

    console.log "-----"
    console.log to
    console.log txt

  res.send "Cool"
