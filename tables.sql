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
, INITIALDATE TEXT
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
, ASSETSTATUS TEXT /* Open, Closed */
, CURRENCYID integer
, VALUECHANGEMODE TEXT /* Percentage, Linear */
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
, SPLITTRANSAMOUNT numeric
, NOTES TEXT
);
CREATE INDEX IDX_BUDGETSPLITTRANSACTIONS_TRANSID ON BUDGETSPLITTRANSACTIONS_V1(TRANSID);

-- Describe BUDGETTABLE_V1
CREATE TABLE BUDGETTABLE_V1(
BUDGETENTRYID integer primary key
, BUDGETYEARID integer
, CATEGID integer
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily*/
, AMOUNT numeric NOT NULL
, NOTES TEXT
, ACTIVE integer
);
CREATE INDEX IDX_BUDGETTABLE_BUDGETYEARID ON BUDGETTABLE_V1(BUDGETYEARID);

-- Describe BUDGETYEAR_V1
CREATE TABLE BUDGETYEAR_V1(
BUDGETYEARID integer primary key
, BUDGETYEARNAME TEXT NOT NULL UNIQUE
);
CREATE INDEX IDX_BUDGETYEAR_BUDGETYEARNAME ON BUDGETYEAR_V1(BUDGETYEARNAME);

