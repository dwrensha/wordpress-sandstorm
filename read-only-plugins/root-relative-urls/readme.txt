=== Root Relative URLs ===
Contributors: marcuspope
Donate link: http://www.marcuspope.com/
Tags: url, links, admin, multisite, content, permalinks, migration, absolute urls
Requires at least: 3.2.1
Tested up to: 3.5.1
Stable tag: trunk

Converts all URLs to root-relative URLs for hosting the same site on multiple IPs, easier production migration and better mobile device testing.

== Description ==

A Wordpress plugin that converts all URL formats to root-relative URLs to enable seamless transitioning between staging/production host environments and debugging/testing from mobile devices, without the use of hackish tactics like textual find-replace strategies or risky hosts/NAT spoofing strategies.

With Root Relative URLs you can browse your development site from http://localhost/ or http://127.0.0.1/ or from a named network resource like http://mycomputername/ without worrying about links redirecting you back to your site's URL.

This plugin also modifies the tinyMCE hooks so links and media embedded with built-in tools will only insert URLs from the first forward slash after the domain (i.e. the root of your site.)  This means when you push content changes to a staging or production environment they are guaranteed to reference the correct target instead of accidentally referencing a production resource in development or, worse-yet, a development-exclusive resource in production.

It supports path-based MU Installations, but does not support domain-based MU sites due to architectural deficiencies in the Wordpress core.

Version 1.5 fixes an infinite redirect problem that is a result of a core bug in WordPress.  If you have problems with the &lt;!--more--&gt; tag or permalinks for custom post types, please read the FAQ or new Install Steps for support.

Version 2.2 allows for adding certain URL's or partial URL's to a blacklist, meaning I won't use root relative urls, but dynamic absolute URLs instead for displaying content.  This will fix problems with 3rd party plugins, and can be configured on the General Settings page.

== Installation ==

1. Upload the plugin to the `/wp-content/plugins/` directory
1. Add the following entries to your wp-config.php file before the "That's all, stop editing!" comment:

        define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);
        define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
        define('WP_CONTENT_URL', '/wp-content');
        define('DOMAIN_CURRENT_SITE', $_SERVER['HTTP_HOST']);

1. Activate the plugin through the 'Plugins' menu in WordPress Admin
1. Save your permalink settings twice in a row (Admin > Settings > Permalinks : Save Changes) x2
1. You're done! Now you can happily browse and manage your site from any URL, including an IP address if you wish.

== Frequently Asked Questions ==

= Infinite 301 Redirects, Custom Post Type Content and --More-- links =

There was a long outstanding support issue regarding these problems that I think is resolved from my plugin perspective.

