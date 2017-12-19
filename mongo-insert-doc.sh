#!/bin/bash
HELP=0
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -h|--help)
        HELP=1
        ;;
        -d|--database)
        shift
        DATABASE="$1"
        ;;
        -c|--collection)
        shift
        COLLECTION="$1"
        ;;
        -i|--item)
        shift
        ITEM="$1"
        ;;
        *)
        # Do whatever you want with extra options
        echo "Unknown option '$key'"
        ;;
    esac
    # Shift after checking all the cases to get the next option
    shift
done

if [ -z "${COLLECTION}" ] || [ -z "${DATABASE}" ] || [ ! -f "${ITEM}" ] || [ $HELP -eq 1 ]
#if [ $# -ne $EXPECTED_ARGS ]
then
  echo "usage: $0 [-d|--database <db>] [-c|--collection <collection>] [-i|--item <json file path>]"
  echo "-d|--database <db> name of database e.g. staticcms_labs"
  echo "-c|--collection <collection> name of collection e.g. apps"
  echo "-i|--item <json file path> path to document json file to insert e.g. ../newapp.json"
  exit 1
fi

content=`cat ${ITEM}`
mongo ${DATABASE} --eval "db.getCollection(\"${COLLECTION}\").insert(${content})"