-- Describe CATEGORY_V1
CREATE TABLE CATEGORY_V1
( CATEGID INTEGER PRIMARY KEY,
  CATEGNAME TEXT NOT NULL COLLATE NOCASE,
  ACTIVE INTEGER,
  PARENTID INTEGER,
  UNIQUE(CATEGNAME, PARENTID)
);
CREATE INDEX IDX_CATEGORY_CATEGNAME ON CATEGORY_V1(CATEGNAME);
CREATE INDEX IDX_CATEGORY_CATEGNAME_PARENTID ON CATEGORY_V1(CATEGNAME, PARENTID);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CATEGORY_V1 VALUES(1,'_tr_Bills',1,-1);
INSERT INTO CATEGORY_V1 VALUES(2,'_tr_Telephone',1,1);
INSERT INTO CATEGORY_V1 VALUES(3,'_tr_Electricity',1,1);
INSERT INTO CATEGORY_V1 VALUES(4,'_tr_Gas',1,1);
INSERT INTO CATEGORY_V1 VALUES(5,'_tr_Internet',1,1);
INSERT INTO CATEGORY_V1 VALUES(6,'_tr_Rent',1,1);
INSERT INTO CATEGORY_V1 VALUES(7,'_tr_Cable TV',1,1);
INSERT INTO CATEGORY_V1 VALUES(8,'_tr_Water',1,1);
INSERT INTO CATEGORY_V1 VALUES(9,'_tr_Food',1,-1);
INSERT INTO CATEGORY_V1 VALUES(10,'_tr_Groceries',1,9);
INSERT INTO CATEGORY_V1 VALUES(11,'_tr_Dining out',1,9);
INSERT INTO CATEGORY_V1 VALUES(12,'_tr_Leisure',1,-1);
INSERT INTO CATEGORY_V1 VALUES(13,'_tr_Movies',1,12);
INSERT INTO CATEGORY_V1 VALUES(14,'_tr_Video Rental',1,12);
INSERT INTO CATEGORY_V1 VALUES(15,'_tr_Magazines',1,12);
INSERT INTO CATEGORY_V1 VALUES(16,'_tr_Automobile',1,-1);
INSERT INTO CATEGORY_V1 VALUES(17,'_tr_Maintenance',1,16);
INSERT INTO CATEGORY_V1 VALUES(18,'_tr_Gas',1,16);
INSERT INTO CATEGORY_V1 VALUES(19,'_tr_Parking',1,16);
INSERT INTO CATEGORY_V1 VALUES(20,'_tr_Registration',1,16);
INSERT INTO CATEGORY_V1 VALUES(21,'_tr_Education',1,-1);
INSERT INTO CATEGORY_V1 VALUES(22,'_tr_Books',1,21);
INSERT INTO CATEGORY_V1 VALUES(23,'_tr_Tuition',1,21);
INSERT INTO CATEGORY_V1 VALUES(24,'_tr_Others',1,21);
INSERT INTO CATEGORY_V1 VALUES(25,'_tr_Homeneeds',1,-1);
INSERT INTO CATEGORY_V1 VALUES(26,'_tr_Clothing',1,25);
INSERT INTO CATEGORY_V1 VALUES(27,'_tr_Furnishing',1,25);
INSERT INTO CATEGORY_V1 VALUES(28,'_tr_Others',1,25);
INSERT INTO CATEGORY_V1 VALUES(29,'_tr_Healthcare',1,-1);
INSERT INTO CATEGORY_V1 VALUES(30,'_tr_Health',1,29);
INSERT INTO CATEGORY_V1 VALUES(31,'_tr_Dental',1,29);
INSERT INTO CATEGORY_V1 VALUES(32,'_tr_Eyecare',1,29);
INSERT INTO CATEGORY_V1 VALUES(33,'_tr_Physician',1,29);
INSERT INTO CATEGORY_V1 VALUES(34,'_tr_Prescriptions',1,29);
INSERT INTO CATEGORY_V1 VALUES(35,'_tr_Insurance',1,-1);
INSERT INTO CATEGORY_V1 VALUES(36,'_tr_Auto',1,35);
INSERT INTO CATEGORY_V1 VALUES(37,'_tr_Life',1,35);
INSERT INTO CATEGORY_V1 VALUES(38,'_tr_Home',1,35);
INSERT INTO CATEGORY_V1 VALUES(39,'_tr_Health',1,35);
INSERT INTO CATEGORY_V1 VALUES(40,'_tr_Vacation',1,-1);
INSERT INTO CATEGORY_V1 VALUES(41,'_tr_Travel',1,40);
INSERT INTO CATEGORY_V1 VALUES(42,'_tr_Lodging',1,40);
INSERT INTO CATEGORY_V1 VALUES(43,'_tr_Sightseeing',1,40);
INSERT INTO CATEGORY_V1 VALUES(44,'_tr_Taxes',1,-1);
INSERT INTO CATEGORY_V1 VALUES(45,'_tr_Income Tax',1,44);
INSERT INTO CATEGORY_V1 VALUES(46,'_tr_House Tax',1,44);
INSERT INTO CATEGORY_V1 VALUES(47,'_tr_Water Tax',1,44);
INSERT INTO CATEGORY_V1 VALUES(48,'_tr_Others',1,44);
INSERT INTO CATEGORY_V1 VALUES(49,'_tr_Miscellaneous',1,-1);
INSERT INTO CATEGORY_V1 VALUES(50,'_tr_Gifts',1,-1);
INSERT INTO CATEGORY_V1 VALUES(51,'_tr_Income',1,-1);
INSERT INTO CATEGORY_V1 VALUES(52,'_tr_Salary',1,51);
INSERT INTO CATEGORY_V1 VALUES(53,'_tr_Reimbursement/Refunds',1,51);
INSERT INTO CATEGORY_V1 VALUES(54,'_tr_Investment Income',1,51);
INSERT INTO CATEGORY_V1 VALUES(55,'_tr_Other Income',1,-1);
INSERT INTO CATEGORY_V1 VALUES(56,'_tr_Other Expenses',1,-1);
INSERT INTO CATEGORY_V1 VALUES(57,'_tr_Transfer',1,-1);

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
, TRANSDATE TEXT
, LASTUPDATEDTIME TEXT
, DELETEDTIME TEXT
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
, CURRENCYNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, PFX_SYMBOL TEXT
, SFX_SYMBOL TEXT
, DECIMAL_POINT TEXT
, GROUP_SEPARATOR TEXT
, UNIT_NAME TEXT COLLATE NOCASE
, CENT_NAME TEXT COLLATE NOCASE
, SCALE integer
, BASECONVRATE numeric
, CURRENCY_SYMBOL TEXT COLLATE NOCASE NOT NULL UNIQUE
, CURRENCY_TYPE TEXT NOT NULL /* Fiat, Crypto */
);
CREATE INDEX IDX_CURRENCYFORMATS_SYMBOL ON CURRENCYFORMATS_V1(CURRENCY_SYMBOL);

