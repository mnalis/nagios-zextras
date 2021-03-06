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
	install -o root -g root -m 0644 sudo.cfg  $(DESTDIR)/etc/sudoers.d/nagios-zextras
	test -d  $(DESTDIR)/etc/nagios/nrpe.d || install -o root -g root -m 0755 -d $(DESTDIR)/etc/nagios/nrpe.d
	install -o root -g root -m 0644 nrpe.cfg $(DESTDIR)/etc/nagios/nrpe.d/nagios_check_zxsuite.cfg
	
clean:
	find . -name "*~" -print0 | xargs -0r rm -f --

debclean: clean
	fakeroot ./debian/rules clean

mrproper:
	dh clean
	
deb:
	debuild

checkdeb:
	cd .. && lintian --info `ls -1t *deb | head -n 1`

publish: all deb
	cd .. && reprepro include wheezy `ls -1t *.changes | head -n 1`
	git commit -a
	git push
	