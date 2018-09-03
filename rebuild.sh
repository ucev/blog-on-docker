#! /bin/bash

printf "Rebulid only if config file remains the same(Y/n):";
read ans < /dev/tty
if [ ! $ans = "Y" ]
then
printf "EXIT\n";
exit;
fi

if [ ! -f app/config/base.config.js ]
then
printf "\033[1;31;40mERROR: The project hasn't been bulit yet. Please build it first!\033[0m\n";
exit;
fi

cp app/config/base.config.js base.config.js
rm -rf app
git clone git@github.com:ucev/blog.git app
mv base.config.js app/config/base.config.js

docker-compose down
docker-compose build
docker-compose up -d
