#!/bin/bash

docker run -d -p 127.0.0.1:55757:22 --name skype__ binfalse/deb-skype && sleep 1 && ssh -X -p 55757 docker@127.0.0.1 skype && docker rm -f skype__


