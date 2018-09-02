#! /bin/bash

if [ -e app ]
then
rm -rf app
fi

git clone git@github.com:ucev/blog.git app

read -p "Enter dirname to save your data:" rootdir

# to absolute path
mkdir -p $rootdir
rootdir=`cd $rootdir; pwd`

# initiate path
targetdir=$rootdir'/blog'
tmpdir=/tmp/blog
imagedir=$targetdir'/images'
docdir=$targetdir'/docs'
mysqldir=$targetdir'/mysql'

# get mysql password
printf "Enter mysql password:"
stty -echo
read pass < /dev/tty
stty echo
printf "\n"

# create dirs to use as volumes
mkdir -p $tmpdir
mkdir -p $imagedir
mkdir -p $docdir
mkdir -p $mysqldir

tmpdir=${tmpdir//\//\\\/}
imagedir=${imagedir//\//\\\/}
docdir=${docdir//\//\\\/}
mysqldir=${mysqldir//\//\\\/}
pass=${pass//\//\\\/}


for file in `ls ./template`
do
sed "s/MY_TEMP_DIR/$tmpdir/g;s/MY_IMAGE_DIR/$imagedir/g;s/MY_DOCS_DIR/$docdir/g;s/MY_MYSQL_DIR/$mysqldir/g;s/MY_MYSQL_PASS/$pass/g" ./template/$file > $file
done