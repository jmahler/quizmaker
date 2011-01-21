
#
# This Makefile is used to dump the current database.
# The instructions below also describe how to load a dump.
#
# An initial database must be created using one of the dumps
# in this directory.
#
#   shell$ gunzip -c dump.sql.gz | psql quizmaker
#
# If you want get rid of your current data and load one of
# the dumps you must clear out the database first.
#
#   shell$ dropdb quizmaker
#   shell$ createdb quizmaker
#     (now it is clear)
#
# In some cases it may be necessary to restart the database to
# force clients to disconnect.
#
#    shell$ sudo /etc/init.d/postgresql restart   (to force disconnection)
#

# If your database is named something else,
# rename $(DBNAME).
DBNAME=quizmaker


DATE=`date +%Y%m%d.%H:%M`

all: dump-schema dump

# schema and data
dump:
	pg_dump --no-owner $(DBNAME) | gzip > $(DATE)-$(DBNAME)-dump.sql.gz
	-rm -f current.sql.gz
	ln -s $(DATE)-$(DBNAME)-dump.sql.gz current.sql.gz

# schema only
dump-schema:
	pg_dump --schema-only --no-owner $(DBNAME) | gzip > $(DATE)-$(DBNAME)-dump-schema.sql.gz
	-rm -f current-schema.sql.gz
	ln -s $(DATE)-$(DBNAME)-dump-schema.sql.gz current-schema.sql.gz

load:
	gunzip -c current.sql.gz | psql $(DBNAME)

