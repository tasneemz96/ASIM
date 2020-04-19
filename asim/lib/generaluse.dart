class Nationality {
  List<String> countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua And Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia And Herzegovina",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Cocos (keeling) Islands",
    "Colombia",
    "Comoros",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D'ivoire",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Guiana",
    "French Polynesia",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guinea",
    "Guinea-bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakstan",
    "Kenya",
    "Kiribati",
    "Korea, Democratic People's Republic Of",
    "Korea, Republic Of",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Lao People's Democratic Republic",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libyan Arab Jamahiriya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia, The Former Yugoslav Republic Of",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia, Federated States Of",
    "Moldova, Republic Of",
    "Monaco",
    "Mongolia",
    "Montserrat",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "Northern Mariana Islands",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestinian Territory, Occupied",
    "Panama",
  ].toList();
/*,

    "PG|Papua New Guinea",
    "PY|Paraguay",
    "PE|Peru",
    "PH|Philippines",
    "PN|Pitcairn",
    "PL|Poland",
    "PT|Portugal",
    "PR|Puerto Rico",
    "QA|Qatar",
    "RE|Reunion",
    "RO|Romania",
    "RU|Russian Federation",
    "RW|Rwanda",
    "SH|Saint Helena",
    "KN|Saint Kitts And Nevis",
    "LC|Saint Lucia",
    "PM|Saint Pierre And Miquelon",
    "VC|Saint Vincent And The Grenadines",
    "WS|Samoa",
    "SM|San Marino",
    "ST|Sao Tome And Principe",
    "SA|Saudi Arabia",
    "SN|Senegal",
    "RS|Serbia",
    "SC|Seychelles",
    "SL|Sierra Leone",
    "SG|Singapore",
    "SK|Slovakia",
    "SI|Slovenia",
    "SB|Solomon Islands",
    "SO|Somalia",
    "ZA|South Africa",
    "GS|South Georgia And The South Sandwich Islands",
    "ES|Spain",
    "LK|Sri Lanka",
    "SD|Sudan",
    "SR|Suriname",
    "SJ|Svalbard And Jan Mayen",
    "SZ|Swaziland",
    "SE|Sweden",
    "CH|Switzerland",
    "SY|Syrian Arab Republic",
    "TW|Taiwan, Province Of China",
    "TJ|Tajikistan",
    "TZ|Tanzania, United Republic Of",
    "TH|Thailand",
    "TG|Togo",
    "TK|Tokelau",
    "TO|Tonga",
    "TT|Trinidad And Tobago",
    "TN|Tunisia",
    "TR|Turkey",
    "TM|Turkmenistan",
    "TC|Turks And Caicos Islands",
    "TV|Tuvalu",
    "UG|Uganda",
    "UA|Ukraine",
    "AE|United Arab Emirates",
    "GB|United Kingdom",
    "US|United States",
    "UM|United States Minor Outlying Islands",
    "UY|Uruguay",
    "UZ|Uzbekistan",
    "VU|Vanuatu",
    "VE|Venezuela",
    "VN|Viet Nam",
    "VG|Virgin Islands, British",
    "VI|Virgin Islands, U.s.",
    "WF|Wallis And Futuna",
    "EH|Western Sahara",
    "YE|Yemen",
    "ZM|Zambia",
    "ZW|Zimbabwe"
  ].toList(); */

  List<String> getCountries(){
    return countries;
  }

}

class Months {
  String stringifyMonth(int monthInt) {
    switch (monthInt) {
      case 1:
        return 'January';
        break;
      case 2:
        return 'February';
        break;
      case 3:
        return 'March';
        break;
      case 4:
        return 'April';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'June';
        break;
      case 7:
        return 'July';
        break;
      case 8:
        return 'August';
        break;
      case 9:
        return 'September';
        break;
      case 10:
        return 'October';
        break;
      case 11:
        return 'November';
        break;
      case 12:
        return 'December';
        break;
    }
  }
}
