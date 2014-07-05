CircleCI = require "../../src/circleci"

describe "getBuilds", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config = { username: "FundingCircle", project: "fc-quatro", limit: 1 }
    
  it "returns an array of builds for a given project", (done) ->

    @circleci.getBuilds(@config).then (res) ->
      expect(res).to.be.ok
      expect(res).to.be.instanceof Array
      expect(res.length).to.equal 1
      done()
