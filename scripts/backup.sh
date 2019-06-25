set -e

OUTPUT=/airsonic-workdir/backups/`date +%Y-%m-%d`_airsonic-db.tar

echo "Archive the database folder"
tar -cf $OUTPUT -C /airsonic-workdir/data/source db

echo "Export and archive selected database content"
alias hsqldb-sqltool="java -cp /airsonic-workdir/hsqldb-1.8.0.10.jar org.hsqldb.util.SqlTool"
mkdir /airsonic-workdir/data/export && cd /airsonic-workdir/data/export
hsqldb-sqltool --rcfile /airsonic-workdir/sqltool.rc airsonic-source /airsonic-workdir/subsonic_migrate/export.sql
tar -rf $OUTPUT -C /airsonic-workdir/data export
rm -r /airsonic-workdir/data/export

echo "Compress archive"
xz $OUTPUT
