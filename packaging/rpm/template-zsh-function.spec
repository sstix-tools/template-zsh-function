Name:           template-zsh-function
Version:        %{version}
Release:        1%{?dist}
Summary:        Autoloadable Zsh function extension template
License:        MIT
BuildArch:      noarch
Requires:       zsh

%description
An autoloadable Zsh function extension packaged for sstix-tools.

%install
mkdir -p %{buildroot}%{_datadir}/zsh/functions
mkdir -p %{buildroot}%{_datadir}/zsh/site-functions
install -m 0644 %{_sourcedir}/template-zsh-function %{buildroot}%{_datadir}/zsh/functions/template-zsh-function
install -m 0644 %{_sourcedir}/template-zsh-function %{buildroot}%{_datadir}/zsh/site-functions/template-zsh-function
install -m 0644 %{_sourcedir}/_template-zsh-function %{buildroot}%{_datadir}/zsh/site-functions/_template-zsh-function

%files
%{_datadir}/zsh/functions/template-zsh-function
%{_datadir}/zsh/site-functions/template-zsh-function
%{_datadir}/zsh/site-functions/_template-zsh-function
