expect = require("chai").expect
qreq = require "qreq"
fs = require "fs"
CircleCI = require "../../src/circleci"
mockServer = require "../fixtures/mock-server"

describe "CircleCI", ->

  before -> mockServer.start(9090)
  after -> mockServer.stop()

  mockServerHost = "http://localhost:9090"
  ciConfig = null

  beforeEach -> ciConfig = { apiToken: "example-api-token", host: mockServerHost }
  afterEach -> ciConfig = null

  describe "#init", ->

    it "returns an instance of CircleCI object", ->
      ci = CircleCI.init ciConfig
      expect(ci).to.be.instanceof CircleCI

    it "is an alias for 'new CircleCI'"

  describe "#makeRequest", ->

    it "returns a promise object"

    it "executes a callback, with signature (err, resource)"

  describe "v1 api", ->

    ci = null

    beforeEach -> ci = new CircleCI ciConfig
    afterEach -> ci = null

    describe "#getUser", ->

      expectedUser = require("../mocks/v1/me")

      it "returns the current user object", (done) ->
        ci.getUser (err, user) ->
          expect(user).to.deep.equal expectedUser
          done()

    describe "#getRecentProjects", ->

      expected = require "../mocks/v1/projects"

      it "returns an array of projects", (done) ->
        ci.getRecentProjects (err, projects) ->
          expect(projects).to.be.instanceof Array
          expect(projects).to.deep.equal expected
          done()