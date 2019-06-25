FROM alpine:3.10

# Default tar is very limited, cannot append
RUN apk add curl git openjdk8-jre python tar vim xz

WORKDIR /airsonic-workdir
COPY sqltool.rc ./
RUN curl -O http://central.maven.org/maven2/org/hsqldb/hsqldb/1.8.0.10/hsqldb-1.8.0.10.jar \
    && git clone https://github.com/Adnn/subsonic_migrate.git
