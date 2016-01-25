CircleCI = require "../../src/circleci"

describe "getTestMetadata", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      build_num: "7"

  it "returns an array of the test metadata for a given build", (done) ->

    @circleci.getTestMetadata(@config).then (res) ->
      expect(res).to.be.ok
      expect(res).to.be.instanceof Array
      expect(res.length).to.equal 5
      done()
