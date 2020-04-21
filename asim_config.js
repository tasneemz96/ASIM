// configuration file thank you Moustafa 

const config = {
    port: 3000,
    database: {
        url: 'mongodb://localhost:27017/',
        dbName: 'mydb',
        dbURL: 'mongodb://localhost:27017/mydb',
        patientsCollection: 'patients',
        appointmentsCollection: 'appointments',
        doctorsCollection: 'doctors',
    }
}

module.exports = config;