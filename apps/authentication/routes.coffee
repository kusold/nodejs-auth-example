passport = require('passport')
User = require('./models/user')

routes = (app) ->
  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login", 
      user: req.user
      title: 'Login'
      stylesheet: 'login.css'
  
  app.post '/login',  passport.authenticate('local', { successRedirect: '/', failureRedirect: '/login', successFlash: 'Welcome!', failureFlash: true}) 

  app.get '/register', (req, res) ->
    res.render "#{__dirname}/views/register",
      user: req.user
      title: 'Register'
      stylesheet: 'login.css'
  
  app.post '/register', (req, res) ->
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
          req.flash 'info', 'Thanks for registering'
          res.redirect '/'
      )

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'
 
module.exports = routes
