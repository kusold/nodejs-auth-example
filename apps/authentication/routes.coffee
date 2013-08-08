passport = require('passport')
User = require('./models/user')

routes = (app) ->
  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login", 
      user: req.user
      title: 'Login'
  
  app.post '/login',  passport.authenticate('local', { successRedirect: '/', failureRedirect: '/login', successFlash: 'Welcome!', failureFlash: true}) 

  app.get '/register', (req, res) ->
    res.render "#{__dirname}/views/register",
      title: 'Register'
  
  app.post '/user/create', (req, res) ->
    if(req.body.password != req.body.confirm)
      req.flash 'error', 'Your passwords do not match'
      res.redirect '/register'
    else
      User.register(new User({username: req.body.username}), req.body.password, (err, new_user) ->
        if(err)
          console.log(err)
          req.flash 'error', err.message
          res.redirect '/register'
        else
          req.flash 'Thanks for registering'
          res.redirect '/login'
      )
 
exports.ensureAuthenticated = (req, res, next) ->
  if(req.isAuthenticated())
    return next()
  res.redirect '/login'
  
module.exports = routes
