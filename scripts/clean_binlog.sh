#! /bin/sh

TARGET_TIME_STRING=`date "+%Y-%m-%d %H:%I:%S" --date="-3 hour"`
TMP_FILE=`mktemp`
MYSQL_USER=supervisor
MYSQL_USER_PASSWD=STW2AAfTKXiBctM8
MYSQL=/usr/bin/mysql

echo "purge binary logs before '${TARGET_TIME_STRING}';" >>${TMP_FILE}
echo "quit" >>${TMP_FILE}

${MYSQL} -h127.0.0.1 -u${MYSQL_USER} -p${MYSQL_USER_PASSWD} <${TMP_FILE} || exit 1
rm -f ${TMP_FILE} || exit 1

exit 0
