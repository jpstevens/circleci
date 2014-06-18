router = new require("express").Router()

router.route('/me')
.get (req, res) ->
  res.json require "../../../mocks/v1/me"

router.route('/projects')
.get (req, res) ->
  res.json require "../../../mocks/v1/projects"

module.exports = router