CircleCI = require "../../src/circleci"

describe "getBuildArtifacts", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "FundingCircle", project: "fc-quatro", build_num: "10" }

  it "returns the build artifacts", (done) ->
    @circleci.getBuildArtifacts(@config).then (res) ->
      expect(res).to.be.ok
      done()
