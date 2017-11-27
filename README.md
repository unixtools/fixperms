# fixperms

This is a simple utility designed to automatically set file ownership and permissions
for an application userid. This is just a convention for installation of application 
code and scripts where each app is owned by a particular userid. This is generally used
in conjunction with cgiwrap and static web development.

In addition to some basic rules like:

	Executable scripst - owned by user, executable, not executable or readable by others
	Top level dir traversable if any html directory
	HTML dir contents readable by all users

The tool will also process a perms.conf file which has contents like the following to allow
override of permissions - such as to make executables or libraries readable/executable
by other accounts.

This tool is typically intended to be installed and make available for setuid execution
through sudo by any user on the system, but should be done only if the environment is set
up using this model of deployment of scripts as it could otherwise damage permissions.

----------------
file 644 html/.*
file 644 libs/.*
file 644 Artistic
dir 755 html/.*
dir 755 libs/.*
dir 755 html
dir 755 libs
dir 755 .*/.git
dir 755 .*/.git/.*
file 755 .*/.git/.*
dir 755 .
----------------

