CircleCI = require "../../src/circleci"

describe "getBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "jpstevens", project: "circleci", build_num: "10" }

  it "returns the build", (done) ->

    @circleci.getBuild(@config).then (res) ->
      expect(res).to.be.ok
      done()
