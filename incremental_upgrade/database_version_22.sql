-- db tidy, fix corrupt indices
REINDEX;

-- =========================================================================
-- Financial Planner
-- Adds semi-monthly budget segments, auto/estimated budget amounts and a
-- multi-year long-term plan (grouped plan items, incl. share vesting income).
-- =========================================================================

-- Describe BUDGETSEGMENT_V1
-- Splits a budget period into intra-period segments (e.g. paycheck-aligned
-- halves: day 1-15 and day 16-end-of-month).
CREATE TABLE IF NOT EXISTS BUDGETSEGMENT_V1(
SEGMENTID integer primary key
, BUDGETYEARID integer NOT NULL
, SEGMENTNAME TEXT COLLATE NOCASE NOT NULL
, STARTDAY integer NOT NULL DEFAULT 1
, ENDDAY integer NOT NULL DEFAULT 31
, SORTORDER integer
, ACTIVE integer DEFAULT 1
, UNIQUE(BUDGETYEARID, SEGMENTNAME)
);
CREATE INDEX IF NOT EXISTS IDX_BUDGETSEGMENT_BUDGETYEARID ON BUDGETSEGMENT_V1(BUDGETYEARID);

-- Assign a budget entry to a segment (NULL = applies to the whole period)
-- and allow amounts to be estimated or derived automatically.
ALTER TABLE BUDGETTABLE_V1 ADD COLUMN SEGMENTID integer;
ALTER TABLE BUDGETTABLE_V1 ADD COLUMN AMOUNTTYPE TEXT;
ALTER TABLE BUDGETTABLE_V1 ADD COLUMN AUTOSOURCE TEXT;
ALTER TABLE BUDGETTABLE_V1 ADD COLUMN ROLLOVER TEXT;

UPDATE BUDGETTABLE_V1 SET AMOUNTTYPE = 'Fixed' WHERE AMOUNTTYPE IS NULL;
UPDATE BUDGETTABLE_V1 SET ROLLOVER = 'None' WHERE ROLLOVER IS NULL;

-- Describe PLANGROUP_V1
-- Hierarchical grouping of long-term plan items (e.g. a trip, a collection).
CREATE TABLE IF NOT EXISTS PLANGROUP_V1(
GROUPID integer primary key
, PARENTID integer
, GROUPNAME TEXT COLLATE NOCASE NOT NULL
, NOTES TEXT
, STATUS TEXT /* Planned, Committed, Wishlist, Done, Cancelled */
, TARGETDATE TEXT
, SORTORDER integer
, ACTIVE integer DEFAULT 1
);
CREATE INDEX IF NOT EXISTS IDX_PLANGROUP_PARENTID ON PLANGROUP_V1(PARENTID);

-- Describe PLANASSUMPTIONGROUP_V1
-- A set of alternative values for the same question -- "what is MSFT worth?"
-- might hold a conservative, a base and an optimistic figure. The group is
-- typed (KIND) and scoped (SCOPEKEY, e.g. a ticker), so only assumptions that
-- genuinely answer that question can belong to it, and it names which member is
-- ACTIVE. Plan items reference the group rather than an individual value, so
-- switching the active member in one place moves every dependent figure.
CREATE TABLE IF NOT EXISTS PLANASSUMPTIONGROUP_V1(
GROUPID integer primary key
, GROUPNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, KIND TEXT NOT NULL /* SharePrice, TaxRate, Inflation, ExchangeRate, Generic */
, SCOPEKEY TEXT /* e.g. a stock symbol for SharePrice */
, UNIT TEXT /* how to read member values: a currency symbol, '%', or free text */
, ACTIVEASSUMPTIONID integer
, NOTES TEXT
, ACTIVE integer DEFAULT 1
);
CREATE INDEX IF NOT EXISTS IDX_PLANASSUMPTIONGROUP_KIND ON PLANASSUMPTIONGROUP_V1(KIND);
CREATE INDEX IF NOT EXISTS IDX_PLANASSUMPTIONGROUP_SCOPEKEY ON PLANASSUMPTIONGROUP_V1(SCOPEKEY);

-- Describe PLANASSUMPTION_V1
-- Named, shared inputs that the plan is calculated FROM (e.g. an assumed share
-- price, a tax rate, an inflation rate). Storing them once means a change is
-- made in a single place and every dependent figure recomputes.
CREATE TABLE IF NOT EXISTS PLANASSUMPTION_V1(
ASSUMPTIONID integer primary key
, ASSUMPTIONNAME TEXT COLLATE NOCASE NOT NULL UNIQUE
, KIND TEXT NOT NULL /* SharePrice, TaxRate, Inflation, ExchangeRate, Generic */
, VALUE numeric NOT NULL
, SCOPEKEY TEXT /* e.g. a stock symbol for SharePrice */
, NOTES TEXT
, ASOFDATE TEXT
, ACTIVE integer DEFAULT 1
, UNIT TEXT /* how to read VALUE: a currency symbol, '%', or a free unit */
, GROUPID integer /* member of an assumption group, NULL when standalone */
);
CREATE INDEX IF NOT EXISTS IDX_PLANASSUMPTION_KIND ON PLANASSUMPTION_V1(KIND);
CREATE INDEX IF NOT EXISTS IDX_PLANASSUMPTION_GROUPID ON PLANASSUMPTION_V1(GROUPID);

-- Describe PLANITEM_V1
-- A single planned income or expense. When UNITS is set the amount is derived
-- as UNITS * UNITPRICE, with TAXRATE giving the net (after-tax) value, which
-- models share/RSU vesting.
CREATE TABLE IF NOT EXISTS PLANITEM_V1(
PLANITEMID integer primary key
, GROUPID integer
, ITEMNAME TEXT COLLATE NOCASE NOT NULL
, NOTES TEXT
, KIND TEXT NOT NULL /* Expense, Income */
, STATUS TEXT /* Planned, Committed, Wishlist, Done, Cancelled */
, TARGETDATE TEXT
, AMOUNT numeric
, CURRENCYID integer
, CATEGID integer
, ACCOUNTID integer
, UNITS numeric
, UNITPRICE numeric
, TAXRATE numeric
, STOCKSYMBOL TEXT
, CONFIDENCE numeric
, SORTORDER integer
, ACTIVE integer DEFAULT 1
, PRICEASSUMPTIONID integer /* pinned member: overrides the group's active one */
, TAXASSUMPTIONID integer /* pinned member: overrides the group's active one */
, PRICEASSUMPTIONGROUPID integer /* follows whichever member the group has active */
, TAXASSUMPTIONGROUPID integer /* follows whichever member the group has active */
);
CREATE INDEX IF NOT EXISTS IDX_PLANITEM_GROUPID ON PLANITEM_V1(GROUPID);
CREATE INDEX IF NOT EXISTS IDX_PLANITEM_TARGETDATE ON PLANITEM_V1(TARGETDATE);
