<?php
////////////// REDIS CACHE CONFIGURATION //////////////

define( 'WP_REDIS_HOST', getenv('REDIS_HOST') );
define( 'WP_REDIS_PORT', getenv('REDIS_PORT') );
//define( 'WP_REDIS_PASSWORD', 'secret' );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );

// change the database for each site to avoid cache collisions
//define( 'WP_REDIS_DATABASE', 0 );

// supported clients: `phpredis`, `credis`, `predis` and `hhvm`
// define( 'WP_REDIS_CLIENT', 'phpredis' );

// automatically delete cache keys after 7 days
// define( 'WP_REDIS_MAXTTL', 60 * 60 * 24 * 7 );

// bypass the object cache, useful for debugging
// define( 'WP_REDIS_DISABLED', true );

define( 'DB_NAME', getenv('MARIADB_DATABASE') );
define( 'DB_USER', getenv('MARIADB_USER') );
define( 'DB_PASSWORD', getenv('MARIADB_PASSWORD') );
define( 'DB_HOST', getenv('MARIADB_HOST').':'.getenv('MARIADB_PORT') );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',			'put your unique phrase here');
define('SECURE_AUTH_KEY',	'put your unique phrase here');
define('LOGGED_IN_KEY',		'put your unique phrase here');
define('NONCE_KEY',			'put your unique phrase here');
define('AUTH_SALT',			'put your unique phrase here');
define('SECURE_AUTH_SALT',	'put your unique phrase here');
define('LOGGED_IN_SALT',	'put your unique phrase here');
define('NONCE_SALT',		'put your unique phrase here');

define('WP_SITEURL', 'https://' . getenv('DOMAIN_NAME'));
define('DOMAIN_CURRENT_SITE', 'https://' . getenv('DOMAIN_NAME'));
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 2);
define( 'NOBLOGREDIRECT', 'https://' . getenv('DOMAIN_NAME'));

$table_prefix = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

define( 'CONCATENATE_SCRIPTS', false );
// define( 'SCRIPT_DEBUG', true );

require_once ABSPATH . 'wp-settings.php';
