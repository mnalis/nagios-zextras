PLUGIN_DIR=$(DESTDIR)/usr/lib/nagios/plugins

all:
	@echo 'use "make install" to install, or "dpkg-buildpackage -rfakeroot" to build debian package'
	
install:
	test -d $(PLUGIN_DIR) || install -o root -g root -d $(PLUGIN_DIR)
	install -o root -g root -m 0755 nagios_check_zxsuite $(PLUGIN_DIR)
	
clean:
	find . -name "*~" -print0 | xargs -0r rm -f --
