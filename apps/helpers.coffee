helpers = (app) ->
  app.use (req, res, next) ->
    res.locals.flash = req.flash()
    console.log(res.locals.flash)
    next()

module.exports = helpers
