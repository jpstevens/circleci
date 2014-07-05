CircleCIRequest = require "../../src/circleci-request"
q = require "q"

describe "CircleCI Request", ->

  before -> 
    @request = new CircleCIRequest { auth : "example-token" }

  describe "handle response", ->

    beforeEach ->
      @deferred = q.defer()
      @handler = @request.handleResponse @deferred
      
    it "passes if there is a successful response", (done) ->
      res = { statusCode: 200, body: true }
      @deferred.promise.then (body) ->
        expect(body).to.be.ok
        done()
      @handler(res)

    it "fails if there is a server error in the response", ->
      res = { statusCode: 500 }
      @deferred.promise.fail (err) ->
        expect(err).to.be.typeof Error
        done()
      @handler(res)

    it "fails if there is a client error in the response", ->
      res = { statusCode: 400 }
      @deferred.promise.fail (err) ->
        expect(err).to.be.typeof Error
        done()
      @handler(res)

  describe "injecting params", ->

    it "injects username, project and build_num into the url string", ->
      expect(@request.injectParams "/:username/:project/:build_num", {
        project: "circleci"
        username: "jpstevens"
        build_num: 123
      }).to.equal "/jpstevens/circleci/123"

    it "throws an error if an injectable value isn't provided", ->
      expect(-> @request.injectParams "/:username", {}).to.throw

  describe "building a URL", ->

    it "generates the base API url with an auth token by default", ->
      expect @request.buildUrl()
      .to.equal "https://circleci.com/api/v1?circle-token=example-token"

    it "can build a URL from a path", ->
      expect @request.buildUrl("projects")
      .to.equal "https://circleci.com/api/v1/projects?circle-token=example-token"

    it "can build a URL from a path with query params", ->
      expect @request.buildUrl("projects", { limit: 10 })
      .to.equal "https://circleci.com/api/v1/projects?limit=10&circle-token=example-token"

    it "can build a URL from a path with url params", ->
      expect @request.buildUrl("project/:username/:project", {}, { project: "circleci", username: "jpstevens" })
      .to.equal "https://circleci.com/api/v1/project/jpstevens/circleci?circle-token=example-token"

  describe "building query object", ->

    it "doesn't error if options is undefined", ->
      expect(-> @request.buildQueryObject undefined, {}).to.not.throw

    it "returns valid query params only", ->
      params = { limit: 10, offset: 0, fake: "oh, no" }
      expect(@request.buildQueryObject ["limit", "offset"], params).to.deep.equal { limit: 10, offset: 0 }

  describe "building request config", ->

    before ->
      @route = { path: "/:param/endpoint", method: "GET", options: ["limit", "offset"] }
      @data = { param: "example", limit: 10, offset: 10 }
      @expectedConfig = 
        method: "GET"
        url: "https://circleci.com/api/v1/example/endpoint?limit=10&offset=10&circle-token=example-token"
        json: true

    it "builds the expected config object", ->
      expect(@request.buildRequestConfig @route, @data).to.deep.equal @expectedConfig
      
  describe "processing the request", ->

    before ->
      @route = { path: "/:param/endpoint", method: "GET", options: ["limit", "offset"] }
      @data = { param: "example", limit: 10, offset: 10 }
      @expectedConfig = 
        method: "GET"
        url: "https://circleci.com/api/v1/example/endpoint?limit=10&offset=10&circle-token=example-token"
        json: true

    beforeEach ->
      @requestSpy = sinon.spy @request, "request"

    afterEach ->
      @request.request.restore()

    it "makes the correct request", ->
      @request.process @route, @data
      expect(@requestSpy.calledWith @expectedConfig).to.be.ok
