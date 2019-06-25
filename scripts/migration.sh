set -e

# Migrate from the data folder mapped to /airsonic-workdir/data/source to /airsonic-workdir/data/destionation
# First load all the .dsv files located in /pre_populate
alias hsqldb-sqltool="java -cp /airsonic-workdir/hsqldb-1.8.0.10.jar org.hsqldb.util.SqlTool"

for f in /airsonic-workdir/data/pre_populate/*.dsv; do hsqldb-sqltool --rcfile /airsonic-workdir/sqltool.rc --sql "\m $f" --autoCommit airsonic-destination; done

cd /airsonic-workdir/subsonic_migrate/data/source
hsqldb-sqltool --rcfile /airsonic-workdir/sqltool.rc  airsonic-source /airsonic-workdir/subsonic_migrate/export.sql

cd /airsonic-workdir/subsonic_migrate/data/destination
hsqldb-sqltool --rcfile /airsonic-workdir/sqltool.rc  airsonic-destination /airsonic-workdir/subsonic_migrate/export.sql

## TODO: Change prefix if if needed

cd /airsonic-workdir/subsonic_migrate
./main.py

## TODO: Fix sql files if needed

hsqldb-sqltool --rcFile  /airsonic-workdir/sqltool.rc airsonic-destination delete_then_import.sql
