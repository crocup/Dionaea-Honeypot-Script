# DHS (Dionaea-Honeypot-Script)
* [Documentation](https://dionaea.readthedocs.io/)
* [Github repo Dionaea](https://github.com/DinoTools/dionaea)

Dionaea is meant to be a nepenthes successor, embedding python as scripting language, using libemu to detect shellcodes, supporting ipv6 and tls.
## About 
Dionaea Honeypot Script - `dhs.sh` and 
Dionaea Hobeypot `Docker` Image

Logging
-------
* log_json

Install
-------------
sh
```bash
$ git clone https://github.com/crocup/DHS
$ cd DHS
$ chmod +x dhs.sh
$ ./dhs.sh
```
Docker
```bash
$ sudo docker build . -t testdionaea
$ sudo docker run -p 21:21 -p 80:80 -p 123:123 -p 443:443 -p 445:445 -p 1443:1443 -p 11211:11211 --name testdio testdionaea
```

Licenses
--------
* dionaea: GPLv2+
* all my files MIT (compatible with GPL)
Documentation
-------------

