expect = require("chai").expect
qreq = require "qreq"
fs = require "fs"
CircleCI = require "../../src/circleci"
mockServer = require "../fixtures/mock-server"

describe "CircleCI", ->

  before -> mockServer.start(9090)
  after -> mockServer.stop()

  mockServerHost = "http://localhost:9090/api"
  ciConfig = null

  beforeEach -> ciConfig = { apiToken: "example-api-token", host: mockServerHost }
  afterEach -> ciConfig = null

  describe "#constructor", ->

    it "sets the 'apiToken' property", ->  
      ci = new CircleCI ciConfig
      expect(ci.apiToken).to.equal "example-api-token"

    it "sets the 'version' property to 'v1' by default", ->
      delete ciConfig.version
      ci = new CircleCI ciConfig
      expect(ci.version).to.equal "v1"

    it "sets the 'version' property", ->
      ciConfig.version = "v2"
      ci = new CircleCI ciConfig
      expect(ci.version).to.equal "v2"

  describe "#init", ->

    it "returns an instance of CircleCI object", ->
      ci = CircleCI.init ciConfig
      expect(ci).to.be.instanceof CircleCI

    it "is an alias for 'new CircleCI'"

  describe "v1 api", ->

    describe "#getUser", ->

      expectedUser = require("../mocks/v1/me")
      ci = null

      beforeEach -> ci = new CircleCI ciConfig
      afterEach -> ci = null

      it "returns the current user object", ->
        ci.getUser (err, user) ->
          expect(user).to.deep.equal expectedUser

    describe "#getProject()", ->

      expectedProjects = require "../mocks/v1/projects"
      ci = null

      beforeEach -> ci = new CircleCI ciConfig
      afterEach -> ci = null

      it "returns an array of projects", ->
        ci.getProjects (err, projects) ->
          expect(projects).to.be.instanceof Array
          expect(projects).to.deep.equal expectedProjects