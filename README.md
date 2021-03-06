                         OL - Otus Lisp - yet another pet lisp
                         Copyright(c) 2014 Aki Helin
                         Copyright(c) 2014 - 2016 Yuriy Chumak

                         Grew out of the Owl Lisp by Aki Helin

                         at https://yuriy-chumak.github.io/ol/
[![Join the chat at https://gitter.im/otus-lisp/Lobby](https://badges.gitter.im/otus-lisp/Lobby.svg)](https://gitter.im/otus-lisp/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

VERSION 1.1

LICENSE
--------------------------------------------------------------

This program is free software;  you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of
the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

You should have received a copy of the GNU GPL along with this
program.           If not, see <http://www.gnu.org/licenses/>.

RELATED
--------------------------------------------------------------
              http://people.csail.mit.edu/jaffer/Scheme (r5rs)
              http://groups.csail.mit.edu/mac/projects/scheme/

              Original Owl Lisp project can be found at
              https://code.google.com/p/owl-lisp/
              https://github.com/aoh/owl-lisp


OVERVIEW
--------

Otus Lisp is a purely\* functional dialect of Lisp.
It implements an extended subset of R5RS Scheme. It
is small, embeddable and crossplatform. It can call
and be called by native applications and libraries.


REQUIREMENTS
------------

For un*x you should have GCC >3.2 installed.

For windows you should have MINGW installed.

For un*x you maybe want MAKE installed also.


DOWNLOAD / INSTALLATION
-----------------------

Installation packages for CentOS 6 (x86, amd64), CentOS 7 (amd64),
Debian 7 (x86, amd64), Debian 8 (x86, amd64), Fedora 22 (x86, amd64),
Fedora 23 (x86, amd64), RHEL 5 (x86, amd64), RHEL 6 (x86, amd64),
RHEL 7 (amd64), SLE 10 (x86, amd64), SLE 11 (x86, amd64), SLE 12 (amd64),
ScientificLinux 6 (x86, amd64), ScientificLinux 7 (amd64),
Univention 3.2 (x86, amd64), Univention 4.0 (x86, amd64),
openSUSE 13.1 (x86, amd64), openSUSE 13.2 (x86, amd64), openSUSE Factory
(aarch64, armv7l), openSUSE Leap 42.1 (amd64), openSUSE Tumbleweed (x86, amd64),
Ubuntu 12.04 (x86, amd64), Ubuntu 14.04 (x86, amd64, aarch64, armv7l),
Ubuntu 16.04 (x86, amd64) can be found at
[openSUSE Build Service](https://software.opensuse.org/download.html?project=home%3Ayuriy-chumak&package=ol)

Installation packages for Windows (x86, amd64) on the way.

Precompiled binaries for Android (arm64-v8a, armeabi, armeabi-v7a,
mips, mips64, x86, x86_64) on the way.

Precompiled binary for Odroid (Ubuntu 14.04, armv7l) on the way.


BUILD
-----

### SIMPLE WAY

   $ make; make install

* gmake for unix and *bsd clients


### MORE INTERESTING WAYS

#### Linux way

To build OL

    $ gcc src/olvm.c src/boot.c  -std=c99 -O2  -o ol -ldl

To build only olvm (virtual machine)

    $ gcc src/olvm.c -DNAKED_VM  -std=c99 -O2  -o vm -ldl


Olvm can execute only precompiled OL scripts (see BINARY SCRIPTS
section) and is very small (about 35KB).
Full OL with interpreter that can execute text lisp scripts more
fat (about 400KB executable).


#### Windows way

To build OL

    > set PATH=%PATH%;C:\MinGW\bin
    > gcc.exe src\olvm.c src\boot.c -IC:\MinGW\include\ -LC:\MinGW\lib\ -std=c99 -O2  -o ol -lws2_32

To build only olvm (virtual machine)

    > set PATH=%PATH%;C:\MinGW\bin
    > gcc.exe src\olvm.c -DNAKED_VM -IC:\MinGW\include\ -LC:\MinGW\lib\ -std=c99 -O2  -o ol -lws2_32


#### FreeBSD/OpenBSD/NetBSD way

BSD require including "c" library instead of dl:

    $ gcc src/olvm.c src/boot.c  -std=c99 -O2  -o ol -lc
    $ gcc src/olvm.c -DNAKED_VM  -std=c99 -O2  -o vm -lc


#### Android way

    $ ndk-build

#### MacOS/iOS way

   tbd.

#### Open webOS way

Put toolchain/ol.bb bitbake receipe into any place of open webOs
receipes folder (i.e. ./meta-oe/) and run "make ol" from root
open webOs folder.

Upload ol executable from BUILD/work/<build-name>/ol/1.0.0-1-r0/build
to machine /bin.

Now you cat execute ol under webos command line or other way you
would like.


### VERY INTERESTING WAY

You can change OL scheme language (yes, you can) by editing sources in
lang/ and owl/ subfolders. Additionally you can change virtual machine
by editing src/vm.scm and src/olvm.c source files.

To build OL language (not OL virtual machine)

    $ make recompile

This will create new (in successfull way) repl binary that contains ol
interpreter code

Few words about OL can be found in documentation on the project page.


SPEEDUP
-------

You can disable most internal checks for speedup by editing the olvm.h
header file - for example you can uncomment "#define CAR_CHECK(arg) 1"
macro to disable the virtual machine internal checks for car validness.
Please, be aware - this can make olvm less stable!


ADDITIONAL OL VM FEATURES
-------------------------

To disable sockets support (linux and windows) you can please add
-DHAS_SOCKETS=0 to gcc command line or set appropriate define in
src/olvm.h to 0. You can remove -lws2_32 for Windows from command
line additionally.

To disable dlopen/dlsym (LoadLibrary/GetProcAddress for windows)
support you can add -DHAS_DLOPEN=0 to gcc command line or set
appropriate define in src/olvm.h to 1. You can remove -ldl for
Linux from command line additionally.

Please note that external libraries (like opengl, sqlite, etc.)
support require HAS_DLOPEN enabled.

To disable pinvoke (Platform Invoke mechanism) support you can add
-DHAS_PINVOKE=0 to gcc command line or set appropriate define in
src/olvm.h to 0.

Please note that external libraries (like opengl, sqlite, etc.)
support require HAS_PINVOKE enabled.

For embedding OL into your project check the EMBEDDED OL section.


RUNNING
-------

There are few ways to execute ol

#### Interactive mode

    $ ol
    You see a prompt.
    Type ',help' to help, ',quit' to end session
    > (+ 1 2 3)                      # now you in REPL and can play with in
    6
    > ,quit                          # this ends interactive session
    bye bye :/

#### Unattended mode

    $ ol scriptname.ol                # text script
    $ ol scriptname.bl                # binary (compiled) script
    $ echo '(print (+ 1 2 3))' | ol

For Windows

    > echo (print (+ 1 2 3)) | ol


BINARY SCRIPTS
--------------

OL can execute precompiled scripts. You can compile your script
by using this code

    --- cut ---
    (define (main)
       #true ; anything you want to compile
    )

    (vector->file (list->vector (fasl-encode (lambda (args)
       (main)))) "out.bl")
    --- cut ---

where "out.bl" your output file name

As result will be create binary script, that can be executed
directly by ol or vm:

    ---cut ---
    0000000000: 02 10 0C 19 02 00 07 01 | 01 02 05 02 05 01 11 02
    0000000010: 10 09 19 01 00 04 8D 04 | 18 04 11 01 11 02 02 01
    0000000020: 00                      |
    ---cut ---

Now you can execute this code by OL as full OL or as "naked" OLvm

    $ ol out.bl


FILES
-----

* src/olvm.h  - the OL virtual machine header
* src/olvm.c  - the OL vm
* src/boot.c  - the OL interpreter/compiler
* lang/*.scm  - implementation of OL repl and compiler
* owl/*.scm   - implementation of OL libraries
* r5rs/*.scm  - r5rs compliant OL language part
* tests/*.scm - some automated tests


TRICKS
------

Register interpreter in the ms windows:

    assoc .ol=OLisp.File
    ftype OLisp.File=ol "%1" %*
    assoc .bl=OLisp.Binary.File
    ftype OLisp.Binary.File=ol "%1" %*

Register interpreter in the linux:

    #!/usr/bin/ol


USAGE
-----

OL (Otus Lisp) can be used either interactively, or to interpret code
from files, or compile programs to fasl-images. The difference between
an ol program and a plain script is that the program should just have
a function of one argument as the last value, which will be called with
the command line argument list when the program is executed.


EMBEDDED OL
-----------

(please, this section is outdated, please wait to updates)

OL can be embedded in your project. More info can be found in docs.

This is usage sample:

    --- cut ---
    // embedded example
    #include "olvm_xtra.h"

    __attribute__((__visibility__("default")))
    word* sample_add(OL* ol, word arguments) {
        word* fp; // memory pointer
        fp = ol->fp;

        word* fa = (word*)car(arguments); arguments = cdr(arguments);
        word* fb = (word*)car(arguments); arguments = cdr(arguments);

        // math
        int a = sftoi(fa);
        int b = sftoi(fb);
        int r = a + b;
        // result
        word* result = F(r);

        ol->fp = fp;//
        return result;
    }

    int main(int argc, char** argv)
    {
        return vm_new(
            "(import (otus pinvoke) (owl io))"
            "(define % (dlopen))" // get own handle
            "(define sample_add (dlsym+ % \"sample_add\"))"
            "(print \"sample_add: \""
            "   (sample_add 1 2))"
            "(halt 1)", 0);
    }
    --- cut ---

You can call your own functions from OL code.

Currently this is more complecated. You need:

a. compile OL with -DHAS_DLOPEN and -DHAS_PINVOKE options
      (don't forget for -DEMBEDDED_VM)

b. send to vm "(import (otus pinvoke))" (owl/pinvoke.scm must
      be accessible from your executable)

c) send to vm "(define me (dload))" where "me" is some
      appropriate variable name or you can use "let, let*" or
      any other construction you like

Now you have two variants - embed OL function or simple C function call.

For embed OL function call you must

d. declare you function for OL like this
      '(define myFuction (dlsym+ me "functionname"))'
      in this code
      *) "functionname" - function name string. you must export this
         function from your code to make it accessible from OL
      Now your function will receive OL* as furst parameter. This structure
      provides memory pointer and you have low-level access to OL scructures.
      This mechanism will help to provide you OL language native extensions, in
      feature structure will extent by help functions.

For normal C function call (actually platform invoke mechanism) you must

e. declare you function for OL (via vm_puts, sure) like this
      '(define myFuction (dlsym me type-int+ "functionname" type-string type-int+))'
      in this code
      *) myFunction - any appropriate variable name for your function
         internal OL script name. This variable will associated with
         lambda that can be called in further code.
      *) second argument in (dlsym) is return type of native function
         available types you can check in owl/pinvoke.scm
      *) third (dlsym) arg is function name string. you must export this
         function from your code to make it accessible from OL
      *) other (dlsym) args is argument types for native function, pinvoke
         will try to convert arguments of myFunction lambda to this type.
         available types can be checked in owl/pinvoke.scm too.

Small comment for this: if you want to get number - let use type-int+,
         if you expect SMALL number - let use type-fix+. No differences between
         types with + and with - are present.
   e) well, now you can freely use your native function like this for example
      '(print (myFunction "str1" 123))'

More information about pinvoke you can get in source files
    lib/sqlite.scm
    lib/opengl.scm and OpenGL/version-X-X.scm
    lib/winapi.scm
    lib/x11.scm

* All embedded OL api in progress and can be changed in feature.


DOCUMENTATION
-------------

Please refer to the [project page](yuriy-chumak.github.io/ol/)

Or check the source codes - r5rs/core.owl


SOME NOTES
----------

* env *special-forms* list of all special forms
* vm *primitives* list of all primitives
* lang *owl-core* basic OL language elements
