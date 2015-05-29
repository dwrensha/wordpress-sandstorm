wordpress_repo = https://github.com/dwrensha/wordpress.git
wordpress_repo_branch = sandstorm-app-4.1

.PHONY: all clean

all: wordpress/.git wordpress-read-only

clean:
	rm -rf wordpress-read-only

wordpress/.git:
	git clone ${wordpress_repo} wordpress && cd wordpress && git checkout ${wordpress_repo_branch}

wordpress-read-only: wordpress/.git
	cp -r wordpress wordpress-read-only
	rm -rf wordpress-read-only/.git
	cp wp-config.php wordpress-read-only/
	mv wordpress-read-only/wp-content wordpress-read-only/wp-content-read-only
	ln -s /var/wordpress/wp-content wordpress-read-only/wp-content
	cp read-only-plugins/sqlite-integration/db.php wordpress-read-only/wp-content-read-only/

