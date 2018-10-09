var http=require('http')
var fs=require('fs')
var url=require('url')

http.createServer((req,res)=>{
	console.log("REQUEST:     "+req.url)
	if(req.url=='/obras') {
		fs.readFile("./website/index.html", (err, data)=>{
			res.writeHead(200,{'Content-type': 'text/html'})
			if(!err)
				res.write(data)
			else
				res.write(err)
			res.end()
		})
	}
	else if(req.url.indexOf('/obra?id')>-1){
		console.log("Parsing elemento do link")
		var purl = url.parse(req.url,true)
		var q = purl.query
		
		console.log("Enviar pagina")
		fs.readFile("./website/html/obra"+q.id+".html", (err,data)=>{
			res.writeHead(200,{'Content-type':'text/html'})
			if(!err)
				res.write(data)
			else
				res.write(err)
			res.end()
		})
	}
	else {
		res.writeHead(200,{'Content-type': 'text/plain'})	
		res.write("Bem-vindo.\nlocalhost:4001/obras -> index.html\nlocalhost:4001/obra?id=mX -> pagina da obra (X inteiro)")
		res.end()
	}
}).listen(4001,()=>{
	console.log('SERVER OPEN - PORT 4001')
})
