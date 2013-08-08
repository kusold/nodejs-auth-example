assert = require('assert')
should = require('should')
request = require('request')
$ = require('jquery')
app = require '../../app'

describe "authentication", ->
  describe "GET /login", ->
    body = null
    before (done) ->
      options =
        uri: "http://localhost:3000/login"
      request options, (err, res, _body) ->
        body = _body
        done()

    it "has a title that contains login", ->
      $('title', body).text().should.equal('Login')

    it "should have an input with name user", ->
      $('input[name=user]', body).should.exist

    it "should have an input with name password", ->
      $('input[name=password]', body).should.exist
