var express = require('express'); // call express
var app = express(); // define our app using express
var bodyParser = require('body-parser');
var multer = require('multer');
var fs = require('fs');
var exec = require('child_process').exec;
var path = require('path');
var upload = multer({
    dest: 'uploads',
    onFileUploadStart: function (file) {
        console.log('Upload is starting ...');
    },
    onFileUploadComplete: function (file) {
        console.log('Upload Finished');
    }
});

var port = process.env.PORT || 8080; // set our port

var router = express.Router(); // get an instance of the express Router


router.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});


router.get('/', function (req, res) {

   res.send("Hola");

});

router.get('/test', ( req, res ) => {
   res.send("it works"); 
});

router.post('/createJob', upload.single("image"), (req, res) => {
    
    console.log( `Creating Job for ${ req.body.scriptName }..."`);
    //let output = path.join( 'outputs', `p_${req.file.filename}`) + "." + req.file.originalname.split('.')[1]; 
    let output = `outputs/result_${req.file.filename}.${req.file.originalname.split('.')[1]}`; 
    let asset = `outputs/asset_${req.file.filename}.${req.file.originalname.split('.')[1]}`; 
    let script = path.join( 'scripts', req.body.scriptName)
    
    let args = [ script, req.file.path, output, asset ];
    console.log( `Args: ${args}` )
    
    if( req.body.scriptVars ){
        console.log(`vars: ${JSON.parse( req.body.scriptVars )}`)
        args = args.concat( JSON.parse( req.body.scriptVars ) )
    }
    console.log( `command: octave-cli ${args.join(' ')}` );
    exec("octave-cli " + args.join(' '), (error, stdout, stderr) => {
        console.log("Done");
        setTimeout( () => {
            res.json({
                result: output,
                asset: asset
            } );
        },1200);

    });


}),

router.get( '/retrieve', ( req, res ) =>{
    
    res.sendFile(path.join(__dirname, req.query.id ));
});


    app.use('/api', router);

app.listen(port);
console.log('Magic happens on port ' + port);
