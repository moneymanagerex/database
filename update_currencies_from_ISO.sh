#!/usr/bin/env bash

FILE=tables_v1.sql

# get maximum CURRENCYID - entries in file must be sorted!
read -r -d '' max_id <"$FILE"
if [[ ! "$max_id" =~ .*INSERT\ INTO\ CURRENCYFORMATS_V1\ VALUES\(([0-9]+), ]]; then
  exit 1
fi
max_id=${BASH_REMATCH[1]}

read_xml() { local IFS=\> ; read -r -d \< E C ;}

declare -A cur_nam cur_dig cur_his

# List of codes for historic denominations of currencies & funds
URL=https://www.currency-iso.org/dam/downloads/lists/list_three.xml

while read_xml; do
  C="${C////\\/}"
  C="${C//\"/}"
  C="${C//\'/}"
  case $E in
    HstrcCcyNtry | /HstrcCcyTbl ) unset sym nam ;;
    CcyNm ) nam="$C" ;;
    Ccy ) sym="$C" ;;
    WthdrwlDt ) dat="$C" ;;
    /HstrcCcyNtry )
      if [[ "$nam" && "$sym" && "$dat" ]]; then
        if [[ $dat =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
          nam+=" (before $dat)"
        else
          nam+=" ($dat)"
        fi
        cur_nam[$sym]="$nam"
        cur_his[$sym]=1
      fi ;;
  esac
done < <( wget -qO - $URL )

# Current currency & funds code list
URL=https://www.currency-iso.org/dam/downloads/lists/list_one.xml

while read_xml; do
  C="${C////\\/}"
  C="${C//\"/}"
  C="${C//\'/}"
  case $E in
    CcyNtry | /CcyTbl ) unset sym nam dig ;;
    CcyNm ) nam="$C" ;;
    Ccy ) sym="$C" ;;
    CcyMnrUnts ) dig="$C" ;;
    /CcyNtry )
      if [[ "$nam" && "$sym" && "$dig" && "$dig" != N.A. ]]; then
        cur_dig[$sym]="$dig"
        cur_nam[$sym]="$nam"
        cur_his[$sym]=0
      fi ;;
  esac
done < <( wget -qO - $URL )

# update
for cur in "${!cur_nam[@]}"; do
  if [[ ${cur_his[$cur]} == 1 ]]; then
    sed -i -E "/,1,'$cur','Traditional',[01]\);$/{s/( VALUES\([0-9]+,)'[^']+',(.*,[0-9]+(,[^,]+){3}),[01]\)/\1'_tr_${cur_nam[$cur]}',\2,1)/;h}; \${x;/./{x;q0};x;q1}" "$FILE" \
      && unset cur_nam[$cur] cur_his[$cur]
  else
    sed -i -E "/,1,'$cur','Traditional',[01]\);$/{s/( VALUES\([0-9]+,)'[^']+',(.*),[0-9]+((,[^,]+){3}),[01]\)/\1'_tr_${cur_nam[$cur]}',\2,$((10**${cur_dig[$cur]}))\3,0)/;h}; \${x;/./{x;q0};x;q1}" "$FILE" \
      && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur]
  fi
done

# sort by symbol
IFS=$'\n' sorted=($(sort <<<"${!cur_nam[*]}"))
# add missing
for cur in ${sorted[*]}; do
  if [[ ${cur_his[$cur]} == 1 ]]; then
    sed -i "/INSERT INTO CURRENCYFORMATS_V1 VALUES($max_id,/a INSERT INTO CURRENCYFORMATS_V1 VALUES($((++max_id)),'_tr_${cur_nam[$cur]}','','','.',',',100,1,'$cur','Traditional',1);" "$FILE" \
      && unset cur_nam[$cur] cur_his[$cur]
  else
    sed -i "/INSERT INTO CURRENCYFORMATS_V1 VALUES($max_id,/a INSERT INTO CURRENCYFORMATS_V1 VALUES($((++max_id)),'_tr_${cur_nam[$cur]}','','','.',',',$((10**${cur_dig[$cur]})),1,'$cur','Traditional',0);" "$FILE" \
      && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur]
  fi
done
