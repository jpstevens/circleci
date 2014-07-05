CircleCI = require "../../src/circleci"

describe "getBuild", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "FundingCircle", project: "fc-quatro", build_num: "10" }
  
  it "returns the build", (done) ->
    
    @circleci.getBuild(@config).then (res) ->
      expect(res).to.be.ok
      done()
