const config = require('./asim_config');
const test_patients = require('./test_db');

const url = config.database.url;
const dbName = config.database.dbName;
const db_url = config.database.dbURL;
const patientsCollection = config.database.patientsCollection;

var MongoClient = require('mongodb').MongoClient;

// connec to your database - test  
function connectDB(){
    MongoClient.connect(db_url, function(err, db) {
        if (err) 
            {
                console.log("Error encountered");
                console.log(err);
                throw err;
            }
        else {
            console.log("Database connected!");
            db.close();
        }
      });
}

// create a collection in your database 
function createColl(){
    // connect to database mydb
    MongoClient.connect(url, function(err, db) {
        if (err) throw err;
        var dbo = db.db(dbName);
        // in mydb, create a collection called 'patients'
        dbo.createCollection(patientsCollection, function(err, res) {
          if (err) throw err;
          console.log(patientsCollection + "collection created!");
          db.close();
        });
      });
}
 /*  */

var tasneem = test_patients.tasneem;

var mostafa = test_patients.mostafa;

var omar = test_patients.omar;

var tasneemLogin = test_patients.tasneemLogin;

// add patient to mydb > patients
function insertPatient(patient){
    var resp = {
        status: ""
    };

    // synchronize with database 
    return new Promise ((resolve, reject) =>{
        try{
            // connect to mydb
            MongoClient.connect(url, function(err, db) {
                if (err) throw err;
                var dbo = db.db(dbName);
                
                // connect to patients collection and look for a record that matches 'patient' (this is to detect duplicates)
                dbo.collection(patientsCollection).findOne(patient, function(err, res) {
                    if (err){
                        console.log("dbo.collection error encountered");
                        console.log(err);
                        throw err;
                    }
                    else {
                        // if no such record exists, add it to mydb > patients
                        if(res == null){
                            dbo.collection(patientsCollection).insertOne(patient, function(err, res) {
                                if (err) throw err;
                                else {
                                  console.log("1 document inserted");
                                  db.close();
                                  // resp.status = 1 means successful operation
                                  resp.status = 1;
                                  // return the resp JSON at end of function
                                  resolve(resp);
                                }
                                
                              });
                        }
                        // if duplicate found, inform and do nothing 
                        else {
                            console.log("document exists");
                            console.log(JSON.stringify(res));
                            db.close();
                            // resp.status = -1 means unsuccessful operation
                            resp.status = -1;
                            // return resp JSON at end of function
                            resolve(resp);
                        }
                    }
                })
              });
        }
        catch{
            console.log("woops");
            db.close();
            // resp.status = 0 means couldn't access database
            resp.status = 0;
            // return resp JSON at end of function
            resolve(resp);
        }
    })
}

// update a patient's information in mydb > patients -- value is the record to be modified, newvalue is the record replacing it
function modifyPatient(value, newvalue){
    resp = {
        status : ""
    }

    // synchronize with database 
    return new Promise((resolve, reject) =>{
        try{
            // connect to mydb
            MongoClient.connect(url, function(err, db) {
                if (err) throw err;
                else {
                    var dbo = db.db(dbName);

                    dbo.collection(patientsCollection).findOne(value, function(err, obj){
                        if(obj == null){
                            console.log('Object does not exist');
                            resp.status = 0;
                            db.close();
                            resolve(resp);
                        }
                            // access mydb > patients, and update an existing record
                        dbo.collection(patientsCollection).updateOne(value, newvalue, function(err, res) {
                            if (err) throw err;
                            else {
                                console.log("1 document updated");
                                console.log(JSON.stringify(res));
                                db.close();
                                // successful operation 
                                resp.status = 1;
                                // return
                                resolve(resp);
                            }
                        });

                    });
                }
              });
        }
        catch{
            // couldn't access database
            resp.status = -1;
            db.close();
            // return 
            resolve(resp);
        }
    })

}

// remove patient from database 
function deletePatient(value){
    resp = {
        status: ""
    }

    // synchronize with database 
    return new Promise((resolve, reject) => {
        try{
            // connect to mydb
            MongoClient.connect(url, function(err, db) {
                if (err) throw err;
                var dbo = db.db(dbName);
                dbo.collection(patientsCollection).findOne(value, function(err, obj){
                    if(err){
                        throw err;
                    }
                    if(obj == null){
                        console.log("Object not found");
                        resp.status = 0;
                        db.close();
                        resolve(resp);
                    }
                    else{
                        // connect to mydb > patients and delete the record    
                        dbo.collection(patientsCollection).deleteOne(value, function(err, obj) {
                            if (err) throw err;
                            console.log("1 document deleted");
                            //successful operation
                            resp.status = 1;
                            db.close();
                            resolve(resp);
                          });
                    }
                });            
              });
        }
        catch {
            console.log("woops");
            db.close();
            // couldnt connect to db
            resp.status = -1;
            resolve(resp);
        }
    })
}

// get patient profile information based on user credentials email and password 
function getPatientInfo(emailAndPass){

    resp = {
        status : "",
        patient : {}
    };

    return new Promise((resolve, reject) => {
        try{
            // connect to database 
            MongoClient.connect(url, function(err, db){
                if (err){
                    throw err;
                }
                var dbo = db.db(dbName);
                // connec to mydb > patients
                dbo.collection(patientsCollection).findOne(emailAndPass, function (err, obj){
                    if(err){
                        throw err;
                    }
                    // if record does not exist with these credentials 
                    if(obj == null){
                        console.log("Object doesnt exist");
                        db.close();
                        // unsuccesful
                        resp.status = 0;
                        // return status
                        resolve(resp);
                    }
                    else{
                        console.log("found the object");
                        console.log(JSON.stringify(obj));
                        // succesful
                        resp.status = 1;
                        resp.patient = obj;
                        db.close();
                        // return status and record
                        resolve(resp);
                    }
                });
            });
        }
        catch{
            console.log("woops");
            // could not connect to db
            resp.status = -1;
            db.close();
            // return status
            resolve(resp);
        }
    });

}

// connectDB();

// var tasneem_mod = { $set: test_patients.tasneem_mod};
// modifyPatient(tasneem, tasneem_mod);

//insertPatient(tasneem);
//insertPatient(mostafa);
//insertPatient(omar);
// deletePatient(omar);

// getPatientInfo(tasneemLogin);

module.exports.insertPatient = insertPatient;
module.exports.modifyPatient = modifyPatient;
module.exports.deletePatient = deletePatient;
module.exports.getPatientInfo = getPatientInfo;
module.exports.connectDB = connectDB;
module.exports.createColl = createColl;

