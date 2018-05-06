-- workaround for missing tables from v11 schema

CREATE TABLE IF NOT EXISTS ACCOUNTLIST_V1(
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

CREATE TABLE IF NOT EXISTS ASSETS_V1(
ASSETID integer primary key
, STARTDATE TEXT NOT NULL
, ASSETNAME TEXT COLLATE NOCASE NOT NULL
, VALUE numeric
, VALUECHANGE TEXT /* None, Appreciates, Depreciates */
, NOTES TEXT
, VALUECHANGERATE numeric
, ASSETTYPE TEXT /* Property, Automobile, Household Object, Art, Jewellery, Cash, Other */
);

CREATE TABLE IF NOT EXISTS BILLSDEPOSITS_V1(
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

CREATE TABLE IF NOT EXISTS BUDGETSPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);

CREATE TABLE IF NOT EXISTS BUDGETTABLE_V1(
BUDGETENTRYID integer primary key
, BUDGETYEARID integer
, CATEGID integer
, SUBCATEGID integer
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily*/
, AMOUNT numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS BUDGETYEAR_V1(
BUDGETYEARID integer primary key
, BUDGETYEARNAME TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CATEGORY_V1(
CATEGID integer primary key
, CATEGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CHECKINGACCOUNT_V1(
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

CREATE TABLE IF NOT EXISTS CURRENCYHISTORY_V1(
CURRHISTID INTEGER PRIMARY KEY
, CURRENCYID INTEGER NOT NULL
, CURRDATE TEXT NOT NULL
, CURRVALUE NUMERIC NOT NULL
, CURRUPDTYPE INTEGER
, UNIQUE(CURRENCYID, CURRDATE)
);

CREATE TABLE IF NOT EXISTS CURRENCYFORMATS_V1(
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

CREATE TABLE IF NOT EXISTS INFOTABLE_V1(
INFOID integer not null primary key
, INFONAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, INFOVALUE TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PAYEE_V1(
PAYEEID integer primary key
, PAYEENAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, CATEGID integer
, SUBCATEGID integer
);

CREATE TABLE IF NOT EXISTS SPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);

CREATE TABLE IF NOT EXISTS STOCK_V1(
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

CREATE TABLE IF NOT EXISTS STOCKHISTORY_V1(
HISTID integer primary key
, SYMBOL TEXT NOT NULL
, DATE TEXT NOT NULL
, VALUE numeric NOT NULL
, UPDTYPE integer
, UNIQUE(SYMBOL, DATE)
);

CREATE TABLE IF NOT EXISTS SUBCATEGORY_V1(
SUBCATEGID integer primary key
, SUBCATEGNAME TEXT COLLATE NOCASE NOT NULL
, CATEGID integer NOT NULL
, UNIQUE(CATEGID, SUBCATEGNAME)
);

create table IF NOT EXISTS REPORT_V1(
REPORTID integer not null primary key
, REPORTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, GROUPNAME TEXT COLLATE NOCASE
, SQLCONTENT TEXT
, LUACONTENT TEXT
, TEMPLATECONTENT TEXT
, DESCRIPTION TEXT
);

CREATE TABLE IF NOT EXISTS ATTACHMENT_V1 (
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, REFID INTEGER NOT NULL
, DESCRIPTION TEXT COLLATE NOCASE
, FILENAME TEXT NOT NULL COLLATE NOCASE
);

CREATE TABLE IF NOT EXISTS ASSETCLASS_V1 (
ID INTEGER primary key
, PARENTID INTEGER
, NAME TEXT COLLATE NOCASE NOT NULL
, ALLOCATION REAL
, SORTORDER INTEGER
);

CREATE TABLE IF NOT EXISTS ASSETCLASS_STOCK_V1 (
ID INTEGER primary key
, ASSETCLASSID INTEGER NOT NULL
, STOCKSYMBOL TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS CUSTOMFIELD_V1 (
FIELDID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, DESCRIPTION TEXT COLLATE NOCASE
, TYPE TEXT NOT NULL /* String, Integer, Decimal, Boolean, Date, Time, SingleChoice, MultiChoice */
, PROPERTIES TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS CUSTOMFIELDDATA_V1 (
FIELDATADID INTEGER NOT NULL PRIMARY KEY
, FIELDID INTEGER NOT NULL
, REFID INTEGER NOT NULL
, CONTENT TEXT
, UNIQUE(FIELDID, REFID)
);

CREATE TABLE IF NOT EXISTS TRANSLINK_V1 (
TRANSLINKID  integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, LINKTYPE TEXT NOT NULL /* Asset, Stock */
, LINKRECORDID integer NOT NULL
);

CREATE TABLE IF NOT EXISTS SHAREINFO_V1 (
SHAREINFOID integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, SHARENUMBER numeric
, SHAREPRICE numeric
, SHARECOMMISSION numeric
, SHARELOT TEXT
);

-- unused

DROP TABLE IF EXISTS SPLITTRANSACTIONS_V2;
DROP VIEW IF EXISTS alldata;

-- recreate renamed tables with the same structure
-- then copy existing data to validate with db schema

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
INSERT INTO ACCOUNTLIST SELECT
ACCOUNTID
, ACCOUNTNAME
, ACCOUNTTYPE
, ACCOUNTNUM
, STATUS
, NOTES
, HELDAT
, WEBSITE
, CONTACTINFO
, ACCESSINFO
, INITIALBAL
, FAVORITEACCT
, CURRENCYID
, STATEMENTLOCKED
, STATEMENTDATE
, MINIMUMBALANCE
, CREDITLIMIT
, INTERESTRATE
, PAYMENTDUEDATE
, MINIMUMPAYMENT
FROM ACCOUNTLIST_V1;
DROP INDEX IF EXISTS IDX_ACCOUNTLIST_ACCOUNTTYPE;
DROP TABLE ACCOUNTLIST_V1;
CREATE INDEX IDX_ACCOUNTLIST_ACCOUNTTYPE ON ACCOUNTLIST(ACCOUNTTYPE);

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
INSERT INTO ASSETS SELECT
ASSETID
, STARTDATE
, ASSETNAME
, VALUE
, VALUECHANGE
, NOTES
, VALUECHANGERATE
, ASSETTYPE
FROM ASSETS_V1;
DROP INDEX IF EXISTS IDX_ASSETS_ASSETTYPE;
DROP TABLE ASSETS_V1;
CREATE INDEX IDX_ASSETS_ASSETTYPE ON ASSETS(ASSETTYPE);

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
INSERT INTO BILLSDEPOSITS SELECT
BDID
, ACCOUNTID
, TOACCOUNTID
, PAYEEID
, TRANSCODE
, TRANSAMOUNT
, STATUS
, TRANSACTIONNUMBER
, NOTES
, CATEGID
, SUBCATEGID
, TRANSDATE
, FOLLOWUPID
, TOTRANSAMOUNT
, REPEATS
, NEXTOCCURRENCEDATE
, NUMOCCURRENCES
FROM BILLSDEPOSITS_V1;
DROP INDEX IF EXISTS IDX_BILLSDEPOSITS_ACCOUNT;
DROP TABLE BILLSDEPOSITS_V1;
CREATE INDEX IDX_BILLSDEPOSITS_ACCOUNT ON BILLSDEPOSITS (ACCOUNTID, TOACCOUNTID);

CREATE TABLE BUDGETSPLITTRANSACTIONS(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
INSERT INTO BUDGETSPLITTRANSACTIONS SELECT
SPLITTRANSID
, TRANSID
, CATEGID
, SUBCATEGID
, SPLITTRANSAMOUNT
FROM BUDGETSPLITTRANSACTIONS_V1;
DROP INDEX IF EXISTS IDX_BUDGETSPLITTRANSACTIONS_TRANSID;
DROP TABLE BUDGETSPLITTRANSACTIONS_V1;
CREATE INDEX IDX_BUDGETSPLITTRANSACTIONS_TRANSID ON BUDGETSPLITTRANSACTIONS(TRANSID);

CREATE TABLE BUDGETTABLE(
BUDGETENTRYID integer primary key
, BUDGETYEARID integer
, CATEGID integer
, SUBCATEGID integer
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily*/
, AMOUNT numeric NOT NULL
);
INSERT INTO BUDGETTABLE SELECT
BUDGETENTRYID
, BUDGETYEARID
, CATEGID
, SUBCATEGID
, PERIOD
, AMOUNT
FROM BUDGETTABLE_V1;
DROP INDEX IF EXISTS IDX_BUDGETTABLE_BUDGETYEARID;
DROP TABLE BUDGETTABLE_V1;
CREATE INDEX IDX_BUDGETTABLE_BUDGETYEARID ON BUDGETTABLE(BUDGETYEARID);

CREATE TABLE BUDGETYEAR(
BUDGETYEARID integer primary key
, BUDGETYEARNAME TEXT NOT NULL UNIQUE
);
INSERT INTO BUDGETYEAR SELECT
BUDGETYEARID
, BUDGETYEARNAME
FROM BUDGETYEAR_V1;
DROP INDEX IF EXISTS IDX_BUDGETYEAR_BUDGETYEARNAME;
DROP TABLE BUDGETYEAR_V1;
CREATE INDEX IDX_BUDGETYEAR_BUDGETYEARNAME ON BUDGETYEAR(BUDGETYEARNAME);

CREATE TABLE CATEGORY(
CATEGID integer primary key
, CATEGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
);
INSERT INTO CATEGORY SELECT
CATEGID
, CATEGNAME
FROM CATEGORY_V1;
DROP INDEX IF EXISTS IDX_CATEGORY_CATEGNAME;
DROP TABLE CATEGORY_V1;
CREATE INDEX IDX_CATEGORY_CATEGNAME ON CATEGORY(CATEGNAME);

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
INSERT INTO CHECKINGACCOUNT SELECT
TRANSID
, ACCOUNTID
, TOACCOUNTID
, PAYEEID
, TRANSCODE
, TRANSAMOUNT
, STATUS
, TRANSACTIONNUMBER
, NOTES
, CATEGID
, SUBCATEGID
, TRANSDATE
, FOLLOWUPID
, TOTRANSAMOUNT
FROM CHECKINGACCOUNT_V1;
DROP INDEX IF EXISTS IDX_CHECKINGACCOUNT_ACCOUNT;
DROP INDEX IF EXISTS IDX_CHECKINGACCOUNT_TRANSDATE;
DROP TABLE CHECKINGACCOUNT_V1;
CREATE INDEX IDX_CHECKINGACCOUNT_ACCOUNT ON CHECKINGACCOUNT (ACCOUNTID, TOACCOUNTID);
CREATE INDEX IDX_CHECKINGACCOUNT_TRANSDATE ON CHECKINGACCOUNT (TRANSDATE);

CREATE TABLE CURRENCYHISTORY(
CURRHISTID INTEGER PRIMARY KEY
, CURRENCYID INTEGER NOT NULL
, CURRDATE TEXT NOT NULL
, CURRVALUE NUMERIC NOT NULL
, CURRUPDTYPE INTEGER
, UNIQUE(CURRENCYID, CURRDATE)
);
INSERT INTO CURRENCYHISTORY SELECT
CURRHISTID
, CURRENCYID
, CURRDATE
, CURRVALUE
, CURRUPDTYPE
FROM CURRENCYHISTORY_V1;
DROP INDEX IF EXISTS IDX_CURRENCYHISTORY_CURRENCYID_CURRDATE;
DROP TABLE CURRENCYHISTORY_V1;
CREATE INDEX IDX_CURRENCYHISTORY_CURRENCYID_CURRDATE ON CURRENCYHISTORY(CURRENCYID, CURRDATE);

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
, CURRENCY_TYPE TEXT /* Fiat, Crypto */
, HISTORIC integer DEFAULT 0 /* 1 if no longer official */
);
INSERT INTO CURRENCYFORMATS SELECT
CURRENCYID
, CURRENCYNAME
, PFX_SYMBOL
, SFX_SYMBOL
, DECIMAL_POINT
, GROUP_SEPARATOR
, SCALE
, BASECONVRATE
, CURRENCY_SYMBOL
, CURRENCY_TYPE
, HISTORIC
FROM CURRENCYFORMATS_V1;
DROP INDEX IF EXISTS IDX_CURRENCYFORMATS_SYMBOL;
DROP TABLE CURRENCYFORMATS_V1;
CREATE INDEX IDX_CURRENCYFORMATS_SYMBOL ON CURRENCYFORMATS(CURRENCY_SYMBOL);

CREATE TABLE INFOTABLE(
INFOID integer not null primary key
, INFONAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, INFOVALUE TEXT NOT NULL
);
INSERT INTO INFOTABLE SELECT
INFOID
, INFONAME
, INFOVALUE
FROM INFOTABLE_V1;
DROP INDEX IF EXISTS IDX_INFOTABLE_INFONAME;
DROP TABLE INFOTABLE_V1;
CREATE INDEX IDX_INFOTABLE_INFONAME ON INFOTABLE(INFONAME);

CREATE TABLE PAYEE(
PAYEEID integer primary key
, PAYEENAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, CATEGID integer
, SUBCATEGID integer
);
INSERT INTO PAYEE SELECT
PAYEEID
, PAYEENAME
, CATEGID
, SUBCATEGID
FROM PAYEE_V1;
DROP INDEX IF EXISTS IDX_PAYEE_INFONAME;
DROP TABLE PAYEE_V1;
CREATE INDEX IDX_PAYEE_INFONAME ON PAYEE(PAYEENAME);

CREATE TABLE SPLITTRANSACTIONS(
SPLITTRANSID integer primary key
, TRANSID integer NOT NULL
, CATEGID integer
, SUBCATEGID integer
, SPLITTRANSAMOUNT numeric
);
INSERT INTO SPLITTRANSACTIONS SELECT
SPLITTRANSID
, TRANSID
, CATEGID
, SUBCATEGID
, SPLITTRANSAMOUNT
FROM SPLITTRANSACTIONS_V1;
DROP INDEX IF EXISTS IDX_SPLITTRANSACTIONS_TRANSID;
DROP TABLE SPLITTRANSACTIONS_V1;
CREATE INDEX IDX_SPLITTRANSACTIONS_TRANSID ON SPLITTRANSACTIONS(TRANSID);

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
INSERT INTO STOCK SELECT
STOCKID
, HELDAT
, PURCHASEDATE
, STOCKNAME
, SYMBOL
, NUMSHARES
, PURCHASEPRICE
, NOTES
, CURRENTPRICE
, VALUE
, COMMISSION
FROM STOCK_V1;
DROP INDEX IF EXISTS IDX_STOCK_HELDAT;
DROP TABLE STOCK_V1;
CREATE INDEX IDX_STOCK_HELDAT ON STOCK(HELDAT);

CREATE TABLE STOCKHISTORY(
HISTID integer primary key
, SYMBOL TEXT NOT NULL
, DATE TEXT NOT NULL
, VALUE numeric NOT NULL
, UPDTYPE integer
, UNIQUE(SYMBOL, DATE)
);
INSERT INTO STOCKHISTORY SELECT
HISTID
, SYMBOL
, DATE
, VALUE
, UPDTYPE
FROM STOCKHISTORY_V1;
DROP INDEX IF EXISTS IDX_STOCKHISTORY_SYMBOL;
DROP TABLE STOCKHISTORY_V1;
CREATE INDEX IDX_STOCKHISTORY_SYMBOL ON STOCKHISTORY(SYMBOL);

CREATE TABLE SUBCATEGORY(
SUBCATEGID integer primary key
, SUBCATEGNAME TEXT COLLATE NOCASE NOT NULL
, CATEGID integer NOT NULL
, UNIQUE(CATEGID, SUBCATEGNAME)
);
INSERT INTO SUBCATEGORY SELECT
SUBCATEGID
, SUBCATEGNAME
, CATEGID
FROM SUBCATEGORY_V1;
DROP INDEX IF EXISTS IDX_SUBCATEGORY_CATEGID;
DROP TABLE SUBCATEGORY_V1;
CREATE INDEX IDX_SUBCATEGORY_CATEGID ON SUBCATEGORY(CATEGID);

create table REPORT(
REPORTID integer not null primary key
, REPORTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, GROUPNAME TEXT COLLATE NOCASE
, SQLCONTENT TEXT
, LUACONTENT TEXT
, TEMPLATECONTENT TEXT
, DESCRIPTION TEXT
);
INSERT INTO REPORT SELECT
REPORTID
, REPORTNAME
, GROUPNAME
, SQLCONTENT
, LUACONTENT
, TEMPLATECONTENT
, DESCRIPTION
FROM REPORT_V1;
DROP INDEX IF EXISTS INDEX_REPORT_NAME;
DROP TABLE REPORT_V1;
CREATE INDEX INDEX_REPORT_NAME ON REPORT(REPORTNAME);

CREATE TABLE ATTACHMENT (
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, REFID INTEGER NOT NULL
, DESCRIPTION TEXT COLLATE NOCASE
, FILENAME TEXT NOT NULL COLLATE NOCASE
);
INSERT INTO ATTACHMENT SELECT
ATTACHMENTID
, REFTYPE
, REFID
, DESCRIPTION
, FILENAME
FROM ATTACHMENT_V1;
DROP INDEX IF EXISTS IDX_ATTACHMENT_REF;
DROP TABLE ATTACHMENT_V1;
CREATE INDEX IDX_ATTACHMENT_REF ON ATTACHMENT (REFTYPE, REFID);

CREATE TABLE ASSETCLASS (
ID INTEGER primary key
, PARENTID INTEGER
, NAME TEXT COLLATE NOCASE NOT NULL
, ALLOCATION REAL
, SORTORDER INTEGER
);
INSERT INTO ASSETCLASS SELECT
ID
, PARENTID
, NAME
, ALLOCATION
, SORTORDER
FROM ASSETCLASS_V1;
DROP TABLE ASSETCLASS_V1;

CREATE TABLE ASSETCLASS_STOCK (
ID INTEGER primary key
, ASSETCLASSID INTEGER NOT NULL
, STOCKSYMBOL TEXT UNIQUE
);
INSERT INTO ASSETCLASS_STOCK SELECT
ID
, ASSETCLASSID
, STOCKSYMBOL
FROM ASSETCLASS_STOCK_V1;
DROP TABLE ASSETCLASS_STOCK_V1;

CREATE TABLE CUSTOMFIELD (
FIELDID INTEGER NOT NULL PRIMARY KEY
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, BankAccount, RepeatingTransaction, Payee */
, DESCRIPTION TEXT COLLATE NOCASE
, TYPE TEXT NOT NULL /* String, Integer, Decimal, Boolean, Date, Time, SingleChoice, MultiChoice */
, PROPERTIES TEXT NOT NULL
);
INSERT INTO CUSTOMFIELD SELECT
FIELDID
, REFTYPE
, DESCRIPTION
, TYPE
, PROPERTIES
FROM CUSTOMFIELD_V1;
DROP INDEX IF EXISTS IDX_CUSTOMFIELD_REF;
DROP TABLE CUSTOMFIELD_V1;
CREATE INDEX IDX_CUSTOMFIELD_REF ON CUSTOMFIELD (REFTYPE);

CREATE TABLE CUSTOMFIELDDATA (
FIELDATADID INTEGER NOT NULL PRIMARY KEY
, FIELDID INTEGER NOT NULL
, REFID INTEGER NOT NULL
, CONTENT TEXT
, UNIQUE(FIELDID, REFID)
);
INSERT INTO CUSTOMFIELDDATA SELECT
FIELDATADID
, FIELDID
, REFID
, CONTENT
FROM CUSTOMFIELDDATA_V1;
DROP INDEX IF EXISTS IDX_CUSTOMFIELDDATA_REF;
DROP TABLE CUSTOMFIELDDATA_V1;
CREATE INDEX IDX_CUSTOMFIELDDATA_REF ON CUSTOMFIELDDATA (FIELDID, REFID);

CREATE TABLE TRANSLINK (
TRANSLINKID integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, LINKTYPE TEXT NOT NULL /* Asset, Stock */
, LINKRECORDID integer NOT NULL
);
INSERT INTO TRANSLINK SELECT
TRANSLINKID
, CHECKINGACCOUNTID
, LINKTYPE
, LINKRECORDID
FROM TRANSLINK_V1;
DROP INDEX IF EXISTS IDX_LINKRECORD;
DROP INDEX IF EXISTS IDX_CHECKINGACCOUNT;
DROP TABLE TRANSLINK_V1;
CREATE INDEX IDX_LINKRECORD ON TRANSLINK (LINKTYPE, LINKRECORDID);
CREATE INDEX IDX_CHECKINGACCOUNT ON TRANSLINK (CHECKINGACCOUNTID);

CREATE TABLE SHAREINFO (
SHAREINFOID integer NOT NULL primary key
, CHECKINGACCOUNTID integer NOT NULL
, SHARENUMBER numeric
, SHAREPRICE numeric
, SHARECOMMISSION numeric
, SHARELOT TEXT
);
INSERT INTO SHAREINFO SELECT
SHAREINFOID
, CHECKINGACCOUNTID
, SHARENUMBER
, SHAREPRICE
, SHARECOMMISSION
, SHARELOT
FROM SHAREINFO_V1;
DROP INDEX IF EXISTS IDX_SHAREINFO;
DROP TABLE SHAREINFO_V1;
CREATE INDEX IDX_SHAREINFO ON SHAREINFO (CHECKINGACCOUNTID);

-- rename table names used in GRM definitions

UPDATE REPORT SET SQLCONTENT = REPLACE(SQLCONTENT, '_V1', '' ) WHERE SQLCONTENT LIKE '%_V1%';
UPDATE REPORT SET LUACONTENT = REPLACE(LUACONTENT, '_V1', '' ) WHERE LUACONTENT LIKE '%_V1%';
UPDATE REPORT SET TEMPLATECONTENT = REPLACE(TEMPLATECONTENT, '_V1', '' ) WHERE TEMPLATECONTENT LIKE '%_V1%';

-- finish

PRAGMA user_version = 12;