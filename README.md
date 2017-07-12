This is a fork of [pavlovai/yourls](https://github.com/pavlovai/yourls) with several updates:

* YOURLS version updated to 1.7.2
* Set YOURLS_NO_HASH_PASSWORD to `false` by default and make it configurable
* Update php image to 7.1.7
* Add docker-compose file

# yourls

Simple Docker container for [YOURLS](https://yourls.org/).

## Usage

Available on Docker Hub as [fbcbarbosa/yourls](https://hub.docker.com/r/fbcbarbosa/yourls).

    $ docker run \
        -e YOURLS_DB_USER=root \
        -e YOURLS_DB_PASS=supersecureyo \
        -e YOURLS_DB_NAME=yourls \
        -e YOURLS_DB_HOST=localhost \
        -e YOURLS_DB_PREFIX=yourls_ \
        -e YOURLS_SITE=http://my-yourls-site.com \
        -e YOURLS_COOKIEKEY=evenmoresecure \
        -e YOURLS_USERS=adminusername:adminpassword \
        -e YOURLS_NO_HASH_PASSWORD=false \
        -it fbcbarbosa/yourls

The server will be listening on port 80. You'll need to set up a MariaDB/MySQL instance before getting started. Check out [config.php](https://github.com/fbcbarbosa/yourls/blob/master/config.php) for a few more configuration options. Define a `/root` short-link to set the root redirect.

## Development

    $ make build
    $ make push

## License & Acknowledgements

YOURLS is released under the [MIT license](https://github.com/YOURLS/YOURLS/blob/master/LICENSE.md). This Docker image is released under the [BSD 3-Clause license](https://github.com/pavlovml/yourls/blob/master/LICENSE).

This image is inspired by [tsgoff/docker-yourls](https://github.com/tsgoff/docker-yourls) and [fauzanariffin/docker-yourls](https://github.com/fauzanariffin/docker-yourls). Thanks for being awesome. :)
