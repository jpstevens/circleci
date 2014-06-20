expect = require("chai").expect
RequestGenerator = require "../../src/url-generator"

describe "urlGenerator", ->
  
  describe "#constructor", ->

    describe "the 'host' property", ->

      it "can be set", ->
        rg = new RequestGenerator { host: "example" }
        expect(rg.host).to.equal "example"

      it "defaults to 'https://circleci.com'", ->
        rg = new RequestGenerator {}
        expect(rg.host).to.equal "https://circleci.com"

    describe "the 'version' property", ->

      it "can be set", ->
        rg = new RequestGenerator { version: "v2" }
        expect(rg.version).to.equal "v2"

      it "defaults to 'v1'", ->
        rg = new RequestGenerator {}
        expect(rg.version).to.equal "v1"

    describe "the 'apiToken' property", ->

      it "can be set", ->
        rg = new RequestGenerator { apiToken: "example-token" }
        expect(rg.apiToken).to.equal "example-token"

      it "has no default", ->
        rg = new RequestGenerator {}
        expect(rg.apiToken).to.not.exist

  describe "#getBaseUrl", ->

    it "returns the default url of 'https://circleci.com/api/v1'", ->
      rg = new RequestGenerator {}
      expect(rg.getBaseUrl()).to.equal "https://circleci.com/api/v1"

    it "returns the expected url", ->
      rg = new RequestGenerator { host: "http://localhost:8080", version: "v1" }
      expect(rg.getBaseUrl()).to.equal "http://localhost:8080/api/v1"

  describe "#getQueryString", ->

    it "defaults to returning '?circle_token=[api-token]', if 'apiToken' is set", ->
      rg = new RequestGenerator { apiToken: "example-token" }
      expect(rg.getQueryString()).to.equal "?circleci_token=example-token"

    it "returns the expected query string", ->
      rg = new RequestGenerator { apiToken: "example-token" }
      expect(rg.getQueryString { limit: 5, offset: 100 }).to.equal "?circleci_token=example-token&limit=5&offset=100"

  describe "#injectParam", ->

    rg = null

    beforeEach -> rg = new RequestGenerator {apiToken : "example-token"}
    afterEach -> rg = null

    it "can inject a single param into a url string", ->  
      expect rg.injectParams "project/:project/:project-example", { project: "1234" }
      .to.equal "project/1234/:project-example"

    it "can inject a single param into a url string, multiple times", ->
      expect rg.injectParams "project/:project/:project", { project: "1234" }
      .to.equal "project/1234/1234"

    it "doesn't mistake similar namespaces (e.g. :name != :namespace)", ->
      # ...
      expect rg.injectParams "project/:project-number/:project", { project: "1234" }
      .to.equal "project/:project-number/1234"

    it "can inject multiple params into a url string", ->
      expect rg.injectParams "project/:project-number/:project", { project: "1234", 'project-number': 567 }
      .to.equal "project/567/1234"

  describe "#getUrl", ->

    it "defaults to 'https://circleci.com/api/v1?circleci_token=example-token'", ->
      rg = new RequestGenerator { apiToken: "example-token" }
      expect(rg.getUrl()).to.equal "https://circleci.com/api/v1?circleci_token=example-token"

    it "generates the expected url for a given path (without params)", ->
      rg = new RequestGenerator { apiToken: "example-token" }
      config = { params: { project: "circleci", username: "jpstevens", build_num: 123 }, query: { limit: 10, offset: 200 }}
      expect(rg.getUrl "project/:username/:project/:build_num", config)
      .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/123?circleci_token=example-token&limit=10&offset=200"

