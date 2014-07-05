class CircleCIResponse

  constructor: (res) ->
    @body = res.body
    @statusCode = res.statusCode

  success: () ->
    @statusCode >= 200 or @statusCode <= 299

  clientError: () ->
    if @statusCode >= 400 or @statusCode <= 499
      new Error "HTTP client error #{@statusCode}"

  serverError: () ->
    if @statusCode >= 500 or @statusCode <= 599
      new Error "HTTP server error #{@statusCode}"

module.exports = CircleCIResponse
