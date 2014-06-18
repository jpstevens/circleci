express = require "express"
bodyParser = require "body-parser"
fs = require "fs"
path = require "path"

app = express()
server = null

exports.start = (port) ->
  app.set 'port', process.env.PORT or port
  app.set 'version', process.env.VERSION or 'v1'
  app.use bodyParser()

  for version in fs.readdirSync path.resolve(__dirname, "./api")
    if version.indexOf(".") isnt 0 then app.use '/api', require "./api/#{version}"

  server = app.listen app.get('port'), ->
    console.log "CircleCI mock server listening on port #{app.get('port')}"

exports.stop = ->
  server.close()