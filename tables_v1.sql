-- Describe ACCOUNTLIST_V1
CREATE TABLE ACCOUNTLIST_V1(
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
CREATE INDEX IDX_ACCOUNTLIST_ACCOUNTTYPE ON ACCOUNTLIST_V1(ACCOUNTTYPE);

-- Describe ASSETS_V1
CREATE TABLE ASSETS_V1(
ASSETID integer primary key
, STARTDATE TEXT NOT NULL
, ASSETNAME TEXT COLLATE NOCASE NOT NULL
, VALUE numeric
, VALUECHANGE TEXT /* None, Appreciates, Depreciates */
, NOTES TEXT
, VALUECHANGERATE numeric
, ASSETTYPE TEXT /* Property, Automobile, Household Object, Art, Jewellery, Cash, Other */
);
CREATE INDEX IDX_ASSETS_ASSETTYPE ON ASSETS_V1(ASSETTYPE);

-- Describe BILLSDEPOSITS_V1
CREATE TABLE BILLSDEPOSITS_V1(
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
CREATE INDEX IDX_BILLSDEPOSITS_ACCOUNT ON BILLSDEPOSITS_V1 (ACCOUNTID, TOACCOUNTID);

-- Describe BUDGETSPLITTRANSACTIONS_V1
CREATE TABLE BUDGETSPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
CREATE INDEX IDX_BUDGETSPLITTRANSACTIONS_TRANSID ON BUDGETSPLITTRANSACTIONS_V1(TRANSID);

-- Describe BUDGETTABLE_V1
CREATE TABLE BUDGETTABLE_V1(
BUDGETENTRYID integer primary key
, BUDGETYEARID integer
, CATEGID integer
, SUBCATEGID integer
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily*/
, AMOUNT numeric NOT NULL
);
CREATE INDEX IDX_BUDGETTABLE_BUDGETYEARID ON BUDGETTABLE_V1(BUDGETYEARID);

-- Describe BUDGETYEAR_V1
CREATE TABLE BUDGETYEAR_V1(
BUDGETYEARID integer primary key
, BUDGETYEARNAME TEXT NOT NULL UNIQUE
);
CREATE INDEX IDX_BUDGETYEAR_BUDGETYEARNAME ON BUDGETYEAR_V1(BUDGETYEARNAME);

-- Describe CATEGORY_V1
CREATE TABLE CATEGORY_V1(
CATEGID integer primary key
, CATEGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
);
CREATE INDEX IDX_CATEGORY_CATEGNAME ON CATEGORY_V1(CATEGNAME);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CATEGORY_V1 VALUES(1,'_tr_Bills');
INSERT INTO CATEGORY_V1 VALUES(2,'_tr_Food');
INSERT INTO CATEGORY_V1 VALUES(3,'_tr_Leisure');
INSERT INTO CATEGORY_V1 VALUES(4,'_tr_Automobile');
INSERT INTO CATEGORY_V1 VALUES(5,'_tr_Education');
INSERT INTO CATEGORY_V1 VALUES(6,'_tr_Homeneeds');
INSERT INTO CATEGORY_V1 VALUES(7,'_tr_Healthcare');
INSERT INTO CATEGORY_V1 VALUES(8,'_tr_Insurance');
INSERT INTO CATEGORY_V1 VALUES(9,'_tr_Vacation');
INSERT INTO CATEGORY_V1 VALUES(10,'_tr_Taxes');
INSERT INTO CATEGORY_V1 VALUES(11,'_tr_Miscellaneous');
INSERT INTO CATEGORY_V1 VALUES(12,'_tr_Gifts');
INSERT INTO CATEGORY_V1 VALUES(13,'_tr_Income');
INSERT INTO CATEGORY_V1 VALUES(14,'_tr_Other Income');
INSERT INTO CATEGORY_V1 VALUES(15,'_tr_Other Expenses');
INSERT INTO CATEGORY_V1 VALUES(16,'_tr_Transfer');

-- Describe CHECKINGACCOUNT_V1
CREATE TABLE CHECKINGACCOUNT_V1(
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
CREATE INDEX IDX_CHECKINGACCOUNT_ACCOUNT ON CHECKINGACCOUNT_V1 (ACCOUNTID, TOACCOUNTID);
CREATE INDEX IDX_CHECKINGACCOUNT_TRANSDATE ON CHECKINGACCOUNT_V1 (TRANSDATE);

-- Describe CURRENCYHISTORY_V1
CREATE TABLE CURRENCYHISTORY_V1(
CURRHISTID INTEGER PRIMARY KEY
, CURRENCYID INTEGER NOT NULL
, CURRDATE TEXT NOT NULL
, CURRVALUE NUMERIC NOT NULL
, CURRUPDTYPE INTEGER
, UNIQUE(CURRENCYID, CURRDATE)
);
CREATE INDEX IDX_CURRENCYHISTORY_CURRENCYID_CURRDATE ON CURRENCYHISTORY_V1(CURRENCYID, CURRDATE);

-- Describe CURRENCYFORMATS_V1
CREATE TABLE CURRENCYFORMATS_V1(
CURRENCYID integer primary key
, CURRENCYNAME TEXT COLLATE NOCASE NOT NULL
, PFX_SYMBOL TEXT
, SFX_SYMBOL TEXT
, DECIMAL_POINT TEXT
, GROUP_SEPARATOR TEXT
, SCALE integer
, BASECONVRATE numeric
, CURRENCY_SYMBOL TEXT COLLATE NOCASE NOT NULL UNIQUE
, CURRENCY_TYPE TEXT /* Fiat, Crypto */
, HISTORIC integer DEFAULT 0 /* 1 if no longer official */
);
CREATE INDEX IDX_CURRENCYFORMATS_SYMBOL ON CURRENCYFORMATS_V1(CURRENCY_SYMBOL);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CURRENCYFORMATS_V1 VALUES(1,'_tr_US Dollar','$','','.',' ',100,1,'USD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(2,'_tr_Euro','€','','.',' ',100,1,'EUR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(3,'_tr_Pound Sterling','£','','.',' ',100,1,'GBP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(4,'_tr_Russian Ruble','','р',',',' ',100,1,'RUB','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(5,'_tr_Hryvnia','₴','',',',' ',100,1,'UAH','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(6,'_tr_Afghani','؋','','.',' ',100,1,'AFN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(7,'_tr_Lek','','L','.',' ',100,1,'ALL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(8,'_tr_Algerian Dinar','دج','','.',' ',100,1,'DZD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(9,'_tr_Kwanza','','Kz','.',' ',100,1,'AOA','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(10,'_tr_East Caribbean Dollar','EC$','','.',' ',100,1,'XCD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(11,'_tr_Argentine Peso','AR$','',',','.',100,1,'ARS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(12,'_tr_Armenian Dram','','','.',' ',100,1,'AMD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(13,'_tr_Aruban Florin','ƒ','','.',' ',100,1,'AWG','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(14,'_tr_Australian Dollar','$','','.',',',100,1,'AUD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(15,'_tr_Azerbaijan Manat','','','.',' ',100,1,'AZN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(16,'_tr_Bahamian Dollar','B$','','.',' ',100,1,'BSD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(17,'_tr_Bahraini Dinar','','','.',' ',1000,1,'BHD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(18,'_tr_Taka','','','.',' ',100,1,'BDT','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(19,'_tr_Barbados Dollar','Bds$','','.',' ',100,1,'BBD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(20,'_tr_Belarusian Ruble (before 2017-01)','Br','',',',' ',1,1,'BYR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(21,'_tr_Belize Dollar','BZ$','','.',' ',100,1,'BZD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(22,'_tr_CFA Franc BCEAO','CFA','','.',' ',1,1,'XOF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(23,'_tr_Bermudian Dollar','BD$','','.',' ',100,1,'BMD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(24,'_tr_Ngultrum','Nu.','','.',' ',100,1,'BTN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(25,'_tr_Boliviano','Bs.','','.',' ',100,1,'BOB','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(26,'_tr_Convertible Mark','KM','',',','.',100,1,'BAM','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(27,'_tr_Pula','P','','.',' ',100,1,'BWP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(28,'_tr_Brazilian Real','R$','','.',' ',100,1,'BRL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(29,'_tr_Brunei Dollar','B$','','.',' ',100,1,'BND','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(30,'_tr_Bulgarian Lev','','','.',' ',100,1,'BGN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(31,'_tr_Burundi Franc','FBu','','.',' ',1,1,'BIF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(32,'_tr_Riel','','','.',' ',100,1,'KHR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(33,'_tr_CFA Franc BEAC','CFA','','.',' ',1,1,'XAF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(34,'_tr_Canadian Dollar','$','','.',' ',100,1,'CAD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(35,'_tr_Cabo Verde Escudo','Esc','','.',' ',100,1,'CVE','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(36,'_tr_Cayman Islands Dollar','KY$','','.',' ',100,1,'KYD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(37,'_tr_Chilean Peso','$','','.',' ',1,1,'CLP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(38,'_tr_Yuan Renminbi','¥','','.',' ',100,1,'CNY','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(39,'_tr_Colombian Peso','Col$','','.',' ',100,1,'COP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(40,'_tr_Comorian Franc ','','','.',' ',1,1,'KMF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(41,'_tr_Congolese Franc','F','','.',' ',100,1,'CDF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(42,'_tr_Costa Rican Colon','₡','','.',' ',100,1,'CRC','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(43,'_tr_Kuna','kn','','.',' ',100,1,'HRK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(44,'_tr_Czech Koruna','Kč','','.',' ',100,1,'CZK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(45,'_tr_Danish Krone','Kr','','.',' ',100,1,'DKK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(46,'_tr_Djibouti Franc','Fdj','','.',' ',1,1,'DJF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(47,'_tr_Dominican Peso','RD$','','.',' ',100,1,'DOP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(48,'_tr_Egyptian Pound','£','','.',' ',100,1,'EGP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(49,'_tr_Nakfa','Nfa','','.',' ',100,1,'ERN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(50,'_tr_Ethiopian Birr','Br','','.',' ',100,1,'ETB','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(51,'_tr_Falkland Islands Pound','£','','.',' ',100,1,'FKP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(52,'_tr_Fiji Dollar','FJ$','','.',' ',100,1,'FJD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(53,'_tr_CFP Franc','F','','.',' ',1,1,'XPF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(54,'_tr_Dalasi','D','','.',' ',100,1,'GMD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(55,'_tr_Lari','','','.',' ',100,1,'GEL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(56,'_tr_Ghana Cedi','','','.',' ',100,1,'GHS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(57,'_tr_Gibraltar Pound','£','','.',' ',100,1,'GIP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(58,'_tr_Quetzal','Q','','.',' ',100,1,'GTQ','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(59,'_tr_Guinean Franc','FG','','.',' ',1,1,'GNF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(60,'_tr_Guyana Dollar','GY$','','.',' ',100,1,'GYD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(61,'_tr_Gourde','G','','.',' ',100,1,'HTG','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(62,'_tr_Lempira','L','','.',' ',100,1,'HNL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(63,'_tr_Hong Kong Dollar','HK$','','.',' ',100,1,'HKD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(64,'_tr_Forint','Ft','','.',' ',100,1,'HUF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(65,'_tr_Iceland Krona','kr','','.',' ',1,1,'ISK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(66,'_tr_Indian Rupee','₹','','.',' ',100,1,'INR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(67,'_tr_Rupiah','Rp','','.',' ',100,1,'IDR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(68,'_tr_Special Drawing Rights','SDR','','.',' ',100,1,'XDR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(69,'_tr_Iranian Rial','','','.',' ',100,1,'IRR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(70,'_tr_Iraqi Dinar','','','.',' ',1000,1,'IQD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(71,'_tr_New Israeli Sheqel','₪','','.',' ',100,1,'ILS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(72,'_tr_Jamaican Dollar','J$','','.',' ',100,1,'JMD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(73,'_tr_Yen','¥','','.',' ',1,1,'JPY','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(74,'_tr_Jordanian Dinar','','','.',' ',1000,1,'JOD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(75,'_tr_Tenge','T','','.',' ',100,1,'KZT','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(76,'_tr_Kenyan Shilling','KSh','','.',' ',100,1,'KES','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(77,'_tr_North Korean Won','W','','.',' ',100,1,'KPW','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(78,'_tr_Won','W','','.',' ',1,1,'KRW','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(79,'_tr_Kuwaiti Dinar','','','.',' ',1000,1,'KWD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(80,'_tr_Som','','','.',' ',100,1,'KGS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(81,'_tr_Lao Kip','KN','','.',' ',100,1,'LAK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(82,'_tr_Latvian Lats (before 2014-01)','Ls','','.',' ',100,1,'LVL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(83,'_tr_Lebanese Pound','','','.',' ',100,1,'LBP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(84,'_tr_Loti','M','','.',' ',100,1,'LSL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(85,'_tr_Liberian Dollar','L$','','.',' ',100,1,'LRD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(86,'_tr_Libyan Dinar','LD','','.',' ',1000,1,'LYD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(87,'_tr_Lithuanian Litas (before 2014-12)','Lt','','.',' ',100,1,'LTL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(88,'_tr_Pataca','P','','.',' ',100,1,'MOP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(89,'_tr_Denar','','','.',' ',100,1,'MKD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(90,'_tr_Malagasy Ariary','FMG','','.',' ',100,1,'MGA','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(91,'_tr_Malawi Kwacha','MK','','.',' ',100,1,'MWK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(92,'_tr_Malaysian Ringgit','RM','','.',' ',100,1,'MYR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(93,'_tr_Rufiyaa','Rf','','.',' ',100,1,'MVR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(94,'_tr_Ouguiya (before 2017-12)','UM','','.',' ',100,1,'MRO','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(95,'_tr_Mauritius Rupee','Rs','','.',' ',100,1,'MUR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(96,'_tr_Mexican Peso','$','','.',' ',100,1,'MXN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(97,'_tr_Moldovan Leu','','','.',' ',100,1,'MDL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(98,'_tr_Tugrik','₮','','.',' ',100,1,'MNT','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(99,'_tr_Moroccan Dirham','','','.',' ',100,1,'MAD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(100,'_tr_Kyat','K','','.',' ',100,1,'MMK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(101,'_tr_Namibia Dollar','N$','','.',' ',100,1,'NAD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(102,'_tr_Nepalese Rupee','NRs','','.',' ',100,1,'NPR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(103,'_tr_Netherlands Antillean Guilder','NAƒ','','.',' ',100,1,'ANG','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(104,'_tr_New Zealand Dollar','NZ$','','.',' ',100,1,'NZD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(105,'_tr_Cordoba Oro','C$','','.',' ',100,1,'NIO','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(106,'_tr_Naira','₦','','.',' ',100,1,'NGN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(107,'_tr_Norwegian Krone','kr','','.',' ',100,1,'NOK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(108,'_tr_Rial Omani','','','.',' ',1000,1,'OMR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(109,'_tr_Pakistan Rupee','Rs.','','.',' ',100,1,'PKR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(110,'_tr_Balboa','B./','','.',' ',100,1,'PAB','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(111,'_tr_Kina','K','','.',' ',100,1,'PGK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(112,'_tr_Guarani','','','.',' ',1,1,'PYG','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(113,'_tr_Sol','S/.','','.',' ',100,1,'PEN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(114,'_tr_Philippine Piso','₱','','.',' ',100,1,'PHP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(115,'_tr_Zloty','','zł',',','.',100,1,'PLN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(116,'_tr_Qatari Rial','QR','','.',' ',100,1,'QAR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(117,'_tr_Romanian Leu','L','','.',' ',100,1,'RON','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(118,'_tr_Rwanda Franc','RF','','.',' ',1,1,'RWF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(119,'_tr_Dobra (before 2017-12)','Db','','.',' ',00,1,'STD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(120,'_tr_Saudi Riyal','SR','','.',' ',100,1,'SAR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(121,'_tr_Serbian Dinar','din.','','.',' ',100,1,'RSD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(122,'_tr_Seychelles Rupee','SR','','.',' ',100,1,'SCR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(123,'_tr_Leone','Le','','.',' ',100,1,'SLL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(124,'_tr_Singapore Dollar','S$','','.',' ',100,1,'SGD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(125,'_tr_Solomon Islands Dollar','SI$','','.',' ',100,1,'SBD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(126,'_tr_Somali Shilling','Sh.','','.',' ',100,1,'SOS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(127,'_tr_Rand','R','','.',' ',100,1,'ZAR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(128,'_tr_Sri Lanka Rupee','Rs','','.',' ',100,1,'LKR','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(129,'_tr_Saint Helena Pound','£','','.',' ',100,1,'SHP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(130,'_tr_Sudanese Pound','','','.',' ',100,1,'SDG','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(131,'_tr_Surinam Dollar','$','','.',' ',100,1,'SRD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(132,'_tr_Lilangeni','E','','.',' ',100,1,'SZL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(133,'_tr_Swedish Krona','kr','','.',' ',100,1,'SEK','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(134,'_tr_Swiss Franc','Fr.','','.',' ',100,1,'CHF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(135,'_tr_Syrian Pound','','','.',' ',100,1,'SYP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(136,'_tr_New Taiwan Dollar','NT$','','.',' ',100,1,'TWD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(137,'_tr_Somoni','','','.',' ',100,1,'TJS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(138,'_tr_Tanzanian Shilling','','','.',' ',100,1,'TZS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(139,'_tr_Baht','฿','','.',' ',100,1,'THB','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(140,'_tr_Trinidad and Tobago Dollar','TT$','','.',' ',100,1,'TTD','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(141,'_tr_Tunisian Dinar','DT','','.',' ',1000,1,'TND','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(142,'_tr_Turkish Lira','₺','','.',' ',100,1,'TRY','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(143,'_tr_Turkmenistan New Manat','m','','.',' ',100,1,'TMT','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(144,'_tr_Uganda Shilling','USh','','.',' ',1,1,'UGX','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(145,'_tr_UAE Dirham','','','.',' ',100,1,'AED','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(146,'_tr_Peso Uruguayo','$U','','.',' ',100,1,'UYU','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(147,'_tr_Uzbekistan Sum','','','.',' ',100,1,'UZS','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(148,'_tr_Vatu','VT','','.',' ',1,1,'VUV','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(149,'_tr_Dong','₫','','.',' ',1,1,'VND','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(150,'_tr_Tala','WS$','','.',' ',100,1,'WST','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(151,'_tr_Yemeni Rial','','','.',' ',100,1,'YER','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(152,'_tr_Bolívar','Bs.','','.',',',100,1,'VEF','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(153,'_tr_Bitcoin','Ƀ','','.',',',100000000,1,'BTC','Crypto',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(154,'_tr_Andorran Peseta (before 2003-07)','','','.',',',100,1,'ADP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(155,'_tr_Afghani (before 2003-01)','','','.',',',100,1,'AFA','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(156,'_tr_Old Lek (before 1989-12)','','','.',',',100,1,'ALK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(157,'_tr_Kwanza (before 1991-03)','','','.',',',100,1,'AOK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(158,'_tr_New Kwanza (before 2000-02)','','','.',',',100,1,'AON','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(159,'_tr_Kwanza Reajustado (before 2000-02)','','','.',',',100,1,'AOR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(160,'_tr_Austral (before 1992-01)','','','.',',',100,1,'ARA','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(161,'_tr_Peso Argentino (before 1985-07)','','','.',',',100,1,'ARP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(162,'_tr_Peso (1989 to 1990)','','','.',',',100,1,'ARY','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(163,'_tr_Schilling (before 2002-03)','','','.',',',100,1,'ATS','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(164,'_tr_Azerbaijan Manat (before 2005-10)','','','.',',',100,1,'AYM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(165,'_tr_Azerbaijanian Manat (before 2005-12)','','','.',',',100,1,'AZM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(166,'_tr_Dinar (before 1998-07)','','','.',',',100,1,'BAD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(167,'_tr_Convertible Franc (before 1990-03)','','','.',',',100,1,'BEC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(168,'_tr_Belgian Franc (before 2002-03)','','','.',',',100,1,'BEF','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(169,'_tr_Financial Franc (before 1990-03)','','','.',',',100,1,'BEL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(170,'_tr_Lev A/52 (1989 to 1990)','','','.',',',100,1,'BGJ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(171,'_tr_Lev A/62 (1989 to 1990)','','','.',',',100,1,'BGK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(172,'_tr_Lev (before 2003-11)','','','.',',',100,1,'BGL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(173,'_tr_Peso boliviano (before 1987-02)','','','.',',',100,1,'BOP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(174,'_tr_Cruzeiro (before 1986-03)','','','.',',',100,1,'BRB','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(175,'_tr_Cruzado (before 1989-02)','','','.',',',100,1,'BRC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(176,'_tr_Cruzeiro (before 1993-03)','','','.',',',100,1,'BRE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(177,'_tr_New Cruzado (before 1990-03)','','','.',',',100,1,'BRN','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(178,'_tr_Cruzeiro Real (before 1994-07)','','','.',',',100,1,'BRR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(179,'_tr_Kyat (before 1990-02)','','','.',',',100,1,'BUK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(180,'_tr_Belarusian Ruble (before 2001-01)','','','.',',',100,1,'BYB','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(181,'_tr_Belarusian Ruble','','','.',',',100,1,'BYN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(182,'_tr_WIR Franc (for electronic) (before 2004-11)','','','.',',',100,1,'CHC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(183,'_tr_Serbian Dinar (before 2006-10)','','','.',',',100,1,'CSD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(184,'_tr_Krona A/53 (1989 to 1990)','','','.',',',100,1,'CSJ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(185,'_tr_Koruna (before 1993-03)','','','.',',',100,1,'CSK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(186,'_tr_Peso Convertible','','','.',',',100,1,'CUC','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(187,'_tr_Cuban Peso','','','.',',',100,1,'CUP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(188,'_tr_Cyprus Pound (before 2008-01)','','','.',',',100,1,'CYP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(189,'_tr_Mark der DDR (1990-07 to 1990-09)','','','.',',',100,1,'DDM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(190,'_tr_Deutsche Mark (before 2002-03)','','','.',',',100,1,'DEM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(191,'_tr_Sucre (before 2000-09)','','','.',',',100,1,'ECS','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(192,'_tr_Unidad de Valor Constante (UVC) (before 2000-09)','','','.',',',100,1,'ECV','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(193,'_tr_Kroon (before 2011-01)','','','.',',',100,1,'EEK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(194,'_tr_Spanish Peseta (1978 to 1981)','','','.',',',100,1,'ESA','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(195,'_tr_A Account (convertible Peseta Account) (before 1994-12)','','','.',',',100,1,'ESB','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(196,'_tr_Spanish Peseta (before 2002-03)','','','.',',',100,1,'ESP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(197,'_tr_Markka (before 2002-03)','','','.',',',100,1,'FIM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(198,'_tr_French Franc (before 1999-01)','','','.',',',100,1,'FRF','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(199,'_tr_Georgian Coupon (before 1995-10)','','','.',',',100,1,'GEK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(200,'_tr_Cedi (before 2008-01)','','','.',',',100,1,'GHC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(201,'_tr_Ghana Cedi (before 2007-06)','','','.',',',100,1,'GHP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(202,'_tr_Syli (before 1989-12)','','','.',',',100,1,'GNE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(203,'_tr_Syli (before 1986-02)','','','.',',',100,1,'GNS','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(204,'_tr_Ekwele (before 1986-06)','','','.',',',100,1,'GQE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(205,'_tr_Drachma (before 2002-03)','','','.',',',100,1,'GRD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(206,'_tr_Guinea Escudo (1978 to 1981)','','','.',',',100,1,'GWE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(207,'_tr_Guinea-Bissau Peso (before 1997-05)','','','.',',',100,1,'GWP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(208,'_tr_Croatian Dinar (before 1995-01)','','','.',',',100,1,'HRD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(209,'_tr_Irish Pound (before 2002-03)','','','.',',',100,1,'IEP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(210,'_tr_Pound (1978 to 1981)','','','.',',',100,1,'ILP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(211,'_tr_Old Shekel (1989 to 1990)','','','.',',',100,1,'ILR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(212,'_tr_Old Krona (1989 to 1990)','','','.',',',100,1,'ISJ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(213,'_tr_Italian Lira (before 2002-03)','','','.',',',100,1,'ITL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(214,'_tr_Pathet Lao Kip (before 1979-12)','','','.',',',100,1,'LAJ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(215,'_tr_Loti (before 1985-05)','','','.',',',100,1,'LSM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(216,'_tr_Talonas (before 1993-07)','','','.',',',100,1,'LTT','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(217,'_tr_Luxembourg Convertible Franc (before 1990-03)','','','.',',',100,1,'LUC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(218,'_tr_Luxembourg Franc (before 2002-03)','','','.',',',100,1,'LUF','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(219,'_tr_Luxembourg Financial Franc (before 1990-03)','','','.',',',100,1,'LUL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(220,'_tr_Latvian Ruble (before 1994-12)','','','.',',',100,1,'LVR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(221,'_tr_Malagasy Franc (before 2004-12)','','','.',',',100,1,'MGF','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(222,'_tr_Mali Franc (before 1984-11)','','','.',',',100,1,'MLF','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(223,'_tr_Ouguiya','','','.',',',100,1,'MRU','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(224,'_tr_Maltese Lira (before 2008-01)','','','.',',',100,1,'MTL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(225,'_tr_Maltese Pound (before 1983-06)','','','.',',',100,1,'MTP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(226,'_tr_Maldive Rupee (before 1989-12)','','','.',',',100,1,'MVQ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(227,'_tr_Mexican Peso (before 1993-01)','','','.',',',100,1,'MXP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(228,'_tr_Mozambique Escudo (1978 to 1981)','','','.',',',100,1,'MZE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(229,'_tr_Mozambique Metical (before 2006-06)','','','.',',',100,1,'MZM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(230,'_tr_Mozambique Metical','','','.',',',100,1,'MZN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(231,'_tr_Cordoba (before 1990-10)','','','.',',',100,1,'NIC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(232,'_tr_Netherlands Guilder (before 2002-03)','','','.',',',100,1,'NLG','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(233,'_tr_Sol (1989 to 1990)','','','.',',',100,1,'PEH','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(234,'_tr_Inti (before 1991-07)','','','.',',',100,1,'PEI','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(235,'_tr_Sol (before 1986-02)','','','.',',',100,1,'PES','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(236,'_tr_Zloty (before 1997-01)','','','.',',',100,1,'PLZ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(237,'_tr_Portuguese Escudo (before 2002-03)','','','.',',',100,1,'PTE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(238,'_tr_Rhodesian Dollar (1978 to 1981)','','','.',',',100,1,'RHD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(239,'_tr_Leu A/52 (1989 to 1990)','','','.',',',100,1,'ROK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(240,'_tr_Old Leu (before 2005-06)','','','.',',',100,1,'ROL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(241,'_tr_Russian Ruble (before 1994-07)','','','.',',',100,1,'RUR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(242,'_tr_Sudanese Dinar (before 2007-07)','','','.',',',100,1,'SDD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(243,'_tr_Sudanese Pound (before 1998-06)','','','.',',',100,1,'SDP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(244,'_tr_Tolar (before 2007-01)','','','.',',',100,1,'SIT','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(245,'_tr_Slovak Koruna (before 2009-01)','','','.',',',100,1,'SKK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(246,'_tr_Surinam Guilder (before 2003-12)','','','.',',',100,1,'SRG','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(247,'_tr_South Sudanese Pound','','','.',',',100,1,'SSP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(248,'_tr_Dobra','','','.',',',100,1,'STN','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(249,'_tr_Rouble (before 1990-12)','','','.',',',100,1,'SUR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(250,'_tr_El Salvador Colon','','','.',',',100,1,'SVC','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(251,'_tr_Tajik Ruble (before 2001-04)','','','.',',',100,1,'TJR','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(252,'_tr_Turkmenistan Manat (before 2009-01)','','','.',',',100,1,'TMM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(253,'_tr_Pa’anga','','','.',',',100,1,'TOP','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(254,'_tr_Timor Escudo (before 2002-11)','','','.',',',100,1,'TPE','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(255,'_tr_Old Turkish Lira (before 2005-12)','','','.',',',100,1,'TRL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(256,'_tr_Karbovanet (before 1996-09)','','','.',',',100,1,'UAK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(257,'_tr_Uganda Shilling (before 1987-05)','','','.',',',100,1,'UGS','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(258,'_tr_Old Shilling (1989 to 1990)','','','.',',',100,1,'UGW','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(259,'_tr_US Dollar (Same day) (before 2014-03)','','','.',',',100,1,'USS','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(260,'_tr_Old Uruguay Peso (before 1989-12)','','','.',',',100,1,'UYN','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(261,'_tr_Uruguayan Peso (before 1993-03)','','','.',',',100,1,'UYP','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(262,'_tr_Bolivar (before 2008-01)','','','.',',',100,1,'VEB','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(263,'_tr_Old Dong (1989-1990)','','','.',',',100,1,'VNC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(264,'_tr_European Currency Unit (E.C.U) (before 1999-01)','','','.',',',100,1,'XEU','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(265,'_tr_Gold-Franc (before 2006-10)','','','.',',',100,1,'XFO','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(266,'_tr_Yemeni Dinar (before 1991-09)','','','.',',',100,1,'YDD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(267,'_tr_New Yugoslavian Dinar (before 1990-01)','','','.',',',100,1,'YUD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(268,'_tr_New Dinar (before 2003-07)','','','.',',',100,1,'YUM','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(269,'_tr_Yugoslavian Dinar (before 1995-11)','','','.',',',100,1,'YUN','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(270,'_tr_Financial Rand (before 1995-03)','','','.',',',100,1,'ZAL','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(271,'_tr_Zambian Kwacha (before 2012-12)','','','.',',',100,1,'ZMK','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(272,'_tr_Zambian Kwacha','','','.',',',100,1,'ZMW','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(273,'_tr_New Zaire (before 1999-06)','','','.',',',100,1,'ZRN','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(274,'_tr_Zaire (before 1994-02)','','','.',',',100,1,'ZRZ','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(275,'_tr_Rhodesian Dollar (before 1989-12)','','','.',',',100,1,'ZWC','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(276,'_tr_Zimbabwe Dollar (before 2008-08)','','','.',',',100,1,'ZWD','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(277,'_tr_Zimbabwe Dollar','','','.',',',100,1,'ZWL','Fiat',0);
INSERT INTO CURRENCYFORMATS_V1 VALUES(278,'_tr_Zimbabwe Dollar (new) (before 2006-09)','','','.',',',100,1,'ZWN','Fiat',1);
INSERT INTO CURRENCYFORMATS_V1 VALUES(279,'_tr_Zimbabwe Dollar (before 2009-06)','','','.',',',100,1,'ZWR','Fiat',1);

-- Describe INFOTABLE_V1
CREATE TABLE INFOTABLE_V1(
INFOID integer not null primary key
, INFONAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, INFOVALUE TEXT NOT NULL
);
CREATE INDEX IDX_INFOTABLE_INFONAME ON INFOTABLE_V1(INFONAME);

INSERT INTO INFOTABLE_V1 VALUES(1, 'DATAVERSION', '3');

-- Describe PAYEE_V1
CREATE TABLE PAYEE_V1(
PAYEEID integer primary key
, PAYEENAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, CATEGID integer
, SUBCATEGID integer
);
CREATE INDEX IDX_PAYEE_INFONAME ON PAYEE_V1(PAYEENAME);

-- Describe SPLITTRANSACTIONS_V1
CREATE TABLE SPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
CREATE INDEX IDX_SPLITTRANSACTIONS_TRANSID ON SPLITTRANSACTIONS_V1(TRANSID);

-- Describe SPLITTRANSACTIONS_V2
CREATE TABLE SPLITTRANSACTIONS_V2(
SPLITTRANSID integer primary key
, ACCOUNTID integer NOT NULL
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
, NOTES TEXT
);
CREATE INDEX IDX_SPLITTRANSACTIONS_V2_ACCOUNTID ON SPLITTRANSACTIONS_V2(ACCOUNTID);
CREATE INDEX IDX_SPLITTRANSACTIONS_V2_TRANSID ON SPLITTRANSACTIONS_V2(TRANSID);

-- Describe STOCK_V1
CREATE TABLE STOCK_V1(
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
CREATE INDEX IDX_STOCK_HELDAT ON STOCK_V1(HELDAT);

-- Describe STOCKHISTORY_V1
CREATE TABLE STOCKHISTORY_V1(
HISTID integer primary key
, SYMBOL TEXT NOT NULL
, DATE TEXT NOT NULL
, VALUE numeric NOT NULL
, UPDTYPE integer
, UNIQUE(SYMBOL, DATE)
);
CREATE INDEX IDX_STOCKHISTORY_SYMBOL ON STOCKHISTORY_V1(SYMBOL);

-- Describe SUBCATEGORY_V1
CREATE TABLE SUBCATEGORY_V1(
SUBCATEGID integer primary key
, SUBCATEGNAME TEXT COLLATE NOCASE NOT NULL
, CATEGID integer NOT NULL
, UNIQUE(CATEGID, SUBCATEGNAME)
);
CREATE INDEX IDX_SUBCATEGORY_CATEGID ON SUBCATEGORY_V1(CATEGID);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO SUBCATEGORY_V1 VALUES(1,'_tr_Telephone',1);
INSERT INTO SUBCATEGORY_V1 VALUES(2,'_tr_Electricity',1);
INSERT INTO SUBCATEGORY_V1 VALUES(3,'_tr_Gas',1);
INSERT INTO SUBCATEGORY_V1 VALUES(4,'_tr_Internet',1);
INSERT INTO SUBCATEGORY_V1 VALUES(5,'_tr_Rent',1);
INSERT INTO SUBCATEGORY_V1 VALUES(6,'_tr_Cable TV',1);
INSERT INTO SUBCATEGORY_V1 VALUES(7,'_tr_Water',1);
INSERT INTO SUBCATEGORY_V1 VALUES(8,'_tr_Groceries',2);
INSERT INTO SUBCATEGORY_V1 VALUES(9,'_tr_Dining out',2);
INSERT INTO SUBCATEGORY_V1 VALUES(10,'_tr_Movies',3);
INSERT INTO SUBCATEGORY_V1 VALUES(11,'_tr_Video Rental',3);
INSERT INTO SUBCATEGORY_V1 VALUES(12,'_tr_Magazines',3);
INSERT INTO SUBCATEGORY_V1 VALUES(13,'_tr_Maintenance',4);
INSERT INTO SUBCATEGORY_V1 VALUES(14,'_tr_Gas',4);
INSERT INTO SUBCATEGORY_V1 VALUES(15,'_tr_Parking',4);
INSERT INTO SUBCATEGORY_V1 VALUES(16,'_tr_Registration',4);
INSERT INTO SUBCATEGORY_V1 VALUES(17,'_tr_Books',5);
INSERT INTO SUBCATEGORY_V1 VALUES(18,'_tr_Tuition',5);
INSERT INTO SUBCATEGORY_V1 VALUES(19,'_tr_Others',5);
INSERT INTO SUBCATEGORY_V1 VALUES(20,'_tr_Clothing',6);
INSERT INTO SUBCATEGORY_V1 VALUES(21,'_tr_Furnishing',6);
INSERT INTO SUBCATEGORY_V1 VALUES(22,'_tr_Others',6);
INSERT INTO SUBCATEGORY_V1 VALUES(23,'_tr_Health',7);
INSERT INTO SUBCATEGORY_V1 VALUES(24,'_tr_Dental',7);
INSERT INTO SUBCATEGORY_V1 VALUES(25,'_tr_Eyecare',7);
INSERT INTO SUBCATEGORY_V1 VALUES(26,'_tr_Physician',7);
INSERT INTO SUBCATEGORY_V1 VALUES(27,'_tr_Prescriptions',7);
INSERT INTO SUBCATEGORY_V1 VALUES(28,'_tr_Auto',8);
INSERT INTO SUBCATEGORY_V1 VALUES(29,'_tr_Life',8);
INSERT INTO SUBCATEGORY_V1 VALUES(30,'_tr_Home',8);
INSERT INTO SUBCATEGORY_V1 VALUES(31,'_tr_Health',8);
INSERT INTO SUBCATEGORY_V1 VALUES(32,'_tr_Travel',9);
INSERT INTO SUBCATEGORY_V1 VALUES(33,'_tr_Lodging',9);
INSERT INTO SUBCATEGORY_V1 VALUES(34,'_tr_Sightseeing',9);
INSERT INTO SUBCATEGORY_V1 VALUES(35,'_tr_Income Tax',10);
INSERT INTO SUBCATEGORY_V1 VALUES(36,'_tr_House Tax',10);
INSERT INTO SUBCATEGORY_V1 VALUES(37,'_tr_Water Tax',10);
INSERT INTO SUBCATEGORY_V1 VALUES(38,'_tr_Others',10);
INSERT INTO SUBCATEGORY_V1 VALUES(39,'_tr_Salary',13);
INSERT INTO SUBCATEGORY_V1 VALUES(40,'_tr_Reimbursement/Refunds',13);
INSERT INTO SUBCATEGORY_V1 VALUES(41,'_tr_Investment Income',13);

-- Describe SETTING_V1
create table SETTING_V1(
SETTINGID integer not null primary key
, SETTINGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, SETTINGVALUE TEXT
);
CREATE INDEX IDX_SETTING_SETTINGNAME ON SETTING_V1(SETTINGNAME);

-- Describe REPORT_V1
create table REPORT_V1(
REPORTID integer not null primary key
, REPORTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, GROUPNAME TEXT COLLATE NOCASE
, SQLCONTENT TEXT
, LUACONTENT TEXT
, TEMPLATECONTENT TEXT
, DESCRIPTION TEXT
);
CREATE INDEX INDEX_REPORT_NAME ON REPORT_V1(REPORTNAME);

-- Describe ATTACHMENT_V1
CREATE TABLE ATTACHMENT_V1 (
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, REFID INTEGER NOT NULL
, DESCRIPTION TEXT COLLATE NOCASE
, FILENAME TEXT NOT NULL COLLATE NOCASE
);
CREATE INDEX IDX_ATTACHMENT_REF ON ATTACHMENT_V1 (REFTYPE, REFID);

-- Describe USAGE_V1
CREATE TABLE USAGE_V1 (
USAGEID INTEGER NOT NULL PRIMARY KEY
, USAGEDATE TEXT NOT NULL
, JSONCONTENT TEXT NOT NULL
);
CREATE INDEX IDX_USAGE_DATE ON USAGE_V1 (USAGEDATE);

-- Asset Classes
CREATE TABLE ASSETCLASS_V1 (
ID INTEGER primary key
, PARENTID INTEGER
, NAME TEXT COLLATE NOCASE NOT NULL
, ALLOCATION REAL
, SORTORDER INTEGER
);

-- Asset Class / Stock link table
CREATE TABLE ASSETCLASS_STOCK_V1 (
ID INTEGER primary key
, ASSETCLASSID INTEGER NOT NULL
, STOCKSYMBOL TEXT UNIQUE
);

-- Describe CUSTOMFIELD_V1
CREATE TABLE CUSTOMFIELD_V1 (
FIELDID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, DESCRIPTION TEXT COLLATE NOCASE
, TYPE TEXT NOT NULL /* String, Integer, Decimal, Boolean, Date, Time, SingleChoice, MultiChoice */
, PROPERTIES TEXT NOT NULL
);
CREATE INDEX IDX_CUSTOMFIELD_REF ON CUSTOMFIELD_V1 (REFTYPE);

-- Describe CUSTOMFIELDDATA_V1
CREATE TABLE CUSTOMFIELDDATA_V1 (
FIELDATADID INTEGER NOT NULL PRIMARY KEY
, FIELDID INTEGER NOT NULL
, REFID INTEGER NOT NULL
, CONTENT TEXT
, UNIQUE(FIELDID, REFID)
);
CREATE INDEX IDX_CUSTOMFIELDDATA_REF ON CUSTOMFIELDDATA_V1 (FIELDID, REFID);

-- describe TRANSACTIONLINK_V1
CREATE TABLE TRANSLINK_V1 (
TRANSLINKID  integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, LINKTYPE TEXT NOT NULL /* Asset, Stock */
, LINKRECORDID integer NOT NULL
);
CREATE INDEX IDX_LINKRECORD ON TRANSLINK_V1 (LINKTYPE, LINKRECORDID);
CREATE INDEX IDX_CHECKINGACCOUNT ON TRANSLINK_V1 (CHECKINGACCOUNTID);

-- describe SHAREINFO_V1
CREATE TABLE SHAREINFO_V1 (
SHAREINFOID integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, SHARENUMBER numeric
, SHAREPRICE numeric
, SHARECOMMISSION numeric
, SHARELOT TEXT
);
CREATE INDEX IDX_SHAREINFO ON SHAREINFO_V1 (CHECKINGACCOUNTID);
