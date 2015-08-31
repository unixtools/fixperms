
Summary: Fixperms Tool
Name: fixperms
Version: 2.0.0
Release: 1%{?dist}
License: Distributable
Group: System Environment/Base
BuildArch: noarch

Packager: Nathan Neulinger <nneul@neulinger.org>

Source: fixperms-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description

This contains a script for populating permissions on an account from a config file, along with
setting some of the top level permissions according to expected requirements, such as any user
being able to traverse through htdocs dir.

This is probably not of general interest as it has a lot of expectations on the underlying
operating environment that may not match general usage.

%prep
%setup -c -q -n fixperms

%build
cd fixperms-%{version}
make DESTDIR=$RPM_BUILD_ROOT

%install

cd fixperms-%{version}
make DESTDIR=$RPM_BUILD_ROOT install

mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/sbin
cp -pr fixperms $RPM_BUILD_ROOT/usr/bin
cp -pr handle-fixperms $RPM_BUILD_ROOT/usr/sbin

%clean
%{__rm} -rf %{buildroot}

%files

%attr(0755, root, root) /usr/bin/fixperms
%attr(0755, root, root) /usr/sbin/handle-fixperms

%changelog
