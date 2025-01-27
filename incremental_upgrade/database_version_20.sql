-- db tidy, fix corrupt indices
REINDEX;

-- To alleviate future issues we are normalizing the TRANSDATE column
UPDATE CHECKINGACCOUNT_V1 SET TRANSDATE = TRANSDATE || 'T00:00:00' WHERE LENGTH(TRANSDATE)=10;