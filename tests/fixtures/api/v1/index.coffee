router = new require("express").Router()

router
.get '/me', (req, res) ->
  res.json require "../../../mocks/v1/me"

router
.get '/projects', (req, res) ->
  res.json require "../../../mocks/v1/projects"

router
.get '/project/:username/:project', (req, res) ->
  json = require "../../../mocks/v1/project"
  json[0].username = req.params.username
  json[0].reponame = req.params.project
  res.json json

router
.get '/project/:username/:project/:build_num', (req, res) ->
  res.json require "../../../mocks/v1/project"
  json[0].username = req.params.username
  json[0].reponame = req.params.project
  json[0].build_num = req.params.build_num
  res.json json
  
module.exports = router