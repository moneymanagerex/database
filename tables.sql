-- Describe ACCOUNTLIST
CREATE TABLE ACCOUNTLIST(
ACCOUNTID integer primary key
, ACCOUNTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, ACCOUNTTYPE TEXT NOT NULL /* Checking, Term, Investment, Credit Card */
, ACCOUNTNUM TEXT
, STATUS TEXT NOT NULL /* Open, Closed */
, NOTES TEXT
, HELDAT TEXT
, WEBSITE TEXT
, CONTACTINFO TEXT
, ACCESSINFO TEXT
, INITIALBAL numeric
, FAVORITEACCT TEXT NOT NULL
, CURRENCYID integer NOT NULL
, STATEMENTLOCKED integer
, STATEMENTDATE TEXT
, MINIMUMBALANCE numeric
, CREDITLIMIT numeric
, INTERESTRATE numeric
, PAYMENTDUEDATE text
, MINIMUMPAYMENT numeric
);
CREATE INDEX IDX_ACCOUNTLIST_ACCOUNTTYPE ON ACCOUNTLIST(ACCOUNTTYPE);

-- Describe ASSETS
CREATE TABLE ASSETS(
ASSETID integer primary key
, STARTDATE TEXT NOT NULL
, ASSETNAME TEXT COLLATE NOCASE NOT NULL
, VALUE numeric
, VALUECHANGE TEXT /* None, Appreciates, Depreciates */
, NOTES TEXT
, VALUECHANGERATE numeric
, ASSETTYPE TEXT /* Property, Automobile, Household Object, Art, Jewellery, Cash, Other */
);
CREATE INDEX IDX_ASSETS_ASSETTYPE ON ASSETS(ASSETTYPE);

-- Describe BILLSDEPOSITS
CREATE TABLE BILLSDEPOSITS(
BDID integer primary key
, ACCOUNTID integer NOT NULL
, TOACCOUNTID integer
, PAYEEID integer NOT NULL
, TRANSCODE TEXT NOT NULL /* Withdrawal, Deposit, Transfer */
, TRANSAMOUNT numeric NOT NULL
, STATUS TEXT /* None, Reconciled, Void, Follow up, Duplicate */
, TRANSACTIONNUMBER TEXT
, NOTES TEXT
, CATEGID integer
, SUBCATEGID integer
, TRANSDATE TEXT
, FOLLOWUPID integer
, TOTRANSAMOUNT numeric
, REPEATS integer
, NEXTOCCURRENCEDATE TEXT
, NUMOCCURRENCES integer
);
CREATE INDEX IDX_BILLSDEPOSITS_ACCOUNT ON BILLSDEPOSITS (ACCOUNTID, TOACCOUNTID);

