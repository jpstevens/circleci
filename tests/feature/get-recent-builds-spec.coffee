CircleCI = require "../../src/circleci"

describe "getRecentBuilds", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    
  it "returns an array of recent builds", (done) ->

    @circleci.getRecentBuilds({ limit: 1 }).then (res) ->
      expect(res).to.be.ok
      expect(res).to.be.instanceof Array
      expect(res.length).to.equal 1
      done()
