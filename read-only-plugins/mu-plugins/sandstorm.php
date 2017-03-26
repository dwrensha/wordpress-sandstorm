<?php
/**
 * @package Sandstorm
 * @version 0.0.1
 */
/*
Plugin Name: Sandstorm Integration
Plugin URI: http://github.com/dwrensha/wordpress-sandstorm.git
Description: Lets Sandstorm handle authentication and static web publishing.
Author: Sandstorm Development Group, Inc.
Version: 0.0.1
Author URI: https://sandstorm.io
*/

// don't redirect to wp-login.php
if (!function_exists('auth_redirect')) {
  function auth_redirect() {}
}

function auto_login() {
    if (is_blog_installed() && !is_user_logged_in()) {
       $headers = apache_request_headers();
       $permissions = $headers['X-Sandstorm-Permissions'];
       $permissionsArray = explode(',', $permissions);
       $sandstorm_user_id = $headers['X-Sandstorm-User-Id'];

       if ($sandstorm_user_id) {
           $user = get_user_by('login', $sandstorm_user_id);
           $user_id = '';
           if (!$user) {
               $username = urldecode($headers['X-Sandstorm-Username']);
               $user_id = wp_insert_user(
                               array( 'user_login' => $sandstorm_user_id,
                                      'user_pass' => 'garply',
                                      'nickname' => $username,
                                      'display_name' => $username,
                                      'role' => get_option('default_role'),
                                      'user_email' => ($sandstorm_user_id . '@example.com')));
           } else {
               $user_id = $user->ID;
           }

           $user_role='';
           if (in_array('admin', $permissionsArray)) {
                $user_role = 'administrator';
           } else if (in_array('editor', $permissionsArray)) {
                $user_role = 'editor';
           } else if (in_array('author', $permissionsArray)) {
                $user_role = 'author';
           } else if (in_array('contributor', $permissionsArray)) {
                $user_role = 'contributor';
           } else if (in_array('subscriber', $permissionsArray)) {
                $user_role = 'subscriber';
           }

           if ($user_role) {
               wp_update_user( array( 'ID' => $user_id,
                                      'role' => $user_role));
           }

           if ($headers['X-Sandstorm-User-Picture']) {
             update_user_meta( $user_id, 'sandstorm_user_picture', $headers['X-Sandstorm-User-Picture']);
           }

           wp_set_current_user($user_id, $sandstorm_user_id);
           wp_set_auth_cookie($user_id);
           do_action('wp_login', $sandstorm_user_id);
       }
    }
}
add_action('init', 'auto_login');

function sandstorm_refuse_login() {
  wp_redirect(wp_guess_url() . '/index.php');
  die();
}

add_action('login_init', 'sandstorm_refuse_login');

function sandstorm_publish() {
   $result = shell_exec('/publish-it.sh');
}


function sandstorm_publishing_info() {
  $headers = apache_request_headers();
  $lines = array();
  $result = exec('/sandstorm/bin/getPublicId ' . $headers['X-Sandstorm-Session-Id'], $lines);

  echo "<p>Your public site is available at: <a target='_blank' href='$lines[2]'>$lines[2]</a></p>";

  ?>

   <p>
      To rebuild your public site, click the below button.
      Note that you must click this button after making any changes
      in order for those changes to become visible on the public site.
   </p>

  <form name="post" action="<?php echo esc_url( admin_url( 'admin-post.php' ) ); ?>" method="post" id="generate-static" class="initial-form">
   <p class="submit">
    <input type="hidden" name="action" value="generate_static">
   <?php wp_nonce_field( 'generate-static' ); ?>
   <?php submit_button(__('Rebuild Public Site'), 'primary', 'generate', false); ?>
   <br class="clear"/>
   </p>
  </form>


  <?php

  if ($lines[3] == 'true') {
    echo "<p>If you weren't using a demo account, you could additionally publish the site to an arbitrary domain you control.</p>";
    return;
  }

  ?>

  <p> To set up your domain to point at your public site,
  add the following DNS records to your domain. Replace <code>host.example.com</code> with your site's hostname.
  </p>
  <br>
  <?php

  $cname = parse_url($lines[2], PHP_URL_HOST);
  echo "<code>host.example.com IN CNAME $cname <br>";
  echo "sandstorm-www.host.example.com IN TXT $lines[0] </code>";
  ?>
  <p/>
  <p>
  Note: If your site may get a lot of traffic, consider putting it behind a CDN.
  <a href="https://cloudflare.com" target="_blank">CloudFlare</a>, for example, can do this for free.
  </p>

  <?php
}