-- Describe BUDGETSPLITTRANSACTIONS
CREATE TABLE BUDGETSPLITTRANSACTIONS(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
CREATE INDEX IDX_BUDGETSPLITTRANSACTIONS_TRANSID ON BUDGETSPLITTRANSACTIONS(TRANSID);

-- Describe BUDGETTABLE
CREATE TABLE BUDGETTABLE(
BUDGETENTRYID integer primary key
, BUDGETYEARID integer
, CATEGID integer
, SUBCATEGID integer
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily*/
, AMOUNT numeric NOT NULL
);
CREATE INDEX IDX_BUDGETTABLE_BUDGETYEARID ON BUDGETTABLE(BUDGETYEARID);

-- Describe BUDGETYEAR
CREATE TABLE BUDGETYEAR(
BUDGETYEARID integer primary key
, BUDGETYEARNAME TEXT NOT NULL UNIQUE
);
CREATE INDEX IDX_BUDGETYEAR_BUDGETYEARNAME ON BUDGETYEAR(BUDGETYEARNAME);

-- Describe CATEGORY
CREATE TABLE CATEGORY(
CATEGID integer primary key
, CATEGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
);
CREATE INDEX IDX_CATEGORY_CATEGNAME ON CATEGORY(CATEGNAME);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CATEGORY VALUES(1,'_tr_Bills');
INSERT INTO CATEGORY VALUES(2,'_tr_Food');
INSERT INTO CATEGORY VALUES(3,'_tr_Leisure');
INSERT INTO CATEGORY VALUES(4,'_tr_Automobile');
INSERT INTO CATEGORY VALUES(5,'_tr_Education');
INSERT INTO CATEGORY VALUES(6,'_tr_Homeneeds');
INSERT INTO CATEGORY VALUES(7,'_tr_Healthcare');
INSERT INTO CATEGORY VALUES(8,'_tr_Insurance');
INSERT INTO CATEGORY VALUES(9,'_tr_Vacation');
INSERT INTO CATEGORY VALUES(10,'_tr_Taxes');
INSERT INTO CATEGORY VALUES(11,'_tr_Miscellaneous');
INSERT INTO CATEGORY VALUES(12,'_tr_Gifts');
INSERT INTO CATEGORY VALUES(13,'_tr_Income');
INSERT INTO CATEGORY VALUES(14,'_tr_Other Income');
INSERT INTO CATEGORY VALUES(15,'_tr_Other Expenses');
INSERT INTO CATEGORY VALUES(16,'_tr_Transfer');

-- Describe CHECKINGACCOUNT
CREATE TABLE CHECKINGACCOUNT(
TRANSID integer primary key
, ACCOUNTID integer NOT NULL
, TOACCOUNTID integer
, PAYEEID integer NOT NULL
, TRANSCODE TEXT NOT NULL /* Withdrawal, Deposit, Transfer */
, TRANSAMOUNT numeric NOT NULL
, STATUS TEXT /* None, Reconciled, Void, Follow up, Duplicate */
, TRANSACTIONNUMBER TEXT
, NOTES TEXT
, CATEGID integer
, SUBCATEGID integer
, TRANSDATE TEXT
, FOLLOWUPID integer
, TOTRANSAMOUNT numeric
);
CREATE INDEX IDX_CHECKINGACCOUNT_ACCOUNT ON CHECKINGACCOUNT (ACCOUNTID, TOACCOUNTID);
CREATE INDEX IDX_CHECKINGACCOUNT_TRANSDATE ON CHECKINGACCOUNT (TRANSDATE);

-- Describe CURRENCYHISTORY
CREATE TABLE CURRENCYHISTORY(
CURRHISTID INTEGER PRIMARY KEY
, CURRENCYID INTEGER NOT NULL
, CURRDATE TEXT NOT NULL
, CURRVALUE NUMERIC NOT NULL
, CURRUPDTYPE INTEGER
, UNIQUE(CURRENCYID, CURRDATE)
);
CREATE INDEX IDX_CURRENCYHISTORY_CURRENCYID_CURRDATE ON CURRENCYHISTORY(CURRENCYID, CURRDATE);

-- Describe CURRENCYFORMATS
CREATE TABLE CURRENCYFORMATS(
CURRENCYID integer primary key
, CURRENCYNAME TEXT COLLATE NOCASE NOT NULL
, PFX_SYMBOL TEXT
, SFX_SYMBOL TEXT
, DECIMAL_POINT TEXT
, GROUP_SEPARATOR TEXT
, SCALE integer
, BASECONVRATE numeric
, CURRENCY_SYMBOL TEXT COLLATE NOCASE NOT NULL UNIQUE
, CURRENCY_TYPE TEXT /* Traditional, Crypto */
, HISTORIC integer DEFAULT 0 /* 1 if no longer official */
);
CREATE INDEX IDX_CURRENCYFORMATS_SYMBOL ON CURRENCYFORMATS(CURRENCY_SYMBOL);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CURRENCYFORMATS VALUES(1,'_tr_US Dollar','$','','.',' ',100,1,'USD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(2,'_tr_Euro','€','','.',' ',100,1,'EUR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(3,'_tr_Pound Sterling','£','','.',' ',100,1,'GBP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(4,'_tr_Russian Ruble','','р',',',' ',100,1,'RUB','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(5,'_tr_Hryvnia','₴','',',',' ',100,1,'UAH','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(6,'_tr_Afghani','؋','','.',' ',100,1,'AFN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(7,'_tr_Lek','','L','.',' ',100,1,'ALL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(8,'_tr_Algerian Dinar','دج','','.',' ',100,1,'DZD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(9,'_tr_Kwanza','','Kz','.',' ',100,1,'AOA','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(10,'_tr_East Caribbean Dollar','EC$','','.',' ',100,1,'XCD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(11,'_tr_Argentine Peso','AR$','',',','.',100,1,'ARS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(12,'_tr_Armenian Dram','','','.',' ',100,1,'AMD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(13,'_tr_Aruban Florin','ƒ','','.',' ',100,1,'AWG','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(14,'_tr_Australian Dollar','$','','.',',',100,1,'AUD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(15,'_tr_Azerbaijan Manat','','','.',' ',100,1,'AZN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(16,'_tr_Bahamian Dollar','B$','','.',' ',100,1,'BSD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(17,'_tr_Bahraini Dinar','','','.',' ',1000,1,'BHD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(18,'_tr_Taka','','','.',' ',100,1,'BDT','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(19,'_tr_Barbados Dollar','Bds$','','.',' ',100,1,'BBD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(20,'_tr_Belarusian Ruble (before 2017-01)','Br','',',',' ',1,1,'BYR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(21,'_tr_Belize Dollar','BZ$','','.',' ',100,1,'BZD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(22,'_tr_CFA Franc BCEAO','CFA','','.',' ',1,1,'XOF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(23,'_tr_Bermudian Dollar','BD$','','.',' ',100,1,'BMD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(24,'_tr_Ngultrum','Nu.','','.',' ',100,1,'BTN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(25,'_tr_Boliviano','Bs.','','.',' ',100,1,'BOB','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(26,'_tr_Convertible Mark','KM','',',','.',100,1,'BAM','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(27,'_tr_Pula','P','','.',' ',100,1,'BWP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(28,'_tr_Brazilian Real','R$','','.',' ',100,1,'BRL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(29,'_tr_Brunei Dollar','B$','','.',' ',100,1,'BND','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(30,'_tr_Bulgarian Lev','','','.',' ',100,1,'BGN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(31,'_tr_Burundi Franc','FBu','','.',' ',1,1,'BIF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(32,'_tr_Riel','','','.',' ',100,1,'KHR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(33,'_tr_CFA Franc BEAC','CFA','','.',' ',1,1,'XAF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(34,'_tr_Canadian Dollar','$','','.',' ',100,1,'CAD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(35,'_tr_Cabo Verde Escudo','Esc','','.',' ',100,1,'CVE','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(36,'_tr_Cayman Islands Dollar','KY$','','.',' ',100,1,'KYD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(37,'_tr_Chilean Peso','$','','.',' ',1,1,'CLP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(38,'_tr_Yuan Renminbi','¥','','.',' ',100,1,'CNY','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(39,'_tr_Colombian Peso','Col$','','.',' ',100,1,'COP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(40,'_tr_Comorian Franc ','','','.',' ',1,1,'KMF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(41,'_tr_Congolese Franc','F','','.',' ',100,1,'CDF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(42,'_tr_Costa Rican Colon','₡','','.',' ',100,1,'CRC','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(43,'_tr_Kuna','kn','','.',' ',100,1,'HRK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(44,'_tr_Czech Koruna','Kč','','.',' ',100,1,'CZK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(45,'_tr_Danish Krone','Kr','','.',' ',100,1,'DKK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(46,'_tr_Djibouti Franc','Fdj','','.',' ',1,1,'DJF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(47,'_tr_Dominican Peso','RD$','','.',' ',100,1,'DOP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(48,'_tr_Egyptian Pound','£','','.',' ',100,1,'EGP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(49,'_tr_Nakfa','Nfa','','.',' ',100,1,'ERN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(50,'_tr_Ethiopian Birr','Br','','.',' ',100,1,'ETB','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(51,'_tr_Falkland Islands Pound','£','','.',' ',100,1,'FKP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(52,'_tr_Fiji Dollar','FJ$','','.',' ',100,1,'FJD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(53,'_tr_CFP Franc','F','','.',' ',1,1,'XPF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(54,'_tr_Dalasi','D','','.',' ',100,1,'GMD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(55,'_tr_Lari','','','.',' ',100,1,'GEL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(56,'_tr_Ghana Cedi','','','.',' ',100,1,'GHS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(57,'_tr_Gibraltar Pound','£','','.',' ',100,1,'GIP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(58,'_tr_Quetzal','Q','','.',' ',100,1,'GTQ','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(59,'_tr_Guinean Franc','FG','','.',' ',1,1,'GNF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(60,'_tr_Guyana Dollar','GY$','','.',' ',100,1,'GYD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(61,'_tr_Gourde','G','','.',' ',100,1,'HTG','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(62,'_tr_Lempira','L','','.',' ',100,1,'HNL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(63,'_tr_Hong Kong Dollar','HK$','','.',' ',100,1,'HKD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(64,'_tr_Forint','Ft','','.',' ',100,1,'HUF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(65,'_tr_Iceland Krona','kr','','.',' ',1,1,'ISK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(66,'_tr_Indian Rupee','₹','','.',' ',100,1,'INR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(67,'_tr_Rupiah','Rp','','.',' ',100,1,'IDR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(68,'_tr_Special Drawing Rights','SDR','','.',' ',100,1,'XDR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(69,'_tr_Iranian Rial','','','.',' ',100,1,'IRR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(70,'_tr_Iraqi Dinar','','','.',' ',1000,1,'IQD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(71,'_tr_New Israeli Sheqel','₪','','.',' ',100,1,'ILS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(72,'_tr_Jamaican Dollar','J$','','.',' ',100,1,'JMD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(73,'_tr_Yen','¥','','.',' ',1,1,'JPY','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(74,'_tr_Jordanian Dinar','','','.',' ',1000,1,'JOD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(75,'_tr_Tenge','T','','.',' ',100,1,'KZT','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(76,'_tr_Kenyan Shilling','KSh','','.',' ',100,1,'KES','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(77,'_tr_North Korean Won','W','','.',' ',100,1,'KPW','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(78,'_tr_Won','W','','.',' ',1,1,'KRW','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(79,'_tr_Kuwaiti Dinar','','','.',' ',1000,1,'KWD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(80,'_tr_Som','','','.',' ',100,1,'KGS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(81,'_tr_Lao Kip','KN','','.',' ',100,1,'LAK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(82,'_tr_Latvian Lats (before 2014-01)','Ls','','.',' ',100,1,'LVL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(83,'_tr_Lebanese Pound','','','.',' ',100,1,'LBP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(84,'_tr_Loti','M','','.',' ',100,1,'LSL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(85,'_tr_Liberian Dollar','L$','','.',' ',100,1,'LRD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(86,'_tr_Libyan Dinar','LD','','.',' ',1000,1,'LYD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(87,'_tr_Lithuanian Litas (before 2014-12)','Lt','','.',' ',100,1,'LTL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(88,'_tr_Pataca','P','','.',' ',100,1,'MOP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(89,'_tr_Denar','','','.',' ',100,1,'MKD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(90,'_tr_Malagasy Ariary','FMG','','.',' ',100,1,'MGA','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(91,'_tr_Malawi Kwacha','MK','','.',' ',100,1,'MWK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(92,'_tr_Malaysian Ringgit','RM','','.',' ',100,1,'MYR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(93,'_tr_Rufiyaa','Rf','','.',' ',100,1,'MVR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(94,'_tr_Ouguiya (before 2017-12)','UM','','.',' ',100,1,'MRO','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(95,'_tr_Mauritius Rupee','Rs','','.',' ',100,1,'MUR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(96,'_tr_Mexican Peso','$','','.',' ',100,1,'MXN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(97,'_tr_Moldovan Leu','','','.',' ',100,1,'MDL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(98,'_tr_Tugrik','₮','','.',' ',100,1,'MNT','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(99,'_tr_Moroccan Dirham','','','.',' ',100,1,'MAD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(100,'_tr_Kyat','K','','.',' ',100,1,'MMK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(101,'_tr_Namibia Dollar','N$','','.',' ',100,1,'NAD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(102,'_tr_Nepalese Rupee','NRs','','.',' ',100,1,'NPR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(103,'_tr_Netherlands Antillean Guilder','NAƒ','','.',' ',100,1,'ANG','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(104,'_tr_New Zealand Dollar','NZ$','','.',' ',100,1,'NZD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(105,'_tr_Cordoba Oro','C$','','.',' ',100,1,'NIO','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(106,'_tr_Naira','₦','','.',' ',100,1,'NGN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(107,'_tr_Norwegian Krone','kr','','.',' ',100,1,'NOK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(108,'_tr_Rial Omani','','','.',' ',1000,1,'OMR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(109,'_tr_Pakistan Rupee','Rs.','','.',' ',100,1,'PKR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(110,'_tr_Balboa','B./','','.',' ',100,1,'PAB','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(111,'_tr_Kina','K','','.',' ',100,1,'PGK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(112,'_tr_Guarani','','','.',' ',1,1,'PYG','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(113,'_tr_Sol','S/.','','.',' ',100,1,'PEN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(114,'_tr_Philippine Piso','₱','','.',' ',100,1,'PHP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(115,'_tr_Zloty','','zł',',','.',100,1,'PLN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(116,'_tr_Qatari Rial','QR','','.',' ',100,1,'QAR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(117,'_tr_Romanian Leu','L','','.',' ',100,1,'RON','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(118,'_tr_Rwanda Franc','RF','','.',' ',1,1,'RWF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(119,'_tr_Dobra (before 2017-12)','Db','','.',' ',00,1,'STD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(120,'_tr_Saudi Riyal','SR','','.',' ',100,1,'SAR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(121,'_tr_Serbian Dinar','din.','','.',' ',100,1,'RSD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(122,'_tr_Seychelles Rupee','SR','','.',' ',100,1,'SCR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(123,'_tr_Leone','Le','','.',' ',100,1,'SLL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(124,'_tr_Singapore Dollar','S$','','.',' ',100,1,'SGD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(125,'_tr_Solomon Islands Dollar','SI$','','.',' ',100,1,'SBD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(126,'_tr_Somali Shilling','Sh.','','.',' ',100,1,'SOS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(127,'_tr_Rand','R','','.',' ',100,1,'ZAR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(128,'_tr_Sri Lanka Rupee','Rs','','.',' ',100,1,'LKR','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(129,'_tr_Saint Helena Pound','£','','.',' ',100,1,'SHP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(130,'_tr_Sudanese Pound','','','.',' ',100,1,'SDG','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(131,'_tr_Surinam Dollar','$','','.',' ',100,1,'SRD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(132,'_tr_Lilangeni','E','','.',' ',100,1,'SZL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(133,'_tr_Swedish Krona','kr','','.',' ',100,1,'SEK','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(134,'_tr_Swiss Franc','Fr.','','.',' ',100,1,'CHF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(135,'_tr_Syrian Pound','','','.',' ',100,1,'SYP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(136,'_tr_New Taiwan Dollar','NT$','','.',' ',100,1,'TWD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(137,'_tr_Somoni','','','.',' ',100,1,'TJS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(138,'_tr_Tanzanian Shilling','','','.',' ',100,1,'TZS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(139,'_tr_Baht','฿','','.',' ',100,1,'THB','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(140,'_tr_Trinidad and Tobago Dollar','TT$','','.',' ',100,1,'TTD','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(141,'_tr_Tunisian Dinar','DT','','.',' ',1000,1,'TND','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(142,'_tr_Turkish Lira','₺','','.',' ',100,1,'TRY','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(143,'_tr_Turkmenistan New Manat','m','','.',' ',100,1,'TMT','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(144,'_tr_Uganda Shilling','USh','','.',' ',1,1,'UGX','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(145,'_tr_UAE Dirham','','','.',' ',100,1,'AED','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(146,'_tr_Peso Uruguayo','$U','','.',' ',100,1,'UYU','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(147,'_tr_Uzbekistan Sum','','','.',' ',100,1,'UZS','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(148,'_tr_Vatu','VT','','.',' ',1,1,'VUV','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(149,'_tr_Dong','₫','','.',' ',1,1,'VND','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(150,'_tr_Tala','WS$','','.',' ',100,1,'WST','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(151,'_tr_Yemeni Rial','','','.',' ',100,1,'YER','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(152,'_tr_Bolívar','Bs.','','.',',',100,1,'VEF','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(153,'_tr_Bitcoin','Ƀ','','.',',',100000000,1,'BTC','Crypto',0);
INSERT INTO CURRENCYFORMATS VALUES(154,'_tr_Andorran Peseta (before 2003-07)','','','.',',',100,1,'ADP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(155,'_tr_Afghani (before 2003-01)','','','.',',',100,1,'AFA','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(156,'_tr_Old Lek (before 1989-12)','','','.',',',100,1,'ALK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(157,'_tr_Kwanza (before 1991-03)','','','.',',',100,1,'AOK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(158,'_tr_New Kwanza (before 2000-02)','','','.',',',100,1,'AON','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(159,'_tr_Kwanza Reajustado (before 2000-02)','','','.',',',100,1,'AOR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(160,'_tr_Austral (before 1992-01)','','','.',',',100,1,'ARA','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(161,'_tr_Peso Argentino (before 1985-07)','','','.',',',100,1,'ARP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(162,'_tr_Peso (1989 to 1990)','','','.',',',100,1,'ARY','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(163,'_tr_Schilling (before 2002-03)','','','.',',',100,1,'ATS','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(164,'_tr_Azerbaijan Manat (before 2005-10)','','','.',',',100,1,'AYM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(165,'_tr_Azerbaijanian Manat (before 2005-12)','','','.',',',100,1,'AZM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(166,'_tr_Dinar (before 1998-07)','','','.',',',100,1,'BAD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(167,'_tr_Convertible Franc (before 1990-03)','','','.',',',100,1,'BEC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(168,'_tr_Belgian Franc (before 2002-03)','','','.',',',100,1,'BEF','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(169,'_tr_Financial Franc (before 1990-03)','','','.',',',100,1,'BEL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(170,'_tr_Lev A/52 (1989 to 1990)','','','.',',',100,1,'BGJ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(171,'_tr_Lev A/62 (1989 to 1990)','','','.',',',100,1,'BGK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(172,'_tr_Lev (before 2003-11)','','','.',',',100,1,'BGL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(173,'_tr_Peso boliviano (before 1987-02)','','','.',',',100,1,'BOP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(174,'_tr_Cruzeiro (before 1986-03)','','','.',',',100,1,'BRB','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(175,'_tr_Cruzado (before 1989-02)','','','.',',',100,1,'BRC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(176,'_tr_Cruzeiro (before 1993-03)','','','.',',',100,1,'BRE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(177,'_tr_New Cruzado (before 1990-03)','','','.',',',100,1,'BRN','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(178,'_tr_Cruzeiro Real (before 1994-07)','','','.',',',100,1,'BRR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(179,'_tr_Kyat (before 1990-02)','','','.',',',100,1,'BUK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(180,'_tr_Belarusian Ruble (before 2001-01)','','','.',',',100,1,'BYB','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(181,'_tr_Belarusian Ruble','','','.',',',100,1,'BYN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(182,'_tr_WIR Franc (for electronic) (before 2004-11)','','','.',',',100,1,'CHC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(183,'_tr_Serbian Dinar (before 2006-10)','','','.',',',100,1,'CSD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(184,'_tr_Krona A/53 (1989 to 1990)','','','.',',',100,1,'CSJ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(185,'_tr_Koruna (before 1993-03)','','','.',',',100,1,'CSK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(186,'_tr_Peso Convertible','','','.',',',100,1,'CUC','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(187,'_tr_Cuban Peso','','','.',',',100,1,'CUP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(188,'_tr_Cyprus Pound (before 2008-01)','','','.',',',100,1,'CYP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(189,'_tr_Mark der DDR (1990-07 to 1990-09)','','','.',',',100,1,'DDM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(190,'_tr_Deutsche Mark (before 2002-03)','','','.',',',100,1,'DEM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(191,'_tr_Sucre (before 2000-09)','','','.',',',100,1,'ECS','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(192,'_tr_Unidad de Valor Constante (UVC) (before 2000-09)','','','.',',',100,1,'ECV','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(193,'_tr_Kroon (before 2011-01)','','','.',',',100,1,'EEK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(194,'_tr_Spanish Peseta (1978 to 1981)','','','.',',',100,1,'ESA','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(195,'_tr_A Account (convertible Peseta Account) (before 1994-12)','','','.',',',100,1,'ESB','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(196,'_tr_Spanish Peseta (before 2002-03)','','','.',',',100,1,'ESP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(197,'_tr_Markka (before 2002-03)','','','.',',',100,1,'FIM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(198,'_tr_French Franc (before 1999-01)','','','.',',',100,1,'FRF','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(199,'_tr_Georgian Coupon (before 1995-10)','','','.',',',100,1,'GEK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(200,'_tr_Cedi (before 2008-01)','','','.',',',100,1,'GHC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(201,'_tr_Ghana Cedi (before 2007-06)','','','.',',',100,1,'GHP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(202,'_tr_Syli (before 1989-12)','','','.',',',100,1,'GNE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(203,'_tr_Syli (before 1986-02)','','','.',',',100,1,'GNS','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(204,'_tr_Ekwele (before 1986-06)','','','.',',',100,1,'GQE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(205,'_tr_Drachma (before 2002-03)','','','.',',',100,1,'GRD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(206,'_tr_Guinea Escudo (1978 to 1981)','','','.',',',100,1,'GWE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(207,'_tr_Guinea-Bissau Peso (before 1997-05)','','','.',',',100,1,'GWP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(208,'_tr_Croatian Dinar (before 1995-01)','','','.',',',100,1,'HRD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(209,'_tr_Irish Pound (before 2002-03)','','','.',',',100,1,'IEP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(210,'_tr_Pound (1978 to 1981)','','','.',',',100,1,'ILP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(211,'_tr_Old Shekel (1989 to 1990)','','','.',',',100,1,'ILR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(212,'_tr_Old Krona (1989 to 1990)','','','.',',',100,1,'ISJ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(213,'_tr_Italian Lira (before 2002-03)','','','.',',',100,1,'ITL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(214,'_tr_Pathet Lao Kip (before 1979-12)','','','.',',',100,1,'LAJ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(215,'_tr_Loti (before 1985-05)','','','.',',',100,1,'LSM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(216,'_tr_Talonas (before 1993-07)','','','.',',',100,1,'LTT','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(217,'_tr_Luxembourg Convertible Franc (before 1990-03)','','','.',',',100,1,'LUC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(218,'_tr_Luxembourg Franc (before 2002-03)','','','.',',',100,1,'LUF','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(219,'_tr_Luxembourg Financial Franc (before 1990-03)','','','.',',',100,1,'LUL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(220,'_tr_Latvian Ruble (before 1994-12)','','','.',',',100,1,'LVR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(221,'_tr_Malagasy Franc (before 2004-12)','','','.',',',100,1,'MGF','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(222,'_tr_Mali Franc (before 1984-11)','','','.',',',100,1,'MLF','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(223,'_tr_Ouguiya','','','.',',',100,1,'MRU','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(224,'_tr_Maltese Lira (before 2008-01)','','','.',',',100,1,'MTL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(225,'_tr_Maltese Pound (before 1983-06)','','','.',',',100,1,'MTP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(226,'_tr_Maldive Rupee (before 1989-12)','','','.',',',100,1,'MVQ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(227,'_tr_Mexican Peso (before 1993-01)','','','.',',',100,1,'MXP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(228,'_tr_Mozambique Escudo (1978 to 1981)','','','.',',',100,1,'MZE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(229,'_tr_Mozambique Metical (before 2006-06)','','','.',',',100,1,'MZM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(230,'_tr_Mozambique Metical','','','.',',',100,1,'MZN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(231,'_tr_Cordoba (before 1990-10)','','','.',',',100,1,'NIC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(232,'_tr_Netherlands Guilder (before 2002-03)','','','.',',',100,1,'NLG','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(233,'_tr_Sol (1989 to 1990)','','','.',',',100,1,'PEH','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(234,'_tr_Inti (before 1991-07)','','','.',',',100,1,'PEI','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(235,'_tr_Sol (before 1986-02)','','','.',',',100,1,'PES','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(236,'_tr_Zloty (before 1997-01)','','','.',',',100,1,'PLZ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(237,'_tr_Portuguese Escudo (before 2002-03)','','','.',',',100,1,'PTE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(238,'_tr_Rhodesian Dollar (1978 to 1981)','','','.',',',100,1,'RHD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(239,'_tr_Leu A/52 (1989 to 1990)','','','.',',',100,1,'ROK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(240,'_tr_Old Leu (before 2005-06)','','','.',',',100,1,'ROL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(241,'_tr_Russian Ruble (before 1994-07)','','','.',',',100,1,'RUR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(242,'_tr_Sudanese Dinar (before 2007-07)','','','.',',',100,1,'SDD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(243,'_tr_Sudanese Pound (before 1998-06)','','','.',',',100,1,'SDP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(244,'_tr_Tolar (before 2007-01)','','','.',',',100,1,'SIT','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(245,'_tr_Slovak Koruna (before 2009-01)','','','.',',',100,1,'SKK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(246,'_tr_Surinam Guilder (before 2003-12)','','','.',',',100,1,'SRG','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(247,'_tr_South Sudanese Pound','','','.',',',100,1,'SSP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(248,'_tr_Dobra','','','.',',',100,1,'STN','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(249,'_tr_Rouble (before 1990-12)','','','.',',',100,1,'SUR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(250,'_tr_El Salvador Colon','','','.',',',100,1,'SVC','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(251,'_tr_Tajik Ruble (before 2001-04)','','','.',',',100,1,'TJR','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(252,'_tr_Turkmenistan Manat (before 2009-01)','','','.',',',100,1,'TMM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(253,'_tr_Pa’anga','','','.',',',100,1,'TOP','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(254,'_tr_Timor Escudo (before 2002-11)','','','.',',',100,1,'TPE','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(255,'_tr_Old Turkish Lira (before 2005-12)','','','.',',',100,1,'TRL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(256,'_tr_Karbovanet (before 1996-09)','','','.',',',100,1,'UAK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(257,'_tr_Uganda Shilling (before 1987-05)','','','.',',',100,1,'UGS','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(258,'_tr_Old Shilling (1989 to 1990)','','','.',',',100,1,'UGW','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(259,'_tr_US Dollar (Same day) (before 2014-03)','','','.',',',100,1,'USS','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(260,'_tr_Old Uruguay Peso (before 1989-12)','','','.',',',100,1,'UYN','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(261,'_tr_Uruguayan Peso (before 1993-03)','','','.',',',100,1,'UYP','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(262,'_tr_Bolivar (before 2008-01)','','','.',',',100,1,'VEB','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(263,'_tr_Old Dong (1989-1990)','','','.',',',100,1,'VNC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(264,'_tr_European Currency Unit (E.C.U) (before 1999-01)','','','.',',',100,1,'XEU','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(265,'_tr_Gold-Franc (before 2006-10)','','','.',',',100,1,'XFO','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(266,'_tr_Yemeni Dinar (before 1991-09)','','','.',',',100,1,'YDD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(267,'_tr_New Yugoslavian Dinar (before 1990-01)','','','.',',',100,1,'YUD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(268,'_tr_New Dinar (before 2003-07)','','','.',',',100,1,'YUM','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(269,'_tr_Yugoslavian Dinar (before 1995-11)','','','.',',',100,1,'YUN','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(270,'_tr_Financial Rand (before 1995-03)','','','.',',',100,1,'ZAL','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(271,'_tr_Zambian Kwacha (before 2012-12)','','','.',',',100,1,'ZMK','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(272,'_tr_Zambian Kwacha','','','.',',',100,1,'ZMW','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(273,'_tr_New Zaire (before 1999-06)','','','.',',',100,1,'ZRN','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(274,'_tr_Zaire (before 1994-02)','','','.',',',100,1,'ZRZ','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(275,'_tr_Rhodesian Dollar (before 1989-12)','','','.',',',100,1,'ZWC','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(276,'_tr_Zimbabwe Dollar (before 2008-08)','','','.',',',100,1,'ZWD','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(277,'_tr_Zimbabwe Dollar','','','.',',',100,1,'ZWL','Traditional',0);
INSERT INTO CURRENCYFORMATS VALUES(278,'_tr_Zimbabwe Dollar (new) (before 2006-09)','','','.',',',100,1,'ZWN','Traditional',1);
INSERT INTO CURRENCYFORMATS VALUES(279,'_tr_Zimbabwe Dollar (before 2009-06)','','','.',',',100,1,'ZWR','Traditional',1);

-- Describe INFOTABLE
CREATE TABLE INFOTABLE(
INFOID integer not null primary key
, INFONAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, INFOVALUE TEXT NOT NULL
);
CREATE INDEX IDX_INFOTABLE_INFONAME ON INFOTABLE(INFONAME);

INSERT INTO INFOTABLE VALUES(1, 'DATAVERSION', '3');

-- Describe PAYEE
CREATE TABLE PAYEE(
PAYEEID integer primary key
, PAYEENAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, CATEGID integer
, SUBCATEGID integer
);
CREATE INDEX IDX_PAYEE_INFONAME ON PAYEE(PAYEENAME);

-- Describe SPLITTRANSACTIONS
CREATE TABLE SPLITTRANSACTIONS(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
CREATE INDEX IDX_SPLITTRANSACTIONS_TRANSID ON SPLITTRANSACTIONS(TRANSID);

-- Describe STOCK
CREATE TABLE STOCK(
STOCKID integer primary key
, HELDAT integer
, PURCHASEDATE TEXT NOT NULL
, STOCKNAME TEXT COLLATE NOCASE NOT NULL
, SYMBOL TEXT
, NUMSHARES numeric
, PURCHASEPRICE numeric NOT NULL
, NOTES TEXT
, CURRENTPRICE numeric NOT NULL
, VALUE numeric
, COMMISSION numeric
);
CREATE INDEX IDX_STOCK_HELDAT ON STOCK(HELDAT);

-- Describe STOCKHISTORY
CREATE TABLE STOCKHISTORY(
HISTID integer primary key
, SYMBOL TEXT NOT NULL
, DATE TEXT NOT NULL
, VALUE numeric NOT NULL
, UPDTYPE integer
, UNIQUE(SYMBOL, DATE)
);
CREATE INDEX IDX_STOCKHISTORY_SYMBOL ON STOCKHISTORY(SYMBOL);

-- Describe SUBCATEGORY
CREATE TABLE SUBCATEGORY(
SUBCATEGID integer primary key
, SUBCATEGNAME TEXT COLLATE NOCASE NOT NULL
, CATEGID integer NOT NULL
, UNIQUE(CATEGID, SUBCATEGNAME)
);
CREATE INDEX IDX_SUBCATEGORY_CATEGID ON SUBCATEGORY(CATEGID);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO SUBCATEGORY VALUES(1,'_tr_Telephone',1);
INSERT INTO SUBCATEGORY VALUES(2,'_tr_Electricity',1);
INSERT INTO SUBCATEGORY VALUES(3,'_tr_Gas',1);
INSERT INTO SUBCATEGORY VALUES(4,'_tr_Internet',1);
INSERT INTO SUBCATEGORY VALUES(5,'_tr_Rent',1);
INSERT INTO SUBCATEGORY VALUES(6,'_tr_Cable TV',1);
INSERT INTO SUBCATEGORY VALUES(7,'_tr_Water',1);
INSERT INTO SUBCATEGORY VALUES(8,'_tr_Groceries',2);
INSERT INTO SUBCATEGORY VALUES(9,'_tr_Dining out',2);
INSERT INTO SUBCATEGORY VALUES(10,'_tr_Movies',3);
INSERT INTO SUBCATEGORY VALUES(11,'_tr_Video Rental',3);
INSERT INTO SUBCATEGORY VALUES(12,'_tr_Magazines',3);
INSERT INTO SUBCATEGORY VALUES(13,'_tr_Maintenance',4);
INSERT INTO SUBCATEGORY VALUES(14,'_tr_Gas',4);
INSERT INTO SUBCATEGORY VALUES(15,'_tr_Parking',4);
INSERT INTO SUBCATEGORY VALUES(16,'_tr_Registration',4);
INSERT INTO SUBCATEGORY VALUES(17,'_tr_Books',5);
INSERT INTO SUBCATEGORY VALUES(18,'_tr_Tuition',5);
INSERT INTO SUBCATEGORY VALUES(19,'_tr_Others',5);
INSERT INTO SUBCATEGORY VALUES(20,'_tr_Clothing',6);
INSERT INTO SUBCATEGORY VALUES(21,'_tr_Furnishing',6);
INSERT INTO SUBCATEGORY VALUES(22,'_tr_Others',6);
INSERT INTO SUBCATEGORY VALUES(23,'_tr_Health',7);
INSERT INTO SUBCATEGORY VALUES(24,'_tr_Dental',7);
INSERT INTO SUBCATEGORY VALUES(25,'_tr_Eyecare',7);
INSERT INTO SUBCATEGORY VALUES(26,'_tr_Physician',7);
INSERT INTO SUBCATEGORY VALUES(27,'_tr_Prescriptions',7);
INSERT INTO SUBCATEGORY VALUES(28,'_tr_Auto',8);
INSERT INTO SUBCATEGORY VALUES(29,'_tr_Life',8);
INSERT INTO SUBCATEGORY VALUES(30,'_tr_Home',8);
INSERT INTO SUBCATEGORY VALUES(31,'_tr_Health',8);
INSERT INTO SUBCATEGORY VALUES(32,'_tr_Travel',9);
INSERT INTO SUBCATEGORY VALUES(33,'_tr_Lodging',9);
INSERT INTO SUBCATEGORY VALUES(34,'_tr_Sightseeing',9);
INSERT INTO SUBCATEGORY VALUES(35,'_tr_Income Tax',10);
INSERT INTO SUBCATEGORY VALUES(36,'_tr_House Tax',10);
INSERT INTO SUBCATEGORY VALUES(37,'_tr_Water Tax',10);
INSERT INTO SUBCATEGORY VALUES(38,'_tr_Others',10);
INSERT INTO SUBCATEGORY VALUES(39,'_tr_Salary',13);
INSERT INTO SUBCATEGORY VALUES(40,'_tr_Reimbursement/Refunds',13);
INSERT INTO SUBCATEGORY VALUES(41,'_tr_Investment Income',13);

-- Describe SETTING_V1
create table SETTING_V1(
SETTINGID integer not null primary key
, SETTINGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, SETTINGVALUE TEXT
);
CREATE INDEX IDX_SETTING_SETTINGNAME ON SETTING_V1(SETTINGNAME);

-- Describe REPORT
create table REPORT(
REPORTID integer not null primary key
, REPORTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, GROUPNAME TEXT COLLATE NOCASE
, SQLCONTENT TEXT
, LUACONTENT TEXT
, TEMPLATECONTENT TEXT
, DESCRIPTION TEXT
);
CREATE INDEX INDEX_REPORT_NAME ON REPORT(REPORTNAME);

-- Describe ATTACHMENT
CREATE TABLE ATTACHMENT (
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, REFID INTEGER NOT NULL
, DESCRIPTION TEXT COLLATE NOCASE
, FILENAME TEXT NOT NULL COLLATE NOCASE
);
CREATE INDEX IDX_ATTACHMENT_REF ON ATTACHMENT (REFTYPE, REFID);

-- Describe USAGE_V1
CREATE TABLE USAGE_V1 (
USAGEID INTEGER NOT NULL PRIMARY KEY
, USAGEDATE TEXT NOT NULL
, JSONCONTENT TEXT NOT NULL
);
CREATE INDEX IDX_USAGE_DATE ON USAGE_V1 (USAGEDATE);

-- Asset Classes
CREATE TABLE ASSETCLASS (
ID INTEGER primary key
, PARENTID INTEGER
, NAME TEXT COLLATE NOCASE NOT NULL
, ALLOCATION REAL
, SORTORDER INTEGER
);

-- Asset Class / Stock link table
CREATE TABLE ASSETCLASS_STOCK (
ID INTEGER primary key
, ASSETCLASSID INTEGER NOT NULL
, STOCKSYMBOL TEXT UNIQUE
);

-- Describe CUSTOMFIELD
CREATE TABLE CUSTOMFIELD (
FIELDID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, DESCRIPTION TEXT COLLATE NOCASE
, TYPE TEXT NOT NULL /* String, Integer, Decimal, Boolean, Date, Time, SingleChoice, MultiChoice */
, PROPERTIES TEXT NOT NULL
);
CREATE INDEX IDX_CUSTOMFIELD_REF ON CUSTOMFIELD (REFTYPE);

-- Describe CUSTOMFIELDDATA
CREATE TABLE CUSTOMFIELDDATA (
FIELDATADID INTEGER NOT NULL PRIMARY KEY
, FIELDID INTEGER NOT NULL
, REFID INTEGER NOT NULL
, CONTENT TEXT
, UNIQUE(FIELDID, REFID)
);
CREATE INDEX IDX_CUSTOMFIELDDATA_REF ON CUSTOMFIELDDATA (FIELDID, REFID);

-- describe TRANSACTIONLINK
CREATE TABLE TRANSLINK (
TRANSLINKID  integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, LINKTYPE TEXT NOT NULL /* Asset, Stock */
, LINKRECORDID integer NOT NULL
);
CREATE INDEX IDX_LINKRECORD ON TRANSLINK (LINKTYPE, LINKRECORDID);
CREATE INDEX IDX_CHECKINGACCOUNT ON TRANSLINK (CHECKINGACCOUNTID);

-- describe SHAREINFO
CREATE TABLE SHAREINFO (
SHAREINFOID integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, SHARENUMBER numeric
, SHAREPRICE numeric
, SHARECOMMISSION numeric
, SHARELOT TEXT
);
CREATE INDEX IDX_SHAREINFO ON SHAREINFO (CHECKINGACCOUNTID);

PRAGMA user_version = 12;