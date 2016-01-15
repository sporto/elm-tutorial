var jsonServer = require('json-server')

// Returns an Express server
var server = jsonServer.create()

server.use(function(req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
	next();
});

server.get('/', function (req, res) { 
	res.send(Math.random().toString()) 
})

console.log('Listening at 3000')
server.listen(3000)
