The popular WordPress blogging platform, adapted as a Sandstorm app.

Publish content to any domain you control,
add collaborators through Sandstorm's
[sharing interface](https://blog.sandstorm.io/news/2015-05-05-delegation-is-the-cornerstone-of-civilization.html),
install arbitrary themes and plugins,
and rest assured that Sandstorm's
[security features](https://docs.sandstorm.io/en/latest/using/security-practices/)
seriously limit the damage that an evil person or plugin could cause.

This app has a few quirks that distinguish it from a standard WordPress install.
Probably the first you'll notice is that it only publishes *static* content.
Unlike a standard WordPress setup, where the published content and the admin panel
get served from the same domain by the same server, in this app
published content can only be static and gets served by Sandstorm's web publishing feature,
while the WordPress admin panel is only accessible to authorized users through the Sandstorm shell.
This has advantages for your site's speed and security, though it does mean that WordPress's Comments feature
will not work on your published site.
