#!/usr/bin/env bash

FILE=tables.sql

# get maximum CURRENCYID - entries in file must be sorted!
read -r -d '' max_id <"$FILE"
if [[ ! "$max_id" =~ .*INSERT\ INTO\ CURRENCYFORMATS_V1\ VALUES\(([0-9]+), ]]; then
  exit 1
fi
max_id=${BASH_REMATCH[1]}

read_xml() { local IFS=\> ; read -r -d \< E C ;}

declare -A cur_nam cur_dig cur_his cur_cty cur_sym

# List of codes for historic denominations of currencies & funds
URL=https://www.six-group.com/dam/download/financial-information/data-center/iso-currrency/lists/list-three.xml

while read_xml; do
  C="${C////\\/}"
  C="${C//\"/}"
  C="${C//\'/}"
  case $E in
    HstrcCcyNtry | /HstrcCcyTbl ) unset sym nam cty;;
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
URL=https://www.six-group.com/dam/download/financial-information/data-center/iso-currrency/lists/list-one.xml

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

#update currency names using the Unicode CLDR
URL=https://raw.githubusercontent.com/unicode-org/cldr-json/main/cldr-json/cldr-numbers-modern/main/en/currencies.json
data=$(wget -qO - $URL | cat)

IFS=$'\n'
codes=($(grep -o '"[A-Z]\{3\}": {$' <<<$data| grep -o '[A-Z]\{3\}'))
names=($(grep -o '"displayName-count-one": "[^"]*' <<<$data | grep -o '[^"]*$' | sed -e "s/[^ ]*$/\l&/;s/.*/\u&/;s/–\|—/-/;s/’/'/"))
symbols=($(grep -oz '"symbol": "[^"]*"\(,[^"]*"symbol-alt-narrow": "[^"]*"\)\?' <<<$data | sed -zE 's/"symbol": "[^"]*",\n *//g;s/^.*: "([^"]*)"/\1/' | tr '\0' '\n'))

for index in ${!codes[@]}; do
  cur_nam[${codes[$index]}]=${names[$index]}
  cur_sym[${codes[$index]}]=${symbols[$index]}
done

# update
for cur in "${!cur_nam[@]}"; do
  if (LC_CTYPE=C; [[ ${cur_nam[$cur]} = *[![:cntrl:][:print:]]* ]]) then
    sed -i -E "/,'$cur','Fiat'\);$/{s/( VALUES\([0-9]+,)'[^']+',(.*,[0-9]+(,[^,]+){2})\)/\1'${cur_nam[$cur]//&/\\&}',\2)/;h}; \${x;/./{x;q0};x;q1}" "$FILE" \
      && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur] cur_sym[$cur]
  else
    sed -i -E "/,'$cur','Fiat'\);$/{s/( VALUES\([0-9]+,)'[^']+',(.*,[0-9]+(,[^,]+){2})\)/\1'_tr_${cur_nam[$cur]//&/\\&}',\2)/;h}; \${x;/./{x;q0};x;q1}" "$FILE" \
      && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur] cur_sym[$cur]
  fi
done

# sort by code
sorted=($(sort <<<"${!cur_nam[*]}"))
# add missing
for cur in ${sorted[*]}; do
  if [[ ${cur_his[$cur]} == 0 ]]; then
    if (LC_CTYPE=C; [[ ${cur_nam[$cur]} = *[![:cntrl:][:print:]]* ]]) then
      sed -i "/INSERT INTO CURRENCYFORMATS_V1 VALUES($max_id,/a INSERT INTO CURRENCYFORMATS_V1 VALUES($((++max_id)),'${cur_nam[$cur]//&/\\&}','${cur_sym[$cur]}','','.',',','','',$((10**${cur_dig[$cur]})),1,'$cur','Fiat');" "$FILE" \
        && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur] cur_sym[$cur]
    else
	  sed -i "/INSERT INTO CURRENCYFORMATS_V1 VALUES($max_id,/a INSERT INTO CURRENCYFORMATS_V1 VALUES($((++max_id)),'_tr_${cur_nam[$cur]//&/\\&}','${cur_sym[$cur]}','','.',',','','',$((10**${cur_dig[$cur]})),1,'$cur','Fiat');" "$FILE" \
        && unset cur_nam[$cur] cur_dig[$cur] cur_his[$cur] cur_sym[$cur]
	fi
  fi
done