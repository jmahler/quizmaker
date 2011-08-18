
DBNAME=quizmaker

# http://www.postgresql.org/docs/8.1/static/backup.html

# To restore ...
#
# sudo /etc/init.d/postgresql restart   (to force disconnection)
# dropdb <dbname>
# createdb <dbname>
# gunzip -c dump.sql.gz | psql <dbname>
#

dump:
	pg_dump $(DBNAME) | gzip > `date +%Y%m%d.%H:%M`-$(DBNAME)-dump.sql.gz


install:
	dropdb $(DBNAME)
	createdb $(DBNAME)
	psql -f QuizMaker.sql $(DBNAME)

