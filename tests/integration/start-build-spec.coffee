CircleCI = require "../../src/circleci"
APIHelper = require "../helpers/api-helper"

describe "startBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "jpstevens", project: "circleci", branch: "master" }

  it "starts the build", (done) ->
    @circleci.startBuild(@config).then (res) ->
      expect(res).to.be.ok
      APIHelper.cancelBuild res.build_num, -> done()
