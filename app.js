
/**
 * Module dependencies.
 */
require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path')
  , flash = require('connect-flash');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser("superlongandboringsecretthatdoesntmattersinceimputtingitongithubanyways"));
app.use(express.session());
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
require('./apps/authentication/routes')(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
