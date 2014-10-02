request = require "request"

exports.createBuild = (callback) ->
  config =
      method: "POST"
      url: "https://circleci.com/api/v1/project/jpstevens/circleci/tree/master?circle-token=#{process.env.CIRCLE_TOKEN}"
      json: true
    request config, (err, res) ->
      throw new Error "Unable to create new build" if err
      callback res.body.build_num

exports.cancelBuild = (build_num, callback) ->
  config =
      method: "POST"
      url: "https://circleci.com/api/v1/project/jpstevens/circleci/#{build_num}/cancel?circle-token=#{process.env.CIRCLE_TOKEN}"
      json: true
    request config, (err, res) ->
      throw new Error "Unable to cancel build ##{build_num}" if err
      callback res.body.build_num

