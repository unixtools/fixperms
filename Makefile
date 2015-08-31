VERSION=2.0.0
TOP=`pwd`

all:

install:
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/sbin
	cp fixperms $(DESTDIR)/usr/bin
	cp handle-fixperms $(DESTDIR)/usr/sbin

dist:
	rm -rf /tmp/fixperms-$(VERSION)
	mkdir /tmp/fixperms-$(VERSION)
	cp -pr . /tmp/fixperms-$(VERSION)
	cd /tmp/fixperms-$(VERSION) && rm -rf *.gz .git .gitignore
	tar -C/tmp -czvf ../fixperms-$(VERSION).tar.gz fixperms-$(VERSION)
	rm -rf /tmp/fixperms-$(VERSION)

deb: dist
	cp ../fixperms-$(VERSION).tar.gz ../fixperms_$(VERSION).orig.tar.gz
	dpkg-buildpackage
	rm ../fixperms_$(VERSION).orig.tar.gz

rpm: dist
	rm -rf rpmtmp
	mkdir -p rpmtmp/SOURCES rpmtmp/SPECS rpmtmp/BUILD rpmtmp/RPMS rpmtmp/SRPMS
	cp ../fixperms-$(VERSION).tar.gz rpmtmp/SOURCES/
	rpmbuild -ba -D "_topdir $(TOP)/rpmtmp" \
		-D "_builddir $(TOP)/rpmtmp/BUILD" \
		-D "_rpmdir $(TOP)/rpmtmp/RPMS" \
		-D "_sourcedir $(TOP)/rpmtmp/SOURCES" \
		-D "_specdir $(TOP)/rpmtmp/SPECS" \
		-D "_srcrpmdir $(TOP)/rpmtmp/SRPMS" \
		rpm/fixperms.spec
	cp $(TOP)/rpmtmp/RPMS/noarch/* ../
	cp $(TOP)/rpmtmp/SRPMS/* ../
	rm -rf rpmtmp
