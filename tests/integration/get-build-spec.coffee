CircleCI = require "../../src/circleci"

describe "getBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      build_num: "7"

  it "returns the build", (done) ->

    @circleci.getBuild(@config).then (res) ->
      expect(res).to.be.ok
      done()
