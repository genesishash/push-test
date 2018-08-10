_ = require('wegweg')({
  globals: on
})

wp = require 'web-push'

keys = wp.generateVAPIDKeys()

log JSON.stringify(keys,null,2)


