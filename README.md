# PHP-Experiments Docker Base
This repo contains a basic build for a LAMP stack project.
Just change the variable values in the `base.conf` file for your needs:
```
# APPNAME is what you want your container to be called
# EXTERNAL_PORT is the port you want to be accessible on your local loopback interface

APPNAME="php-exp"
EXTERNAL_PORT="8080"
```
Then run `build.sh` to both build and run the container.
The contents of `/app` is where your application will be served from. The default `index.php` just shows your current `phpinfo()`, so replace as needed.
