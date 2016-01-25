CircleCI = require "../../src/circleci"

describe "getBranchBuilds", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      branch: "master"
      limit: 1

  it "returns an array of builds for a given project on a branch", (done) ->

    @circleci.getBranchBuilds(@config).then (res) ->
      expect(res).to.be.ok
      expect(res).to.be.instanceof Array
      expect(res.length).to.equal 1
      done()
