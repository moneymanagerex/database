-- db tidy, fix corrupt indices
REINDEX;

alter table CHECKINGACCOUNT_V1 add column LASTUPDATEDTIME text;
alter table CHECKINGACCOUNT_V1 add column DELETEDTIME text;
