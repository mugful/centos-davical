<?php
$c->pg_connect[] = array( 'dsn' => 'pgsql:dbname=$DAVICAL_DB_NAME port=$DAVICAL_DB_PORT host=$DAVICAL_DB_HOST', 'dbuser' => '$DAVICAL_DB_USER', 'dbpass' => '$DAVICAL_DB_PASSWORD' );

$c->admin_email ='noreply@example.com';
$c->restrict_setup_to_admin = true;

$c->authenticate_hook['server_auth_type'] = 'Basic';
include_once('AuthPlugins.php');
?>
