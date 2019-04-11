// load the http module
var http = require('http');
var today = new Date();

// configure our HTTP server
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("This is newest!!!\n" + (today.getHours()-7) + ":" + today.getMinutes() + ":" + today.getSeconds());
});

// listen on localhost:8000
server.listen(8000);
console.log("Server listening at http://127.0.0.1:8000/");
