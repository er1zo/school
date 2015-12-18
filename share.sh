#!/bin/bash
# 1. check if we have enough rights
# 2. get dir name
# 3. get groupname
# 4. check if dir exists
# 5. create dir if needed
# 6. check if group exists
# 7. create group if needed
# 8. add conf to smb.conf
# 9. restart samba

# if we have enough rights
if [ $UID -ne 0]
then 
	echo "you don't have enough permissions"
	exit 1
fi


#how namy vars we have
# 2 for dir&group, 3 for same and if we share it
if [ $# -eq 2]
then
	DIR=$1
	GROUP=$2
else
	if [ $# -eq 3]
	then
		DIR=$1
		GROUP=$2
		SHARE=$3
	else
		echo "usage: DIR GROUP (SHARE)"
	fi
fi

#checking if samba exists on server
type smbd > /dev/null 2>&1 
 
if [ $? -ne 0 ]
then
  apt-get update > /dev/null 2>&1 && apt-get install samba -y || exit 1 
fi

# check if we have DIR and GROUP
test -d $DIR && echo $DIR exists || mkdir $DIR
getent group $GROUP && echo $GROUP exists || groupadd $GROUP	

#add DIR to samba
echo "[$DIR]
 comment="directory for $GROUP" 
 path=$DIR
 writable=yes
 valid users=@$GROUP
 browsable=yes
 create mask=0664
 directory mask=0775" >> /etc/samba/smb.conf
service smbd restart