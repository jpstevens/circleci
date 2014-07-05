CircleCI = require "../../src/circleci"
APIHelper = require "../helpers/api-helper"

describe "cancelBuild", ->

  before (next) ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    APIHelper.createBuild (build_num) =>
      @config = { username: "FundingCircle", project: "fc-quatro", build_num }
      next()

  it "cancels the build", (done) ->
    
    @circleci.cancelBuild(@config).then (res) ->
      expect(res).to.be.ok
      done()
