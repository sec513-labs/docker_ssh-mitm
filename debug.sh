#!/bin/bash

host=$1
port=$2

/bin/cat <<EOT > debug.patch
--- openssh-7.5p1-mitm.patch	2020-11-25 07:10:46.310404602 +0000
+++ openssh-7.5p1-mitm.patch-debug	2020-11-25 07:12:14.545678457 +0000
@@ -554,7 +554,7 @@
 diff -ru --new-file -x '*~' -x 'config.*' -x Makefile -x opensshd.init -x survey.sh -x openssh.xml -x buildpkg.sh -x output.0 -x requests -x traces.0 -x configure openssh-7.5p1/lol.h openssh-7.5p1-mitm/lol.h
 --- openssh-7.5p1/lol.h	1970-01-01 00:00:00.000000000 +0000
 +++ openssh-7.5p1-mitm/lol.h	2019-09-08 23:26:17.143042221 +0000
-@@ -0,0 +1,62 @@
+@@ -0,0 +1,60 @@
 +#ifndef LOL_H
 +#define LOL_H
 +
@@ -564,10 +564,8 @@
 +/* Define these in order to force connections to a test host.
 + * Useful for quickly testing changes without needing to ARP 
 + * spoof; just connect to sshd's port directly. */
-+/*
-+#define DEBUG_HOST "testhost"
-+#define DEBUG_PORT 22
-+*/
++#define DEBUG_HOST "$host"
++#define DEBUG_PORT $port
 +
 +/* This is the user account that all incoming connections will authenticate
 + * as (the provided user name is ignored). */
EOT

/usr/bin/patch openssh-7.5p1-mitm.patch < debug.patch

