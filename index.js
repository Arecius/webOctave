// BASE SETUP
// =============================================================================

// call the packages we need
var express = require('express'); // call express
var app = express(); // define our app using express
var bodyParser = require('body-parser');
var multer = require('multer');
var fs = require('fs');
var exec = require('child_process').exec;
var path = require('path');
var upload = multer({
    dest: 'uploads/',
    onFileUploadStart: function (file) {
        console.log('Upload is starting ...');
    },
    onFileUploadComplete: function (file) {
        console.log('Upload Finished');
    }
});

// configure app to use bodyParser()
// this will let us get the data from a POST
/*
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.text());
*/
var port = process.env.PORT || 8080; // set our port

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router(); // get an instance of the express Router

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)

router.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});


router.get('/', function (req, res) {
    res.json({
        message: 'hooray! wel    come to our api!'
    });
});


router.post('/createJob', upload.single("image"), (req, res) => {
    console.log("Creating Job...");
    let output = `outputs\\p_${req.file.filename}.${ req.file.originalname.split('.')[1] }`;
    let args = [`scripts\\${req.body.scriptName}`, req.file.path, output ];
    console.log(args);

    exec("octave-cli " + args.join(' '), (error, stdout, stderr) => {
        console.log("Done");
        res.json({
            retrieveId: output
        });
    });


}),

router.get( '/retrieve', ( req, res ) =>{
    
    res.sendFile(path.join(__dirname, req.query.id ));
});

    // more routes for our API will happen here

    // REGreISTER OUR ROUTES -------------------------------
    // all of our routes will be prefixed with /api
    app.use('/api', router);





// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);