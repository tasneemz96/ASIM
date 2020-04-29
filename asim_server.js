const express = require('express');
const app = express();
const db = require('./asim_database');
const config = require('./asim_config');

var bodyParser = require('body-parser');
var http = require('http').Server(app);

var mongo = require('mongodb');
var py = require('./test');

const PORT = config.port;

// set server port 
app.set('port', process.env.PORT || PORT);

// need this for POST requests 
var urlencodedParser = bodyParser.urlencoded({
    extended: false
})

app.use(bodyParser.json({ type: 'application/json' }))

//serving all the files in the project directory
app.use(express.static(__dirname));

// POST method for user signup from the app
app.post('/app/signup', urlencodedParser, async (req, res) => {
    var status = "";
    var k = req.body;
    var response = {
        confirm: "",
        patient: {},
    }
    // print what has been sent by app
    console.log(k);

    // call function to add patient to database 
    var resp = await db.insertPatient(k);

    // if successfully added 
    if (resp.status == 1) {
        response.confirm = "yes",
            response.patient = resp.patient;

    }
    else {

        response.confirm = "no",
            response.patient = resp.patient;

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
    if (resp.status == 1) {
        //successful
        patientProfInfo = resp.patient;
    }

    res.end(JSON.stringify(patientProfInfo));
});

// use for retrieving all available appointments based on specialists
app.post('/app/availableappointments', urlencodedParser, async (req, res) => {
    var status = "";
    var specialization = req.body.specialization;
    console.log("User clicked on: " + specialization);
    var resp = await db.getAppointmentBySpecialization(specialization);
    if (resp.status == 1) {
        // successful retrieval from database
        console.log("Retrieval success");
    }
    else {
        console.log("Retrieval error");
    }
    console.log(resp.appointment);
    var appointmentJSON = {};
    var appointmentArray = resp.appointment;
    var numAppointments = appointmentArray.length;
    var i;
    appointmentJSON["numAppointments"] = numAppointments;
    for (i = 0; i < numAppointments; i++) {
        appointmentJSON[(i + 1).toString()] = appointmentArray[i];
    }
    console.log(appointmentJSON);
    res.end(JSON.stringify(appointmentJSON));
})

app.post("/app/bookappointment", urlencodedParser, async (req, res) => {

    // var stat = "";
    var response = { status: "", patient: {}, appt: {} };

    console.log("Received from app.. ");
    console.log(req.body);
    // var bookingDate = req.body.bookingDate;
    var appointment = req.body.appointment;
    var patient = req.body.patient;

    console.log("Getting patient and appointment information... ");
    var p = await db.getPatientInfo(patient);
    var a = await db.getAppointmentInfo(appointment);

    console.log(p);
    console.log(a);

    if (p.patient != null) {
        var patMod = p.patient;
        //delete patMod['_id'];

        var appMod = a.appointment;
        //delete appMod['_id'];

        var noshowpred = await py.pythonRequest(patMod, a.appointment);

        var numApp = Object.keys(patMod.appointments).length - 1;
        console.log("old number of appointments... " + numApp);
        patMod.appointments[(numApp + 1).toString()] = a.appointment['_id'];
        patMod.appointments.numApps = (numApp + 1).toString();
        console.log("New patient object... ");
        console.log(patMod);

        console.log("modifying current patient now... ");
        var modPatientResp = await db.modifyPatient(patient, patMod);
        var x = await db.getPatientInfo({ email: patMod.email, password: patMod.password });
        response.patient = x.patient;
        console.log("Booked appointment: ");
        console.log(patMod);

        
        var numPatients = Object.keys(appMod.patients).length;
        appMod.patients[(numPatients + 1).toString()] = {email: p.patient.email, phone: p.patient.phone, noshow: noshowpred.toString()};

        console.log(noshowpred.toString());

        if(noshowpred.toString() == '0'){
            console.log("this patient will show");
            appMod.available = "no";
        }
        else if ((numPatients + 1) >= 2) {
            console.log("overbooking done");
            appMod.available = "no";
        }

        
        var modAppResp = await db.modifyAppointment(appointment, appMod);
        console.log("Booked patient:");
        var y = await db.getAppointmentInfo(appMod);
        response.appt = y;

        console.log(appMod);
        if (modPatientResp.status == 1 && modAppResp.status == 1) {
            response.status = 1;
        }
        else {
            response.status = 0;
        }
    }
    else {
        response.status = -1;
    }

    // response.status = 1;

    console.log("Sending response to app: ");
    console.log(response);
    res.end(JSON.stringify(response));

});

app.post("/app/patientappointments", urlencodedParser, async (req, res) => {
    var appointmentIDs = req.body.appointmentIDs;
    console.log(appointmentIDs);

    var count = 0;
    var toSend = {};

    var i;
    toSend['numAppointments'] = appointmentIDs.length;
    for (i = 0; i < appointmentIDs.length; i++) {
        var o_id = new mongo.ObjectID(appointmentIDs[i]);
        console.log(o_id);
        toSend[(i + 1).toString()] = (await db.getAppointmentInfo({ _id: o_id })).appointment;
    }


    console.log(toSend);
    res.end(JSON.stringify(toSend));
})

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