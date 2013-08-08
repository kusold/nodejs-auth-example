routes = (app) ->
  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login",
      title: 'Login'
  
  app.post '/sessions', (req, res) ->
    if ('mike' is req.body.user) and ('kusold' is req.body.password)
      req.session.currentuser = req.body.user
      req.flash 'info', 'Welcome #{req.session.currentuser}'
      res.redirect '/login'
    else
      req.flash 'error', 'Invalid username and/or password'
      res.redirect '/login'
    
module.exports = routes