-- Note: All strings requiring translation are prefix by: '_tr_'
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CURRENCYFORMATS_V1 VALUES(1,'_tr_US dollar','$','','.',' ','','',100,1,'USD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(2,'_tr_Euro','€','','.',' ','','',100,1,'EUR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(3,'_tr_British pound','£','','.',' ','Pound','Pence',100,1,'GBP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(4,'_tr_Russian ruble','','р',',',' ','руб.','коп.',100,1,'RUB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(5,'_tr_Ukrainian hryvnia','₴','',',',' ','','',100,1,'UAH','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(6,'_tr_Afghan afghani','؋','','.',' ','','pul',100,1,'AFN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(7,'_tr_Albanian lek','','L','.',' ','','',1,1,'ALL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(8,'_tr_Algerian dinar','دج','','.',' ','','',100,1,'DZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(9,'_tr_Angolan kwanza','','Kz','.',' ','','Céntimo',100,1,'AOA','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(10,'_tr_East Caribbean dollar','EC$','','.',' ','','',100,1,'XCD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(11,'_tr_Argentine peso','AR$','',',','.','','centavo',100,1,'ARS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(12,'_tr_Armenian dram','','','.',' ','','',1,1,'AMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(13,'_tr_Aruban florin','ƒ','','.',' ','','',100,1,'AWG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(14,'_tr_Australian dollar','$','','.',',','','',100,1,'AUD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(15,'_tr_Azerbaijani manat','','','.',' ','','',100,1,'AZN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(16,'_tr_Bahamian dollar','B$','','.',' ','','',100,1,'BSD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(17,'_tr_Bahraini dinar','','','.',' ','','',100,1,'BHD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(18,'_tr_Bangladeshi taka','','','.',' ','','',100,1,'BDT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(19,'_tr_Barbadian dollar','Bds$','','.',' ','','',100,1,'BBD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(20,'_tr_Belarusian ruble (2000-2016)','Br','',',',' ','','',1,1,'BYR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(21,'_tr_Belize dollar','BZ$','','.',' ','','',100,1,'BZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(22,'_tr_West African CFA franc','CFA','','.',' ','','',100,1,'XOF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(23,'_tr_Bermudan dollar','BD$','','.',' ','','',100,1,'BMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(24,'_tr_Bhutanese ngultrum','Nu.','','.',' ','','',100,1,'BTN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(25,'_tr_Bolivian boliviano','Bs.','','.',' ','','',100,1,'BOB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(26,'_tr_Bosnia-Herzegovina convertible mark','KM','',',','.','','',100,1,'BAM','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(27,'_tr_Botswanan pula','P','','.',' ','','',100,1,'BWP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(28,'_tr_Brazilian real','R$','','.',' ','','',100,1,'BRL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(29,'_tr_Brunei dollar','B$','','.',' ','','',100,1,'BND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(30,'_tr_Bulgarian lev','','','.',' ','','',100,1,'BGN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(31,'_tr_Burundian franc','FBu','','.',' ','','',1,1,'BIF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(32,'_tr_Cambodian riel','','','.',' ','','',100,1,'KHR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(33,'_tr_Central African CFA franc','CFA','','.',' ','','',1,1,'XAF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(34,'_tr_Canadian dollar','$','','.',' ','','',100,1,'CAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(35,'_tr_Cape Verdean escudo','Esc','','.',' ','','',100,1,'CVE','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(36,'_tr_Cayman Islands dollar','KY$','','.',' ','','',100,1,'KYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(37,'_tr_Chilean peso','$','','.',' ','','',1,1,'CLP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(38,'_tr_Chinese yuan','¥','','.',' ','','',100,1,'CNY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(39,'_tr_Colombian peso','Col$','','.',' ','','',100,1,'COP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(40,'_tr_Comorian franc','','','.',' ','','',1,1,'KMF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(41,'_tr_Congolese franc','F','','.',' ','','',100,1,'CDF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(42,'Costa Rican colón','₡','','.',' ','','',1,1,'CRC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(43,'_tr_Croatian kuna','kn','','.',' ','','',100,1,'HRK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(44,'_tr_Czech koruna','Kč','','.',' ','','',100,1,'CZK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(45,'_tr_Danish krone','Kr','','.',' ','','',100,1,'DKK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(46,'_tr_Djiboutian franc','Fdj','','.',' ','','',1,1,'DJF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(47,'_tr_Dominican peso','RD$','','.',' ','','',100,1,'DOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(48,'_tr_Egyptian pound','£','','.',' ','','',100,1,'EGP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(49,'_tr_Eritrean nakfa','Nfa','','.',' ','','',100,1,'ERN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(50,'_tr_Ethiopian birr','Br','','.',' ','','',100,1,'ETB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(51,'_tr_Falkland Islands pound','£','','.',' ','','',100,1,'FKP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(52,'_tr_Fijian dollar','FJ$','','.',' ','','',100,1,'FJD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(53,'_tr_CFP franc','F','','.',' ','','',100,1,'XPF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(54,'_tr_Gambian dalasi','D','','.',' ','','',100,1,'GMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(55,'_tr_Georgian lari','','','.',' ','','',100,1,'GEL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(56,'_tr_Ghanaian cedi','','','.',' ','','',100,1,'GHS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(57,'_tr_Gibraltar pound','£','','.',' ','','',100,1,'GIP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(58,'_tr_Guatemalan quetzal','Q','','.',' ','','',100,1,'GTQ','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(59,'_tr_Guinean franc','FG','','.',' ','','',1,1,'GNF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(60,'_tr_Guyanaese dollar','GY$','','.',' ','','',100,1,'GYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(61,'_tr_Haitian gourde','G','','.',' ','','',100,1,'HTG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(62,'_tr_Honduran lempira','L','','.',' ','','',100,1,'HNL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(63,'_tr_Hong Kong dollar','HK$','','.',' ','','',100,1,'HKD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(64,'_tr_Hungarian forint','Ft','','.',' ','','',1,1,'HUF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(65,'Icelandic króna','kr','','.',' ','','',1,1,'ISK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(66,'_tr_Indian rupee','₹','','.',' ','','',100,1,'INR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(67,'_tr_Indonesian rupiah','Rp','','.',' ','','',1,1,'IDR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(68,'_tr_Special drawing rights','SDR','','.',' ','','',100,1,'XDR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(69,'_tr_Iranian rial','','','.',' ','','',1,1,'IRR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(70,'_tr_Iraqi dinar','','','.',' ','','',1,1,'IQD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(71,'_tr_Israeli new shekel','₪','','.',' ','','',100,1,'ILS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(72,'_tr_Jamaican dollar','J$','','.',' ','','',100,1,'JMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(73,'_tr_Japanese yen','¥','','.',' ','','',1,1,'JPY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(74,'_tr_Jordanian dinar','','','.',' ','','',100,1,'JOD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(75,'_tr_Kazakhstani tenge','T','','.',' ','','',100,1,'KZT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(76,'_tr_Kenyan shilling','KSh','','.',' ','','',100,1,'KES','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(77,'_tr_North Korean won','W','','.',' ','','',100,1,'KPW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(78,'_tr_South Korean won','W','','.',' ','','',1,1,'KRW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(79,'_tr_Kuwaiti dinar','','','.',' ','','',100,1,'KWD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(80,'_tr_Kyrgystani som','','','.',' ','','',100,1,'KGS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(81,'_tr_Laotian kip','KN','','.',' ','','',100,1,'LAK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(82,'_tr_Latvian lats','Ls','','.',' ','','',100,1,'LVL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(83,'_tr_Lebanese pound','','','.',' ','','',1,1,'LBP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(84,'_tr_Lesotho loti','M','','.',' ','','',100,1,'LSL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(85,'_tr_Liberian dollar','L$','','.',' ','','',100,1,'LRD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(86,'_tr_Libyan dinar','LD','','.',' ','','',100,1,'LYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(87,'_tr_Lithuanian litas','Lt','','.',' ','','',100,1,'LTL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(88,'_tr_Macanese pataca','P','','.',' ','','',100,1,'MOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(89,'_tr_Macedonian denar','','','.',' ','','',100,1,'MKD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(90,'_tr_Malagasy ariary','FMG','','.',' ','','',100,1,'MGA','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(91,'_tr_Malawian kwacha','MK','','.',' ','','',1,1,'MWK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(92,'_tr_Malaysian ringgit','RM','','.',' ','','',100,1,'MYR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(93,'_tr_Maldivian rufiyaa','Rf','','.',' ','','',100,1,'MVR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(94,'_tr_Mauritanian ouguiya (1973-2017)','UM','','.',' ','','',100,1,'MRO','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(95,'_tr_Mauritian rupee','Rs','','.',' ','','',1,1,'MUR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(96,'_tr_Mexican peso','$','','.',' ','','',100,1,'MXN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(97,'_tr_Moldovan leu','','','.',' ','','',100,1,'MDL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(98,'_tr_Mongolian tugrik','₮','','.',' ','','',100,1,'MNT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(99,'_tr_Moroccan dirham','','','.',' ','','',100,1,'MAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(100,'_tr_Myanmar kyat','K','','.',' ','','',1,1,'MMK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(101,'_tr_Namibian dollar','N$','','.',' ','','',100,1,'NAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(102,'_tr_Nepalese rupee','NRs','','.',' ','','',100,1,'NPR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(103,'_tr_Netherlands Antillean guilder','NAƒ','','.',' ','','',100,1,'ANG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(104,'_tr_New Zealand dollar','NZ$','','.',' ','','',100,1,'NZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(105,'Nicaraguan córdoba','C$','','.',' ','','',100,1,'NIO','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(106,'_tr_Nigerian naira','₦','','.',' ','','',100,1,'NGN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(107,'_tr_Norwegian krone','kr','','.',' ','','',100,1,'NOK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(108,'_tr_Omani rial','','','.',' ','','',100,1,'OMR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(109,'_tr_Pakistani rupee','Rs.','','.',' ','','',1,1,'PKR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(110,'_tr_Panamanian balboa','B./','','.',' ','','',100,1,'PAB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(111,'_tr_Papua New Guinean kina','K','','.',' ','','',100,1,'PGK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(112,'_tr_Paraguayan guarani','','','.',' ','','',1,1,'PYG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(113,'_tr_Peruvian sol','S/.','','.',' ','','',100,1,'PEN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(114,'_tr_Philippine peso','₱','','.',' ','','',100,1,'PHP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(115,'_tr_Polish zloty','','zł',',','.','złoty','grosz',100,1,'PLN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(116,'_tr_Qatari riyal','QR','','.',' ','','',100,1,'QAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(117,'_tr_Romanian leu','L','','.',' ','','',100,1,'RON','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(118,'_tr_Rwandan franc','RF','','.',' ','','',1,1,'RWF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(119,'São Tomé & Príncipe dobra (1977-2017)','Db','','.',' ','','',100,1,'STD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(120,'_tr_Saudi riyal','SR','','.',' ','','',100,1,'SAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(121,'_tr_Serbian dinar','din.','','.',' ','','',1,1,'RSD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(122,'_tr_Seychellois rupee','SR','','.',' ','','',100,1,'SCR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(123,'_tr_Sierra Leonean leone (1964-2022)','Le','','.',' ','','',100,1,'SLL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(124,'_tr_Singapore dollar','S$','','.',' ','','',100,1,'SGD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(125,'_tr_Solomon Islands dollar','SI$','','.',' ','','',100,1,'SBD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(126,'_tr_Somali shilling','Sh.','','.',' ','','',1,1,'SOS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(127,'_tr_South African rand','R','','.',' ','','',100,1,'ZAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(128,'_tr_Sri Lankan rupee','Rs','','.',' ','','',100,1,'LKR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(129,'_tr_St. Helena pound','£','','.',' ','','',100,1,'SHP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(130,'_tr_Sudanese pound','','','.',' ','','',100,1,'SDG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(131,'_tr_Surinamese dollar','$','','.',' ','','',100,1,'SRD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(132,'_tr_Swazi lilangeni','E','','.',' ','','',100,1,'SZL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(133,'_tr_Swedish krona','kr','','.',' ','','',100,1,'SEK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(134,'_tr_Swiss franc','Fr.','','.',' ','','',100,1,'CHF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(135,'_tr_Syrian pound','','','.',' ','','',1,1,'SYP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(136,'_tr_New Taiwan dollar','NT$','','.',' ','','',100,1,'TWD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(137,'_tr_Tajikistani somoni','','','.',' ','','',100,1,'TJS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(138,'_tr_Tanzanian shilling','','','.',' ','','',1,1,'TZS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(139,'_tr_Thai baht','฿','','.',' ','','',100,1,'THB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(140,'_tr_Trinidad & Tobago dollar','TT$','','.',' ','','',100,1,'TTD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(141,'_tr_Tunisian dinar','DT','','.',' ','','',100,1,'TND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(142,'_tr_Turkish lira','₺','','.',' ','','',100,1,'TRY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(143,'_tr_Turkmenistani manat','m','','.',' ','','',100,1,'TMT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(144,'_tr_Ugandan shilling','USh','','.',' ','','',1,1,'UGX','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(145,'_tr_UAE dirham','','','.',' ','','',100,1,'AED','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(146,'_tr_Uruguayan peso','$U','','.',' ','','',100,1,'UYU','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(147,'_tr_Uzbekistani som','','','.',' ','','',1,1,'UZS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(148,'_tr_Vanuatu vatu','VT','','.',' ','','',100,1,'VUV','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(149,'_tr_Vietnamese dong','₫','','.',' ','','',1,1,'VND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(150,'_tr_Samoan tala','WS$','','.',' ','','',100,1,'WST','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(151,'_tr_Yemeni rial','','','.',' ','','',1,1,'YER','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(152,'Venezuelan bolívar (2008-2018)','Bs.','','.',',','bolívar','céntimos',100,1,'VEF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(153,'_tr_Bitcoin','Ƀ','','.',',','','',100000000,1,'BTC','Crypto');
INSERT INTO CURRENCYFORMATS_V1 VALUES(154,'_tr_Belarusian ruble','BYN','','.',',','','',100,1,'BYN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(155,'_tr_Cuban convertible peso','$','','.',',','','',100,1,'CUC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(156,'_tr_Cuban peso','$','','.',',','','',100,1,'CUP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(157,'_tr_Mauritanian ouguiya','MRU','','.',',','','',100,1,'MRU','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(158,'_tr_Mozambican metical','MZN','','.',',','','',100,1,'MZN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(159,'_tr_Sierra Leonean leone','SLE','','.',',','','',100,1,'SLE','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(160,'_tr_South Sudanese pound','£','','.',',','','',100,1,'SSP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(161,'São Tomé & Príncipe dobra','Db','','.',',','','',100,1,'STN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(162,'Salvadoran colón','SVC','','.',',','','',100,1,'SVC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(163,'Tongan paʻanga','T$','','.',',','','',100,1,'TOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(164,'_tr_Uruguayan nominal wage index unit','UYW','','.',',','','',10000,1,'UYW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(165,'Bolívar soberano','VED','','.',',','','',100,1,'VED','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(166,'Venezuelan bolívar','VES','','.',',','','',100,1,'VES','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(167,'_tr_Zambian kwacha','ZK','','.',',','','',100,1,'ZMW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(168,'_tr_Zimbabwean dollar (2009)','ZWL','','.',',','','',100,1,'ZWL','Fiat');

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
, NUMBER TEXT
, WEBSITE TEXT
, NOTES TEXT
, ACTIVE integer
, PATTERN TEXT DEFAULT ''
);
CREATE INDEX IDX_PAYEE_INFONAME ON PAYEE_V1(PAYEENAME);

-- Describe SPLITTRANSACTIONS_V1
CREATE TABLE SPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SPLITTRANSAMOUNT numeric
, NOTES TEXT
);
CREATE INDEX IDX_SPLITTRANSACTIONS_TRANSID ON SPLITTRANSACTIONS_V1(TRANSID);

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
, ACTIVE integer
, SQLCONTENT TEXT
, LUACONTENT TEXT
, TEMPLATECONTENT TEXT
, DESCRIPTION TEXT
);
CREATE INDEX INDEX_REPORT_NAME ON REPORT_V1(REPORTNAME);

-- Describe ATTACHMENT_V1
CREATE TABLE ATTACHMENT_V1 (
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, Bank Account, Repeating Transaction, Payee */
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

-- Describe CUSTOMFIELD_V1
CREATE TABLE CUSTOMFIELD_V1 (
FIELDID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, Bank Account, Repeating Transaction, Payee */
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
