
const PATH = require("path");
const FS = require("fs");
const DAT = require('dat-node');

var datIgnore = require('dat-ignore')


if (process.argv[2] === "share") {


	FS.mkdir("source");
	FS.writeFileSync("source/test.txt", "line 1", "utf8");	



	DAT('source', function (err, dat) {
		if (err) throw err


		var progress = dat.importFiles('source', {
			ignoreDirs: false,
			ignore: ['/node_modules/']
		}, function (err) {
			if (err) throw err
			console.log('Done importing')
			console.log('Archive size:', dat.archive.content.byteLength)
		});
		progress.on('put', function (src, dest) {
			console.log('Added', dest.name)
		});


		var network = dat.joinNetwork()
		network.once('connection', function () {
			console.log('Connected')
		});

		console.log('My Dat link is: dat://', dat.key.toString('hex'));
	});

}
