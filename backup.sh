#!/bin/sh

file=data.sql

ssh monstars0@hunters.lisfactory.com mysqldump -u bbase -pdaisuke1 bbase --skip-opt --skip-dump-date --default-character-set=utf8 -t --ignore-table=bbase.flyway_schema_history > $file
diff=`git diff $file`

if [ -n "$diff" ]; then
	datetime=`date "+%Y%m%d %H%M%S"`
	message="update on $datetime"
	git add $file
	git commit -m "$message"
	git push origin master
	echo $message
else
	echo "no changes"
fi
