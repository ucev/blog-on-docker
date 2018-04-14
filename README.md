# Blog on Docker

## Instructions
Once downloaded, run the `setup.sh` script, and it will ask you for the name of the directory to use as a volume and MySQL password.Then, the script will fetch the [`blog`](https://github.com/ucev/blog) repository to the app directory and automatically generate four files -- `docker-compose.yml`, `Dockerfile-web`, `Dockerfile-mysql` and `wait-for-mysql.js`.

Afterwards, go to the app/config directory, copy file `base.config.origin.js` to `base.config.js`, and modify where it needs to config the website.

Next, go to the project's rootdir and exec the command `docker-compose up`, to build, (re)create, start, and attache to containers for a service.

Next, go into the mysql container, and use the file `/app/database.sql` to setup a database for the website.

Finally, visit [http://localhost:3000](http://localhost:3000) and you will see the website.

## Notice
1. While running `setup.sh`, you must have permissions to create directories, and to be able to upload images or other stuffs like this, write permission to the created directories.
2. I think there are better ways to setup MySQL, and I will continue learning.
