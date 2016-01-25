CircleCI = require "../../src/circleci"

describe "getUser", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }

  it "returns the current user", (done) ->

    @circleci.getUser().then (res) ->
      expect(res).to.be.ok
      done()
