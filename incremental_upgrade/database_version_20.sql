-- db tidy, fix corrupt indices
REINDEX;

-- nothing to do, just incrementing version to cater of SUID index size changes to int64,
-- see: https://github.com/moneymanagerex/moneymanagerex/issues/7136