add_action('admin_post_generate_static', 'sandstorm_generate_static');

function sandstorm_generate_static() {
  if (current_user_can('publish_pages')) {
    sandstorm_publish();
    wp_redirect(wp_guess_url() . '/wp-admin/index.php');
    die();
  }
}

function add_sandstorm_dashboard_widget() {
  remove_meta_box( 'dashboard_primary', 'dashboard', 'side' );
  remove_meta_box( 'dashboard_activity', 'dashboard', 'normal');

  if (current_user_can('publish_pages')) {
      wp_add_dashboard_widget( 'sandstorm_dashboard_widget', 'Sandstorm Publishing Information',
                               'sandstorm_publishing_info');
  }

}

add_action( 'wp_dashboard_setup', 'add_sandstorm_dashboard_widget' );


// Disable plugin deactivation.
add_filter( 'plugin_action_links', 'disable_plugin_deactivation', 10, 4 );
function disable_plugin_deactivation( $actions, $plugin_file, $plugin_data, $context ) {

  $vital_plugins = array('sqlite-integration/sqlite-integration.php');

  if (in_array($plugin_file, $vital_plugins)) {

    // Remove deactivate link.
    if ( array_key_exists( 'deactivate', $actions ) ) {
      unset( $actions['deactivate'] );
    }

    $actions['warning'] = 'Needed by Sandstorm.';

  }
  return $actions;
}


add_filter('get_search_form', 'sandstorm_search_form');
function sandstorm_search_form($orig) {
    if (isset(apache_request_headers()['X-Sandstorm-Username'])) {
       // We can submit the usual WordPress search query.
       return $orig;
    } else {
       // Use Google search for the published static site.

      $form = '<form action="http://google.com/search" id="searchform" class="search-form" method="post" name="google-search" target="_blank">'.
            '<input type="hidden" name="sitesearch" class="google-search-input">'.
            '<input type="text" name="q" id="s" placeholder="Search" class="search-field">'.
            '</form>'.
            '<script type="text/javascript">'.
            'Array.prototype.forEach.call(document.getElementsByClassName("google-search-input"), function (x) {x.value=window.location.host});'.
            '</script>';
      return $form;
   }
}

add_filter('editable_roles', 'sandstorm_editable_roles');
function sandstorm_editable_roles($orig) {
   // None should be editable because Sandstorm handles role assignment.
   return array();
}


add_filter('get_avatar', 'sandstorm_get_avatar', 1, 5);
function sandstorm_get_avatar($avatar, $id_or_email, $size, $default, $alt) {
  if (is_numeric($id_or_email)) {
    $avatar_url = get_user_meta($id_or_email, 'sandstorm_user_picture', True);
    if ($avatar_url) {
      $avatar = "<img alt='{$alt}' src='{$avatar_url}' class='avatar avatar-{$size} photo' height='{$size}' width='{$size}' />";
    }
  }
  return $avatar;
}

// Remove a bunch of things we don't want.
remove_action('wp_head', 'rsd_link');
remove_action('wp_head', 'wlwmanifest_link');
remove_action('wp_head', 'wp_generator');
remove_action('wp_head', 'wp_shortlink_wp_head');
remove_action( 'wp_head', 'feed_links_extra', 3 );

# Feeds mostly work, but they get published at feed/index.html.
#remove_action( 'wp_head', 'feed_links', 2 );