The core issue (http://core.trac.wordpress.org/ticket/21824) is still not fixed, and the temporary workaround for that problem is to go into Admin > Settings > Permalinks, and click "Save Changes" twice in a row, letting the page reload between each save.

This should fix the rewrite rules used internally to WordPress to route URLs to custom post content, more links.

= What is a Root-Relative URL? =

A root-relative URL is a special type of relative URL that always starts with a forward-slash (/)

= Aren't relative URLs bad? =

Traditional relative URLs are bad because any change to your directory structure can change where the content is relative to.
But Root-Relative URLs are good because you'll always know where they start, and search engines support their usage so you'll have no problems with SEO.
In fact, over 93% of the top 100 websites (according to Alexa) use root relative urls.  Including Wordpres.org, Wordpress.com, Facebook.com, Twitter.com, Google.com, Wikipedia.org, Yahoo.com, Youtube.com, Amazon.com, Fickr.com etc.
Most RSS Feed readers handle them appropriately (notable exceptions include FeedBurner and FeedBlitz) but my plugin takes into account their lack of HTML specification adherence.

In fact, root relative URL support was established in the very first HTML specification (where it remains today) by Tim Berners-Lee (the real inventor of the World Wide Web) way back in 1993:

"Where the base address is not specified, the reader will use the
   URL it used to access the document to resolve any relative URLs."

Some Wordpress core developers think this is "doing it wrong" and "may not be supported in future content platforms like books."  But I can assure you they are a core & valued aspect of the web and are not likely to go away. (I'm currently trying to explain to FeedBurner & FeedBlitz how it's their responsibility to improve their support for the RSS format and not that of others to adhere to an archaic practice like absolute urls.)

= Why doesn't Wordpress use root-relative URLs to begin with? =

Good question.  There are a number of core developers who think the design decision makes an end-user's life easier.  But that's only for those who maintain
one site and make all of their edits on that public site.  Professional web developers would never consider making changes on a production site because if a mistake
were made (yes even professionals make mistakes) then you have an immediate problem in production.  Instead changes should be made on a development or staging
server first, thoroughly tested, and then migrated to production as a best practice.

With root-relative URLs you can make and test your changes on a staging server and then, when the changes are completely vetted, move your changes to your production
server. You could do this with absolute URLs as well, but that adds an extra step of doing a search / replace of all http://staging.com/ links to http://production.com/.
This extra step is not required in most content management systems. And a step that can potentially break your site depending on what widgets and plugins you are using (http://www.interconnectit.com/719/migrating-a-wordpresswpmubuddypress-website/)

Additionally, unless you are a network administrator, testing your staging URL on an iPhone or other mobile device is really difficult because the recommendation for
staging environments by Wordpress core members is to edit your hosts file.  Only you cannot edit hosts files on a mobile device, so you'd have to resort to complex
router configurations that many people don't have at their disposal on typical WIFI networks.

= Will this plugin correct URLs that are already embedded in my site's content? =

Unfortunately no, this plugin is designed to correct new content as it is entered via the administration panel.  It will still work with your current site,
but it will not alter links you have already embedded.

= Should I use this plugin if I only have one production site and I make all of my changes in production? =

Absolutely!  Just because you have only one site now doesn't mean you won't have a staging site in the future.  If you ever decide to contract out professional
development services you'll want to work with someone who does follow this process.  And at that point in time it will be a nice time-saver if you have already
developed content that works with root-relative links.

= Will this plugin work with MU sites (Multi-user installations)? =

Sort of.  It will work for path-based MU sites, but not for domain-based sites due to an architectural flaw in the Wordpress core.  However, for it to work with path-based installs you
will need to patch a Wordpress core file - or wait until the Wordpress core team implements this fix - http://core.trac.wordpress.org/attachment/ticket/18910/ms-blogs.php.patch

Until then this plugin will not work out of the box for MU installs. I have discovered an approach for resolving this problem without a core hack but I will need to research it before implementing the update.  It will be a big ol nasty hack but it will work.


== Upgrade Notice ==

1. No upgrade notices


== Screenshots ==

1. No screenshots


== Changelog ==
= 2.3 =
* Minor text edits

= 2.2 =
* Feature: Added blacklist entry for disabling root relative urls are specific pages. This is to help with third party plugins
* Bug fix: Added filter to prevent processing of email urls to root relative

= 2.1 =
* Bug fix: really fixed path undefined notice for urls :( why @ symbol didn't work is beyond me. I couldn't reproduce the issue, but this was faster than debugging it.

= 2.0 =
* Enhancement: Added support for wp-include and WPML Multilingual CMS plugin.  Thanks to @tfmtfm for the patch.
* Correction: Fixed changelog notes for version 1.8.

= 1.9 =
* Bug fix: Added more hooks to fix other urls.  Thanks to @lcyconsulting for the solution.

= 1.8 =
* Bug fix: This patch fixes add media support.  Thanks to @najamelan for the suggested solution.

= 1.7 =
* Bug fix: Added fix for users who have customized File Upload paths, image attachments now use root relative urls.

= 1.6 =
* Bug fix: I really wish php < 5.3 would die - fixed incompatible funciton reference.

= 1.5 =
* Bug fix: Fixed an infinite redirect problem caused by a core bug in WordPress - http://core.trac.wordpress.org/ticket/21824

= 1.4 =
* Bug fix: Discovered url fragment identifiers were being dropped entirely from urls, which broke a couple ajax behaviors - most noticeably the menu editor.

= 1.3 =
* Bug fix: Thanks to Kéri Norbert for noticing that 'get_comment_author_url' should not have been relativized

= 1.2 =
* Investigated issue with wp-cron... discovered it was an issue with a different plugin altogether, testing showed no problems with root relative urls.
* Updated plugin to massage rss content urls back to absolute site urls.  This shouldn't need to even happen but unfortunately feedburner and feedblitz don't follow the html spec :(  Google Reader and a bunch of others do however, so there is hope of fixing this problem on feedburner & feedblitz's end.
* Despite this ticket being not yet patched: http://core.trac.wordpress.org/ticket/19210  I have fixed the previous bugs related to comments_link_feed() or comment_link() functions.
* Found an interesting post from way back in 2003, when a woman by the name of Shirley Kaiser went through a similar pursuit to change MovableType from absolute only urls to root relative urls. 2003!!! Almost a decade ago someone else had to show an entire platform the power and flexibility of root relative urls! - (http://brainstormsandraves.com/archives/2003/09/07/relative_vs_absolute_urls/)

= 1.1 =
* Converted plugin to be < php5.3 compatible by removing usage of function references

= 1.0 =
* Initial creation of plugin

== Arbitrary section ==
