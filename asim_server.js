const express = require('express');
const app = express();
const db = require('./asim_database');
const config = require('./asim_config');

var bodyParser = require('body-parser');
var http = require('http').Server(app);

const PORT = config.port;

// set server port 
app.set('port' , process.env.PORT|| PORT);

// need this for POST requests 
var urlencodedParser = bodyParser.urlencoded({
    extended: false
})

app.use(bodyParser.json({type: 'application/json'}))

//serving all the files in the project directory
app.use(express.static(__dirname));

// POST method for user signup from the app
app.post('/app/signup', urlencodedParser, async (req, res) => {
    var status = "";
    var k = req.body;
    // print what has been sent by app
    console.log(k);

    // call function to add patient to database 
    var resp = await db.insertPatient(k);

    // if successfully added 
    if(resp.status == 1){
        var response = {
            confirm: "yes",
        };
    }
    else {
        var response = {
            confirm: "no",
        };
    }

    // send the JSON back to the app 
    res.end(JSON.stringify(response));
    });

app.post('/app/login', urlencodedParser, async (req, res) => {
    var status = "";
    var loginCred = req.body;
    console.log(loginCred);
    var resp = await db.getPatientInfo(loginCred);
    var patientProfInfo = {};
    if(resp.status == 1){
        //successful
        patientProfInfo = resp.patient;
    }

    res.end(JSON.stringify(patientProfInfo));
});

// custom 404 page
app.use(function (req, res) {
    res.type('text/plain');
    res.status(404);
    res.send('404 - Not Found');
});

// custom 500 page
app.use(function (err, req, res, next) {
    console.error(err.stack);
    res.type('text/plain');
    res.status(500);
    res.send('500 - Server Error');
});

// start server
app.listen(PORT, () => {
    console.log(`Server listenting on port ${PORT}`);
})