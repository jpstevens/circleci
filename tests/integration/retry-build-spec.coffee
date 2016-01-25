CircleCI = require "../../src/circleci"
APIHelper = require "../helpers/api-helper"

describe "retryBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      build_num: "7"

  it "retries the build", (done) ->
    @circleci.retryBuild(@config).then (res) ->
      expect(res).to.be.ok
      APIHelper.cancelBuild res.build_num, -> done()
