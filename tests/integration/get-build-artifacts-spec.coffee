CircleCI = require "../../src/circleci"

describe "getBuildArtifacts", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "jpstevens", project: "circleci", build_num: "10" }

  it "returns the build artifacts", (done) ->
    @circleci.getBuildArtifacts(@config).then (res) ->
      expect(res).to.be.ok
      done()
