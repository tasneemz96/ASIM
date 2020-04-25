// test variables for database 

const test = {

    appointments: {
        appointment1: {
            doctor: "Dr. Greyson Navarro",
            specialization: "Nephrology",
            date: "23-04-2020 14:30",
            patients: {},
            available: "yes",
        },

        appointment2: {
            doctor: "Dr. Mike Hunt",
            specialization: "Internal Medicine",
            date: "23 April 2020",
            starttime: "12:30",
            endtime: "12:50",
            patients: {},
            available: "yes",
        },

        appointment2_mod : {
            doctor: "Dr. Mike Hunt",
            specialization: "Internal Medicine",
            date: "23 April 2020",
            starttime: "12:30",
            endtime: "12:50",
            patients: {1: "5e9b25069122db2720d37072"},
            available: "yes",
        }

    },

    patients: {
        tasneem : {
            email: 'ztasneem96@gmail.com',
            password: 'dog',
            name: "Tasneem Zaman",
            dob : "31 December 1996",
            gender : "Female",
            phone : "971566948561",
            nationality : "Bangladesh",
            insurance: "None"
        },
        tasneem_mod : {
            email: 'ztasneem96@gmail.com',
            password: 'dog',
            name: "Tasneem Zaman",
            dob : "31 December 1996",
            gender : "Female",
            phone : "971566948561",
            nationality : "Bangladesh",
            insurance: "Some sort of insurance"
        },
        mostafa : {
            email: 'mostafa@gmail.com',
            name: "Motafa Abuelnoor",
            dob : "23 January 2010",
            gender : "Male",
            phone : "971563360911",
            nationality : "Egypt",
            insurance: "Broke ass bitch" 
        },
        omar : {
            email: 'omar@gmail.com',
            name: "Omar El Boutari",
            dob : "7 March 2008",
            gender : "Male",
            phone : "971503634020",
            nationality : "Lebanon",
            insurance: "Dunno"
        },
        tasneemLogin : {
            email : 'ztasneem96@gmail.com',
            password: 'dog'
        }
    }
    
};

module.exports = test;