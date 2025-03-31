import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = "About";

  // About Section
  static const String aboutAppTitle = "About the App";
  static const String aboutAppDescription =
      "MediMate helps you manage medications effortlessly with smart reminders and an intuitive interface. Stay on top of prescriptions, vitamins, and treatments for yourself or loved ones, and never miss a dose again!";

  // Developers Section
  static const String developersTitle = "Developers";
  static const String developersDescription =
      "The app is developed by CodeRacers, a team of four passionate developers, dedicated to creating innovative solutions for everyday problems. We believe in the power of technology to make a positive impact on people's lives, and we strive to create apps that are user-friendly, reliable, and accessible to everyone.";

  // LinkedIn Section
  static const String visitLinkedInTitle = "Visit Our LinkedIn Profiles";
  static const List<Map<String, String>> developerLinks = [
    {
      "name": "Aswin Oomen Jacob",
      "url": "https://www.linkedin.com/in/aswin-jacob-1ba26923b/"
    },
    {
      "name": "Angel Shibu",
      "url": "https://www.linkedin.com/in/angel-shibu-a60251347"
    },
    {
      "name": "Christa Rachel Varghese",
      "url": "https://www.linkedin.com/in/christa-varghese-957316282/"
    },
    {
      "name": "Ninz Milka Loji",
      "url": "https://www.linkedin.com/in/ninz-milka-loji-7a6154264"
    }
  ];

  // Contact Section
  static const String contactUsTitle = "Contact Us";
  static const String contactUsEmail = "mailto:coderacers3@gmail.com";

  // App Version
  static const String appVersionTitle = "App Version";
  static const String appVersion = "1.0.0";
}



const debug = false; // Porduction build should have it as false;
const String APP_NAME = "The UR App";

const app_version = 'v2.0';
const about_cmi_title = 'The Carmelites of Mary Immaculate (CMI) ';
const about_cmi =
    'the first indigenous religious congregation founded in India is the community of Catholic religious men dedicated to the service of God and His people. Drawing inspiration from the Carmelite charism of prayer and service the founders of CMI established the first house at Mannanam in 1831. Today this community has grown into an international religious congregation with 3000 members present in 30 countries. Its chief founder, St. Kuriakose Elias Chavara (1805–1871), was a great visionary who championed the reform of Kerala society in the 19th century. His remarkable contributions for the spiritual, social, educational and literary development of Kerala are continued by the CMI Congregation in response to the signs of time.\n\nCMI Prior General’s House\nChavara Hills, P.B. No. 3105\nKakkanad P.O., Kochi–682030\nKerala, India\n\nPh. +91–484–288–1816\nEmail: secretary@cmi.in\nwww.cmi.org.in';

const about_content_copyright_title = 'English Bible: ';
const about_content_copyright =
    'English Scripture excerpts from the New American Bible, Revised Edition Copyright © 2010, 1991, 1986, 1970 by the Confraternity of Christian Doctrine, Washington, D.C. Used with permission. All Rights Reserved. No part of the New American Bible may be reproduced in any form without permission in writing from the copyright owner.';

const about_liturgy_of_hours_copyright_title =
    'Liturgy of Hours (Fr. Abel CMI): ';

const String ABOUT_ORG_TITLE = "Owner";
const String ABOUT_ORG_SUB_TITLE = "Catholic Christian Outreach";
const String ABOUT_ORG_URL = "http://www.cco.ca";

const String ABOUT_UR_TRAINING_TITLE = "UR Training";
const String ABOUT_UR_TRAINING_SUB_TITLE = "Training resources";
const String ABOUT_UR_TRAINING_URL = "https://cco.ca/ur/";

const about_liturgy_of_hours_copyright =
    'Liturgy of hours text from the three volume \'Kanona Namaskaram\' used with permission from Fr. Provincial, Saint Joseph Provincial House, Kottayam.';

const about_this_app_title = 'The CMI App: ';
const about_this_app_ownership = 'Ownership and Initiative by ';
const about_carmelites_link = 'Carmelites of Mary Immaculate';
const about_in_collaboration = '. In collaboration with ';
const about_jesus_youth_link = 'Jesus Youth International';
const about_app_developed_by = '. App Developed by ';
const about_ethiccoders_link = 'EthicCoders.';

