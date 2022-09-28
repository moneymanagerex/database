
-- Will fail if v8-14 by recreating a column that exists in those versions
-- so only upgrade from v1-v7 possible. Need to downgrade other versions prior to upgrade 
alter table CURRENCYFORMATS_V1 add column CURRENCY_TYPE TEXT;
update CURRENCYFORMATS_V1 set CURRENCY_TYPE = 'Fiat';
update CURRENCYFORMATS_V1 set CURRENCY_TYPE = 'Crypto' where CURRENCY_SYMBOL = 'BTC';

-- Setup date of account initial balance
-- https://github.com/moneymanagerex/moneymanagerex/issues/3554
alter table ACCOUNTLIST_V1 add column INITIALDATE text;
update ACCOUNTLIST_V1 SET INITIALDATE = ( select TRANSDATE from CHECKINGACCOUNT_V1 where 
    (ACCOUNTLIST_V1.ACCOUNTID = CHECKINGACCOUNT_V1.ACCOUNTID OR
    ACCOUNTLIST_V1.ACCOUNTID = CHECKINGACCOUNT_V1.TOACCOUNTID )
    order by TRANSDATE asc limit 1 );
update ACCOUNTLIST_V1 SET INITIALDATE = (select PURCHASEDATE from STOCK_V1 where
    (ACCOUNTLIST_V1.ACCOUNTID = STOCK_V1.HELDAT)
    order by PURCHASEDATE asc limit 1 )  where INITIALDATE is null;
update ACCOUNTLIST_V1 set INITIALDATE = date() where INITIALDATE is null;

alter table ASSETS_V1 add column ASSETSTATUS TEXT;
alter table ASSETS_V1 add column CURRENCYID integer;
alter table ASSETS_V1 add column VALUECHANGEMODE TEXT;
update ASSETS_V1 set ASSETSTATUS = 'Open', CURRENCYID = -1, VALUECHANGEMODE = 'Percentage';

alter table BUDGETSPLITTRANSACTIONS_V1 add column NOTES TEXT;
alter table SPLITTRANSACTIONS_V1 add column NOTES TEXT;

alter table BUDGETTABLE_V1 add column NOTES TEXT;
alter table BUDGETTABLE_V1 add column ACTIVE integer;
update BUDGETTABLE_V1 set ACTIVE = 1;

alter table CATEGORY_V1 add column ACTIVE integer;
alter table SUBCATEGORY_V1 add column ACTIVE integer;
update CATEGORY_V1 set ACTIVE = 1;
update SUBCATEGORY_V1 set ACTIVE = 1;

alter table PAYEE_V1 add column NUMBER TEXT;
alter table PAYEE_V1 add column WEBSITE TEXT;
alter table PAYEE_V1 add column NOTES TEXT;
alter table PAYEE_V1 add column ACTIVE integer;
update PAYEE_V1 set ACTIVE = 1;

alter table REPORT_V1 add column ACTIVE integer;
update REPORT_V1 set ACTIVE = 1;

-- Tidy-up: This table was in the schema but has been removed and should not exist
drop table if exists SPLITTRANSACTIONS_V2;

