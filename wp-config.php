<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

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

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'database_name_here');

/** MySQL database username */
define('DB_USER', 'username_here');

/** MySQL database password */
define('DB_PASSWORD', 'password_here');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

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
define('AUTH_KEY',         'gIg`TXjHSlygyuy8;T8-vT9MQMy+Ie<KV+|r(7.[K.Y~ov_C0gri-P+`?$!;i=}P');
define('SECURE_AUTH_KEY',  '|h4BF{kf[Y0QL.l,=CkmlLQDcMLhGY=I9H;nyDx_.:~F j&y=xY1<~|-|=|;$f,N');
define('LOGGED_IN_KEY',    '+mLY8n`H>w9 #o!=flw#(.l& -,4,Xr_v$,a5m1HdR[/G/:4/zbAm8MB4*55g5jB');
define('NONCE_KEY',        '!t=XE+c>,)ruUW4>tu3eBN8M&P]GsnI/!xn;ElXs4VW?<_79TfayDyOJ76e|_P6)');
define('AUTH_SALT',        '[<3VgBGo^eUZnX/t9IF71B`J`(y$Uqv(`d8rc+8](M$qT]W;:i,S&-soWn]=PF*E');
define('SECURE_AUTH_SALT', 'Gnfxy5{K%.7CTAX|dvyz%;6466dr]uU1!voS.*>Rg-eK^znbs;SLpQO^h7OEQFF-');
define('LOGGED_IN_SALT',   'Hu=ER#3[l.IxA%5]a2G5&2#1Za-Fi+`WXw@z?b|:3&dIE76_I1DWLqLqU_ %+1i+');
define('NONCE_SALT',       '*T~9fvR;DCY~6gqw{H-qS|n(~9W>lo.))kSfv]pmH-_WKV7?W-Knh|i2V;n l>|I');

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

// XXX what about https?
define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_CONTENT_URL', '/wp-content');
define('DOMAIN_CURRENT_SITE', $_SERVER['HTTP_HOST']);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