const key_text_scale_factor = "key_text_scale_factor";
const key_lang_code = 'key_lang_code';
const LANG_ENG = 0;
const LANG_MAL = 1;
const LANG_HIN = 2;

const ABBR_LEADER = 1;
const ABBR_ALL = 2;
const ABBR_OTHERS = 3;
const ABBR_ONE_PLUS = 4;

const FALSE = 0;
const TRUE = 1;

const annunciation = "Annunciation";
const NATIVITY = "Nativity";
const epiphany = "Epiphany";
const lent = "Lent";
const ressurection = "Resurrection";
const apostles = "Apostles";
const summer = "Summer";
const elias = "Elias, Cross and Moses";
const moses = "Moses";
const dedication = "Dedication of the Church";

const key_night_mode = "key_night_mode";
const key_grayscale = "key_grayscale";
const key_gridlayout = "key_gridlayout";
const key_font_size = "key_font_size";
const key_remove_ads = "key_remove_ads";
const singleImageGrid = 1;
const doubleImageGrid = 2;
const threeImageGrid = 3;
const int default_font_size = 14;

const LITURGICAL_SEASON = 0;
const liturgical_season_of_annunciation = 1 + LITURGICAL_SEASON; //1
const liturgical_season_of_epiphany = 1 + liturgical_season_of_annunciation; //2
const liturgical_season_of_lent = 1 + liturgical_season_of_epiphany; //3
const liturgical_season_of_resurrection = 1 + liturgical_season_of_lent; //4
const liturgical_season_of_apostles = 1 + liturgical_season_of_resurrection; //5
const liturgical_season_of_summer = 1 + liturgical_season_of_apostles; //6
const liturgical_season_of_elias = 1 + liturgical_season_of_summer; //7
const liturgical_season_of_moses = 1 + liturgical_season_of_elias; //8
const liturgical_season_of_dedication = 1 + liturgical_season_of_moses; //9

const start_year = 2014;
const end_year = 2026;

const celebration_start_year = 1900;
const celebration_end_year = 2018;

const space = " ";
const open_bracket = "(";
const plus = '+';
const comma = ",";
const dash = '-';
const other_dash = '–';
const undefined = -1;
const colon = ':';
const or_with_space = " or ";
const semicolon = ";";

// table names
const TABLE_BOOKS = "books";
// table bible
const TABLE_BIBLE = "Master";
// table malayalam bible
const TABLE_MALAYALAM_BIBLE = "Master_Malayalam";
// column - book
const COL_BOOK_CAT = "book_cat";
const COL_ID = "_id";
const COL_CHAPTER_COUNT = "chapter_count";
const COL_BOOK_ENG_NAME = "book_eng_name";
const COL_BOOK_SHORT_ENG_NAME = "book_short_eng_name";
const COL_BOOK_MAL_NAME = "book_mal_name";
// column - bible
const COL_BIBLE_BOOK = "book";
const COL_BIBLE_BOOK_NO = "book_no";
const COL_BIBLE_CHAPTER = "chapter";
const COL_BIBLE_VERSE = "verse";
const COL_BIBLE_VERSE_NO = "verse_no";
const cOL_BIBLE_NEW_PARA = "new_paragraph";
const COL_BIBLE_HEADING = "heading";

const key_db_version = "key_db_version";

const feedback_email = 'thecmiglobal@gmail.com';
const share_text_ios =
    "I found CMI App very interesting. Hope you would like too. AppStore link: $appstore_link";
const share_text_android =
    "I found CMI App very interesting. Hope you would like too. PlayStore link: $playstore_link";
const appstore_link = "http://appstore.com/carmelites-mary-immaculate/cmi";
const playstore_link =
    "https://play.google.com/store/apps/details?id=org.cmi.app";

const topic_dob = 'dob';
const topic_ordination = 'ordination';
const topic_first_vows = 'first_vows';
const topic_feast = 'feast';

const birthdays = 'Birthdays';
const ordinations = 'Ordinations / Final Vows';
const first_vows_title = 'First Vows';
const feasts_title = 'Feast';

const Duration one_week = Duration(days: 7);
const Duration four_weeks = Duration(days: 28);
const Duration seven_weeks = Duration(days: 49);

