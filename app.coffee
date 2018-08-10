_ = require('wegweg')({
  globals: on
})

SUBSCRIPTIONS = []
KEYS = JSON.parse(_.reads './keys.json')

webpush = require 'web-push'
webpush.setVapidDetails('mailto:email@email.com',KEYS.publicKey,KEYS.privateKey)

app = _.app({body_parser:true})

app.get '/', (req,res,next) ->
  res.set 'content-type', 'text/html'
  return res.end _.reads('./index.html')

app.post '/store', (req,res,next) ->
  log 'POST store'
  subscription = JSON.parse(req.body.subscription)
  log subscription

  exists = false

  for item in SUBSCRIPTIONS
    if item.endpoint is subscription.endpoint
      exists = true
      break

  if !exists
    SUBSCRIPTIONS.push(subscription)

  return res.json true

app.get '/subscriptions', (req,res,next) ->
  return res.json SUBSCRIPTIONS

app.get '/send-all', (req,res,next) ->
  for item in SUBSCRIPTIONS
    webpush
      .sendNotification(item,data = _.uuid())
      .then -> 1

  return res.json SUBSCRIPTIONS?.length ? 0

app.get '/worker.coffee', (req,res,next) ->
  bulk = _.reads './worker.coffee'
  bulk = require('coffee-script').compile(bulk,{bare:yes})
  res.set 'content-type', 'text/javascript'
  return res.end bulk

app.get '/script.coffee', (req,res,next) ->
  bulk = _.reads './script.coffee'
  bulk = require('coffee-script').compile(bulk,{bare:yes})
  res.set 'content-type', 'text/javascript'
  return res.end bulk

app.listen 8000
log ":8000"

