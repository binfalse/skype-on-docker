# SKYPE on DOCKER

This is a Dockerfile to build a jail for skype. It is based on a [Debian:stable](https://hub.docker.com/_/debian/).

# USAGE

* Store your SSH public key in the `authorized_keys` file:

    cat ~/.ssh/id_rsa.pub >> authorized_keys

* Build the image

    docker build -t binfalse/skype .

* Start a container

    docker run -d -p 127.0.0.1:55757:22 --name skype binfalse/skype

* Run skype out of the container

    ssh -X -p 55757 docker@127.0.0.1 skype

* Delete the container when you're done

    docker rm -f skype

# MORE

You can also commit after an inital setup, so you can, for example, omit the sign-in step etc. For more information go to [binfalse.de](http://binfalse.de).


