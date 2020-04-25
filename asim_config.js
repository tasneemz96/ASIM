// configuration file thank you Moustafa 

const config = {
    port: 3000,
    database: {
        uri: "mongodb+srv://Tasneem:tasneem@cluster0-0cknp.mongodb.net/test?retryWrites=true&w=majority",
        url: 'mongodb://localhost:27017/', // for the local db
        dbName: 'mydb',
        dbURL: 'mongodb://localhost:27017/mydb',
        patientsCollection: 'patients',
        appointmentsCollection: 'appointments',
        doctorsCollection: 'doctors',
    }
}

module.exports = config;