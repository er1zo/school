#!/bin/bash

# if we have enough rights
if [ $UID -ne 0 ]
then 
	echo "you don't have enough permissions"
	exit 1
fi


#how namy vars we have
# 2 for dir&group, 3 for same and if we share it
if [ $# -eq 1 ]
then
	WWW=$1
else
	echo "usage: WWW"
fi

#checking if samba exists on server
type apache2 > /dev/null 2>&1 
 
if [ $? -ne 0 ]
then
  apt-get update > /dev/null 2>&1 && apt-get install apache2 -y || exit 1 
fi

#creating directory for the new site
mkdir /var/www/$WWW
touch /var/www/$WWW/index.html

#creating simple index.html
echo "
<HTML>
<HEAD>
    <TITLE>
    This is my page
    </TITLE>
</HEAD>

<BODY>
    Page: $WWW
</BODY>
</HTML>" > /var/www/$WWW/index.html


#creating conffile and conf for new www
echo "<VirtualHost *:80>
        ServerAdmin webmaster@localhost
		ServerAlias $WWW
        DocumentRoot /var/www/$WWW
        ErrorLog ${APACHE_LOG_DIR}/$WWW\_error.log
        CustomLog ${APACHE_LOG_DIR}/$WWW\_access.log combined

</VirtualHost>" > /etc/apache/sites-enabled/$WWW.conf
