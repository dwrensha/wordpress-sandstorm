<?php

if (!function_exists('apache_request_headers')) {
        function apache_request_headers() {
            foreach($_SERVER as $key=>$value) {
                if (substr($key,0,5)=="HTTP_") {
                    $key=str_replace(" ","-",ucwords(strtolower(str_replace("_"," ",substr($key,5)))));
                    $out[$key]=$value;
                }else{
                    $out[$key]=$value;
                }
            }
            return $out;
        }
}

$headers = apache_request_headers();

$sandstorm_base_path = 'http://' . $_SERVER['HTTP_HOST'];

if (isset($headers['X-Sandstorm-Base-Path'])) {
   $sandstorm_base_path = $headers['X-Sandstorm-Base-Path'];
}

if ('https' == substr($sandstorm_base_path, 0, 5)) {
  $_SERVER['HTTPS'] = 'on';
}

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 *
 * TODO(sandstorm): generate these on app initialization
 */

define('AUTH_KEY',         $_SERVER['WORDPRESS_AUTH_KEY']);
define('SECURE_AUTH_KEY',  $_SERVER['WORDPRESS_SECURE_AUTH_KEY']);
define('LOGGED_IN_KEY',    $_SERVER['WORDPRESS_LOGGED_IN_KEY']);
define('NONCE_KEY',        $_SERVER['WORDPRESS_NONCE_KEY']);
define('AUTH_SALT',        $_SERVER['WORDPRESS_AUTH_SALT']);
define('SECURE_AUTH_SALT', $_SERVER['WORDPRESS_SECURE_AUTH_SALT']);
define('LOGGED_IN_SALT',   $_SERVER['WORDPRESS_LOGGED_IN_SALT']);
define('NONCE_SALT',       $_SERVER['WORDPRESS_NONCE_SALT']);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

define('WP_HOME', $sandstorm_base_path);
define('WP_SITEURL', $sandstorm_base_path);
define('WP_CONTENT_URL', '/wp-content');
define('WP_CONTENT_DIR', '/var/wordpress/wp-content');
define('WP_PLUGIN_DIR', '/var/wordpress/wp-content/plugins');
define('WPMU_PLUGIN_DIR', '/var/wordpress/wp-content/mu-plugins');
define('DOMAIN_CURRENT_SITE', $_SERVER['HTTP_HOST']);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
