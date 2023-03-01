-- Payee Matching
-- https://github.com/moneymanagerex/moneymanagerex/issues/3148
ALTER TABLE PAYEE_V1 ADD COLUMN 'PATTERN' TEXT DEFAULT '';