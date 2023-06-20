# docker_tao

TAO + ACE as a docker image

## What is TAO

[The ACE ORB (TAO)](http://www.dre.vanderbilt.edu/~schmidt/TAO-overview.html) , which is a standards-based, CORBA middleware
framework that allows clients to invoke operations on distributed
objects without concern for object location, programming language, OS
platform, communication protocols and interconnects, and
hardware. [ACE (ADAPTIVE Communication
Environment)](http://www.dre.vanderbilt.edu/~schmidt/ACE-overview.html)
is an OO framework that implements many core patterns of concurrent
communication software. Since TAO is built on ACE, ACE should be built first. See installation instructions.

# Running

* Run ```docker -it jeteve/tao_ace``` to explore. All is installed in /usr/local/(bin|lib)

# Docker registry

This image is published at https://hub.docker.com/r/jeteve/tao_ace 

## Entry point and command

This image entry point and command are intentionally left blank. This is just the compiled TAO+ACE software that you can run (see Example below).

## Example: Run the tao_cosnaming server.

```
  $ docker run jeteve/tao_ace:6.2.0 tao_cosnaming -d -ORBVerboseLogging 3 -ORBEndpoint iiop://:5353 -ORBDebug
```

## 

# Reference

*  [Installing TAO+ACE on Linux] (http://www.dre.vanderbilt.edu/~schmidt/DOC_ROOT/TAO/TAO-INSTALL.html)

# Building if you really have to

Compiling TAO+ACE is a really time-consuming process. So it is strongly suggested to pull the image from Docker's public repository directly (see Running)

* Run ```build.sh```. The image tags are jeteve/tao_ace:<tao version>.

If you are behind a corporate network that does SSL inspection, you might want to change this
build.sh script to inject a WGET_OPTION. Check the script.
