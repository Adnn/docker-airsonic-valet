# Docker Airsonic Valet

Docker container configured to access airsonic hsqldb with sqltools, alongside ready-made utility scripts

## Usage

The container should be started with the source data volume mapped to /airsonic-workdir/data/source and the destination to /airsonic-workdir/data/destination

The recommended command, from the repository root:

    docker run -it --rm \
        -v ${SOURCE_VOLUME}:/airsonic-workdir/data/source \
        -v ${DESTINATION_VOLUME}:/airsonic-workdir/data/destination \
        -v $(pwd)/pre_populate:/airsonic-workdir/data/pre_populate \
        -v $(pwd)/backups:/airsonic-workdir/backups \
        adnn/airsonic-valet /bin/sh

* To backup, the `/bin/sh` command could be replaced by `/scripts/backup.sh`
  It does not need /airsonic-workdir/data/destination to exist

* To migrate, the `/bin/sh` command could be replaced by `/scripts/migration.sh`
  The `pre_populate` optional folder can contain .dsv files, that will be executed in order on the `destination`
  volume database before migration occurs.

### Building the container

The container is available from Docker hub: `adnn/airsonic-valet`.

To build locally:

    docker build ./ -t adnn/airsonic-valet
