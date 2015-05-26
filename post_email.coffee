Q = require "q"
Request = require "request"

addressToSubdomain = (address) ->
  nameRegex = /^([A-Za-z0-9-]+)@/

  address.match(nameRegex)?[1]

module.exports = ({msg}) ->
  deferred = Q.defer()
  {to, text} = msg

  subdomain = addressToSubdomain(to[0][0])

  if subdomain
    Request.post "http://#{subdomain}.hyperweb.space/email",
      json:
        message: text
    , (error, response, body) ->
      if error
        deferred.reject(error)
      else
        deferred.resolve(body)

    console.log "-----"
    console.log to
    console.log text
  else
    deferred.reject "Invalid subdomain"

  return deferred.promise
