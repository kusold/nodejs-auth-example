
/**
 * Module dependencies.
 */
require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path')
  , flash = require('connect-flash')
  , mongoose = require('mongoose')
  , mongoStore = require('connect-mongo')(express)
  , passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

var app = express();

cookieHash = 'SuperInsecureCookieHash.QuickButDirty'
mongoDbUrl = "mongodb://localhost:27017"
app.db = mongoose.connect(mongoDbUrl);

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser(cookieHash));
app.use(express.session({
  store: new mongoStore({
    url: mongoDbUrl,
    db: 'test'
  }),
  secret: cookieHash
 })
);

app.use(passport.initialize());
app.use(passport.session());

User = require('./apps/authentication/models/user');
passport.use(User.createStrategy());
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());


app.use(flash());
require('./apps/helpers')(app);
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));
app.locals.basedir = process.env.PWD;

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

// routes
app.get('/', function(req,res) {
  res.render(__dirname + "/views/index",
    {
      user: req.user,
      title: 'Welcome'
    }
  );
});

require('./apps/authentication/routes')(app);
http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
