CircleCI = require "../../src/circleci"

describe "startBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "FundingCircle", project: "fc-quatro", branch: "master" }
  
  it "starts the build", (done) ->
    @circleci.startBuild(@config).then (res) ->
      expect(res).to.be.ok
      done()
