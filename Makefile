PLUGIN_DIR=$(DESTDIR)/usr/lib/nagios/plugins

all:
	@echo 'use "make install" to install, or "dpkg-buildpackage -rfakeroot" to build debian package'

install: install_bin install_etc
	@echo finished.
	
install_bin:
	test -d $(PLUGIN_DIR) || install -o root -g root -d $(PLUGIN_DIR)
	install -o root -g root -m 0755 nagios_check_zxsuite $(PLUGIN_DIR)
	
install_etc:	
	test -d  $(DESTDIR)/etc/sudoers.d || install -o root -g root -m 0755 -d $(DESTDIR)/etc/sudoers.d
	install -o root -g root -m 0644 nagios-zextras-sudo  $(DESTDIR)/etc/sudoers.d/nagios-zextras-sudo
	
clean:
	find . -name "*~" -print0 | xargs -0r rm -f --
