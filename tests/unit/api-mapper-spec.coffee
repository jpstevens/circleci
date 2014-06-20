expect = require("chai").expect
ApiMapper = require "../../src/api-mapper"

describe "ApiMapper", ->

  describe "#constructor", ->

    it "sets the 'ug' property to a new UrlGenerator", ->
      mapper = new ApiMapper()
      UrlGenerator = require "../../src/url-generator"
      expect(mapper.ug).to.be.instanceof UrlGenerator

  describe "#getUrl", ->
    
    mapper = null

    before -> mapper = new ApiMapper { apiToken: "example-token" }
    after -> mapper = null

    describe "getUser", ->

      it "returns the expected url", ->
        expect mapper.getUrl "getUser"
        .to.equal "https://circleci.com/api/v1/me?circleci_token=example-token"
        
    describe "getRecentProjects", ->

      it "returns the expected url", ->
        expect mapper.getUrl "getRecentProjects"
        .to.equal "https://circleci.com/api/v1/projects?circleci_token=example-token"

      describe "with 'offset'", ->

        it "returns the expected url, containing the offset query param", ->
          expect mapper.getUrl "getRecentProjects", { offset: 5 }
          .to.equal "https://circleci.com/api/v1/projects?circleci_token=example-token&offset=5"

      describe "with 'limit'", ->

        it "returns the expected url, containing the limit query param", ->
          expect mapper.getUrl "getRecentProjects", { limit: 5 }
          .to.equal "https://circleci.com/api/v1/projects?circleci_token=example-token&limit=5"

    describe "getProject", ->
      
      it "returns the expected url", ->
          expect mapper.getUrl "getProject", { username: "jpstevens", project: "circleci" }
          .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci?circleci_token=example-token"

    describe "getRecentBuilds", ->

      it "returns the expected url", ->
        expect mapper.getUrl "getRecentBuilds"
        .to.equal "https://circleci.com/api/v1/recent-builds?circleci_token=example-token"

      describe "with 'offset'", ->

        it "returns the expected url, containing the offset query param", ->
          expect mapper.getUrl "getRecentBuilds", { offset: 5 }
          .to.equal "https://circleci.com/api/v1/recent-builds?circleci_token=example-token&offset=5"

      describe "with 'limit'", ->

        it "returns the expected url, containing the limit query param", ->
          expect mapper.getUrl "getRecentBuilds", { limit: 5 }
          .to.equal "https://circleci.com/api/v1/recent-builds?circleci_token=example-token&limit=5"

    describe "getBuild", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "getBuild", { username: "jpstevens", project: "circleci", build_num: 123 }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/123?circleci_token=example-token"

    describe "startBuild", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "startBuild", { username: "jpstevens", project: "circleci", branch: "master" }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/tree/master?circleci_token=example-token"

    describe "cancelBuild", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "cancelBuild", { username: "jpstevens", project: "circleci", build_num: 123 }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/123/cancel?circleci_token=example-token"

    describe "retryBuild", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "retryBuild", { username: "jpstevens", project: "circleci", build_num: 123 }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/123/retry?circleci_token=example-token"

    describe "getBuildArtifacts", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "getBuildArtifacts", { username: "jpstevens", project: "circleci", build_num: 123 }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/123/artifacts?circleci_token=example-token"

    describe "clearBuildCache", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "clearBuildCache", { username: "jpstevens", project: "circleci" }
        .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci/build-cache?circleci_token=example-token"

    describe "addSSHKey", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "addSSHKey"
        .to.equal "https://circleci.com/api/v1/user/ssh-key?circleci_token=example-token"

    describe "addHerokuKey", ->
      
      it "returns the expected url", ->
        expect mapper.getUrl "addHerokuKey"
        .to.equal "https://circleci.com/api/v1/user/heroku-key?circleci_token=example-token"

  describe "#getMethod", ->

    mapper = null

    before -> mapper = new ApiMapper { apiToken: "example-token" }
    after -> mapper = null

    it "returns 'GET' for 'getUser'", -> expect(mapper.getMethod("getUser")).to.equal "GET"

    it "returns 'GET' for 'getRecentProjects'", -> expect(mapper.getMethod("getRecentProjects")).to.equal "GET"

    it "returns 'GET' for 'getProject'", -> expect(mapper.getMethod("getProject")).to.equal "GET"

    it "returns 'GET' for 'getRecentBuilds'", -> expect(mapper.getMethod("getRecentBuilds")).to.equal "GET"

    it "returns 'GET' for 'getBuild'", -> expect(mapper.getMethod("getBuild")).to.equal "GET"

    it "returns 'POST' for 'startBuild'", -> expect(mapper.getMethod("startBuild")).to.equal "POST"

    it "returns 'POST' for 'cancelBuild'", -> expect(mapper.getMethod("cancelBuild")).to.equal "POST"

    it "returns 'POST' for 'retryBuild'", -> expect(mapper.getMethod("retryBuild")).to.equal "POST"

    it "returns 'GET' for 'getBuildArtifacts'", -> expect(mapper.getMethod("getBuildArtifacts")).to.equal "GET"

    it "returns 'DELETE' for 'clearBuildCache'", -> expect(mapper.getMethod("clearBuildCache")).to.equal "DELETE"

    it "returns 'POST' for 'addSSHKey'", -> expect(mapper.getMethod("addSSHKey")).to.equal "POST"

    it "returns 'POST' for 'addHerokuKey'", -> expect(mapper.getMethod("addHerokuKey")).to.equal "POST"


  describe "#getRequestObject", ->

    mapper = null

    before -> mapper = new ApiMapper { apiToken: "example-token" }
    after -> mapper = null

    it "returns a promise"

    it "makes a request with qreq using the correct method and url"