const SEASON_ANNUNCIATION_INDEX = 0;
const SEASON_NATIVITY_INDEX = 1;
const SEASON_EPIPHANY_INDEX = 2;
const SEASON_LENT_INDEX = 3;
const SEASON_RESURECTION_INDEX = 4;
const SEASON_APOSTLES_INDEX = 5;
const SEASON_SUMMER_INDEX = 6;
const SEASON_ELIAS_CROSS_MOSES_INDEX = 7;
const SEASON_MOSES_INDEX = 8;
const SEASON_DEDICATION_INDEX = 9;

const List<String> MalSeasons = <String>[
  'മംഗലവാര്‍ത്തക്കാലം',
  'നേറ്റിവിറ്റി',
  'ദനഹാക്കാലം',
  'നോമ്പുകാലം',
  'ഉയിര്‍പ്പുകാലം',
  'ശ്ലീഹാക്കാലം',
  'കൈത്താക്കാലം',
  'ഏലിയാ-ശ്ലീവാക്കാലം',
  'മൂശെക്കാലം',
  'പള്ളിക്കൂദാശക്കാലം',
];

const List<String> EngSeasons = <String>[
  'Season of Annunciation',
  'Season of Nativity',
  'Season of Epiphany',
  'Season of Lent',
  'Season of Resurrection',
  'Season of Apostles',
  'Season of Summer',
  'Season of Elias, Cross and Moses',
  'Season of Moses',
  'Season of Dedication of the Church',
];

const List<String> MalMonths = <String>[
  'ജനുവരി',
  'ഫെബ്രുവരി',
  'മാര്‍ച്ച്',
  'ഏപ്രില്‍',
  'മെയ്',
  'ജൂണ്‍ ‍',
  'ജൂലൈ',
  'ഓഗസ്റ്റ്',
  'സെപ്‌റ്റംബര്‍',
  'ഒക്ടോബര്‍',
  'നവംബര്‍',
  'ഡിസംബര്‍',
];

const List<String> EngMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June ‍',
  'July',
  'August',
  'September',
  'October',
  'November',
  'Decemeber',
];

const List<String> MalWeekdays = <String>[
  'ഞായര്‍',
  'തിങ്കള്‍',
  'ചൊവ്വ',
  'ബുധന്‍',
  'വ്യാഴം',
  'വെള്ളി',
  'ശനി'
];
const List<String> EngWeekdays = <String>[
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

const List<String> MalPositions = <String>[
  'ഒന്നാം',
  'രണ്ടാം',
  'മൂന്നാം',
  'നാലാം',
  'അഞ്ചാം',
  'ആറാം',
  'ഏഴാം',
  'എട്ടാം',
  'ഒമ്പതാം',
  'പത്താം',
  'പതിനൊന്നാം',
  'പന്ത്രണ്ടാം',
];

const List<String> EngPositions = <String>[
  'First',
  'Second',
  'Third',
  'Fourth',
  'Fifth',
  'Sixth',
  'Seventh',
  'Eigth',
  'Ninth',
  'Tenth',
  'Eleventh',
  'Twelfth',
];

const List<Map<String, String>> DaysOfFeastAndObligation =
    <Map<String, String>>[
  <String, String>{'date': 'Dec 25', 'occation': 'ഈശോയുടെ പിറവിത്തിരുന്നാൾ'},
  <String, String>{'date': 'Jan 06', 'occation': 'ദനഹാ തിരുനാൾ'},
  <String, String>{'date': 'May 29', 'occation': 'ഈശോയുടെ സ്വർഗ്ഗാരോഹണം'},
  <String, String>{
    'date': 'Jun 29',
    'occation': 'വി. പത്രോസ്, പൗലോസ് ശ്ലീഹന്മാരുടെ തിരുനാൾ'
  },
  <String, String>{'date': 'Jul 03', 'occation': 'ദുക്രാന'},
  <String, String>{'date': 'Aug 15', 'occation': 'മാതാവിന്റെ സ്വർഗ്ഗാരോപണം'},
];

const LITURGY = "Liturgy";
const OBITUARY = "Obituary";
const PRAYERS = "Prayers";

const PRESENT = "Present";
const DEPARTED = "Departed";

const List<String> LITURGY_TABS = [LITURGY, OBITUARY, PRAYERS];

const List<String> MEMBERS_TABS = [
  PRESENT,
  DEPARTED,
];
