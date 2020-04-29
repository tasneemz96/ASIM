const { spawn } = require('child_process');

function dateTimeString(date) {
    date = date.replace(/-/g, " ");
    var month = date.split(" ")[1];
    if (month == '01')
        month = "January"
    else if (month == '02')
        month = "February"
    else if (month == '03')
        month = "March"
    else if (month == '04')
        month = "April"
    else if (month == '05')
        month = "May"
    else if (month == '06')
        month = "June"
    else if (month == '07')
        month = "July"
    else if (month == '08')
        month = "August"
    else if (month == '09')
        month = "September"
    else if (month == '10')
        month = "October"
    else if (month == '11')
        month = "November"
    else if (month == '12')
        month = "December"

    var newstring = date.replace(date.split(" ")[1], month);
    return newstring;

}

var patMod = {
    email: "tasneem@gmail.com",
    password: "9c64f6ea4c13ccc4835e62a64b7e6b39",
    name: "Tasneem Batool",
    dob: "31 December 1996",
    gender: "Female",
    phone: "971566948561",
    nationality: "Bangladesh",
    insurance: "true",
    handicap: "false",
    diabetes: "false",
    hypertension: "true",
    alcoholism: "true",
    appointments: { numApps: "0" }
}

var a = {
    appointment: {
        doctor: "Dr. Mike Hunt",
        specialization: "E.N.T.",
        date: "10-05-2020 16:00",
        patients: {},
        available: "yes"
    }
}

function pythonRequest(patMod, appointment) {

    return new Promise((resolve, reject) => {

        var g = (patMod['gender'] == 'Female') ? 1 : 0
        var dob = new Date(patMod['dob']);
        var age = Math.round((new Date() - dob) / (1000 * 3600 * 24 * 365.2425));
        var neighborhood = 42;
        var insurance = (patMod['insurance'] == "true") ? 1 : 0
        var hypertension = (patMod['hypertension'] == 'true') ? 1 : 0
        var diabetes = (patMod['diabetes'] == 'true') ? 1 : 0
        var alcoholism = (patMod['alcoholism'] == 'true') ? 1 : 0
        var handicap = (patMod['handicap'] == 'true') ? 1 : 0
        var sms = 0;
        var appointmentDay = new Date(dateTimeString(appointment['date']));
        var scheduledDay = new Date();
        var appdot = (appointmentDay.getDay() + 6) % 7;
        var scheddot = (scheduledDay.getDay() + 6) % 7;
        var leadtime = Math.round((appointmentDay - scheduledDay) / (1000 * 3600 * 24));

        var toSendPython = [g, age, neighborhood, insurance, hypertension, diabetes, alcoholism, handicap, sms, appdot, scheddot, leadtime];

        console.log(toSendPython);

        const pyProg = spawn("python", ['./asim_predict.py', toSendPython])

        const pyprog = spawn('python', ['./asim_predict.py', g, age, neighborhood, insurance, hypertension, diabetes, alcoholism, handicap, sms, appdot, scheddot, leadtime]);

        var ans = -1;

        let runPy = new Promise(function (success, nosuccess) {

            pyprog.stdout.on('data', function (data) {
                console.log("stdout");
                success(data);
            });

            pyprog.stderr.on('data', (data) => {
                console.log("stderr");
                nosuccess(data);
            });
        }).catch(e => { console.log("ugh"); });

        runPy.then(function (fromRunpy) {
            ans = fromRunpy.toString()[0];
            console.log(ans);
            resolve(ans);
            
        }).catch(e => { });
        
    });

}

/*async function hello() {
    var k = await pythonRequest(patMod, a.appointment);
    console.log(k);
}

hello();*/
module.exports.pythonRequest = pythonRequest;
