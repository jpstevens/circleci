CircleCI = require "../../src/circleci"

describe "getProjects", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
  
  it "returns the recent projects", (done) ->
    
    @circleci.getProjects().then (res) ->
      expect(res).to.be.ok
      expect(res).to.be.instanceof Array
      done()
