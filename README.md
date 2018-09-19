centos-davical
==============

A DAViCal image built on top of CentOS 7.

Pull
----

Either pull from Quay.io:

    docker pull quay.io/mugful/centos-davical:master

Or build your own:

    git clone https://github.com/mugful/centos-davical
    cd centos-davical
    docker build --force-rm -t mugful/centos-davical:master .

Run
---

The centos-davical image is stateless, you won't need any volumes
exported. However, DAViCal saves its state in a Postgres database, so
you'll need to link the DAViCal container to a Postgres one.

The database and accounts need to be created before starting the
DAViCal container. If you're running mugful's centos-postgres, you
can create them like so:

    # assuming the container name is 'postgres'
    docker exec -t -i -u postgres postgres createuser davical_dba
    docker exec -t -i -u postgres postgres createuser davical_app
    docker exec -t -i -u postgres postgres createdb -O davical_dba davical
    # use custom passwords :)
    docker exec -t -i -u postgres postgres psql -c "ALTER USER davical_dba WITH PASSWORD 'dba_password';"
    docker exec -t -i -u postgres postgres psql -c "ALTER USER davical_app WITH PASSWORD 'app_password';"

Also don't forget to allow password auth in pg_hba.conf of your
Postgres, as its disabled by default in centos-postgres. See the
readme of centos-postgres for more info.

At this point the responsibility for the rest of the DB initialization
can be passed onto the DAViCal container. Just make sure to link it to
the Postgres container and give it the DB passwords created earlier,
and provide one more password for the DAViCal admin user which will be
created (= web UI admin password, not DB admin password):

    docker run \
        --name davical \
        --link postgres \
        -e DAVICAL_DB_PASSWORD='app_password' \
        -e DAVICAL_DBA_PASSWORD='dba_password' \
        -e DAVICAL_ADMIN_PASSWORD='admin_password' \
        -p 8080:80 \
        quay.io/mugful/centos-davical:master
