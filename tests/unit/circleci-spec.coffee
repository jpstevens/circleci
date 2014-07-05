CircleCI = require "../../src/circleci"

describe "CircleCI Client", ->

  describe "initializing without an api token", ->

    it "throws an error", ->
      expect(-> new CircleCI()).to.throw

  describe "calling", ->

    before ->
      @circleci = new CircleCI { auth: "example-token" }

    beforeEach ->
      @processSpy = sinon.spy(@circleci.request, "process")

    afterEach ->
      @circleci.request.process.restore()

    describe "getUser", ->
      
      before ->
        @route = { path: "/me", method: "GET" }

      it "gets the current user", ->
        @circleci.getUser()
        expect(@processSpy.args[0][0]).to.deep.equal @route
        expect(@processSpy.args[0][1]).to.not.exist
    
    describe "getProjects", ->

      before ->
        @route = { path: "/projects", method: "GET" }
      
      it "gets the projects", ->
        @circleci.getProjects()
        expect(@processSpy.args[0][0]).to.deep.equal @route
        expect(@processSpy.args[0][1]).to.not.exist

    describe "getRecentBuilds", ->

      before ->
        @route = { path: "/recent-builds", method: "GET", options: ["limit", "offset"] }
        @options = { limit: 10, offset: 100 }
      
      describe "without options", ->

        it "gets the recent build", ->
          @circleci.getRecentBuilds()
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.not.exist

      describe "with options", ->

        it "gets the recent builds", ->
          @circleci.getRecentBuilds(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

    describe "getBuilds", ->

      before ->
        @route = { path: "/project/:username/:project", method: "GET", options: ["limit", "offset"] }
        @options = { username: "jpstevens", project: "circleci", limit: 10, offset: 100 }
      
      it "gets the builds for a project", ->
          @circleci.getBuilds(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when 'username' and 'project' are missing", ->
        expect(-> @circleci.getProject()).to.throw

    describe "getBuild", ->

      before ->
        @route = { path: "/project/:username/:project/:build_num", method: "GET" }
        @options = { username: "jpstevens", project: "circleci", build_num: 123 }
      
      it "getting a single build for a project", ->
          @circleci.getBuild(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when options are missing", ->
        expect(-> @circleci.getBuild()).to.throw

    describe "getBuildArtifacts", ->

      before ->
        @route = { path: "/project/:username/:project/:build_num/artifacts", method: "GET" }
        @options = { username: "jpstevens", project: "circleci", build_num: 123 }
      
      it "gets the artifacts for a build", ->
          @circleci.getBuildArtifacts(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when options are missing", ->
        expect(-> @circleci.getBuildArtifacts()).to.throw

    describe "retryBuild", ->

      before ->
        @route = { path: "/project/:username/:project/:build_num/retry", method: "POST" }
        @options = { username: "jpstevens", project: "circleci", build_num: 123 }
      
      it "retries the build", ->
          @circleci.retryBuild(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when 'username', 'project' or 'build_num' are missing", ->
        expect(-> @circleci.retryBuild()).to.throw

    describe "cancelBuild", ->

      before ->
        @route = { path: "/project/:username/:project/:build_num/cancel", method: "POST" }
        @options = { username: "jpstevens", project: "circleci", build_num: 123 }
      
      it "cancels a build", ->
          @circleci.cancelBuild(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when options are missing", ->
        expect(-> @circleci.cancelBuild()).to.throw

    describe "startBuild", ->

      before ->
        @route = { path: "/project/:username/:project/tree/:branch", method: "POST" }
        @options = { username: "jpstevens", project: "circleci", branch: "master" }
      
      it "starts a build", ->
          @circleci.startBuild(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when options are missing", ->
        expect(-> @circleci.startBuild()).to.throw

    describe "clearBuildCache", ->

      before ->
        @route = { path: "/project/:username/:project/build-cache", method: "DELETE" }
        @options = { username: "jpstevens", project: "circleci" }
      
      it "clears the cache for a project", ->
          @circleci.clearBuildCache(@options)
          expect(@processSpy.args[0][0]).to.deep.equal @route
          expect(@processSpy.args[0][1]).to.deep.equal @options

      it "throws an error when options are missing", ->
        expect(-> @circleci.clearBuildCache()).to.throw

