request = require "request"

baseUrl = "https://circleci.com/api/v1/project"
projectUrl = "#{baseUrl}/#{process.env.CIRCLE_USER}/#{process.env.CIRCLE_PROJECT}"

exports.createBuild = (callback) ->
  url = "#{projectUrl}/tree/master?circle-token=#{process.env.CIRCLE_TOKEN}"
  config =
    method: "POST"
    url: url
    json: true
  request config, (err, res) ->
    throw new Error "Unable to create new build" if err
    callback res.body.build_num

exports.cancelBuild = (build_num, callback) ->
  url = "#{projectUrl}/#{build_num}/cancel?circle-token=#{process.env.CIRCLE_TOKEN}"
  config =
    method: "POST"
    url: url
    json: true
  request config, (err, res) ->
    throw new Error "Unable to cancel build ##{build_num}" if err
    callback res.body.build_num
