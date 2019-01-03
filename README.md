![No longer maintained](https://img.shields.io/badge/Maintenance-OFF-red.svg)
### [DEPRECATED] This repository is no longer maintained
> While this project is fully functional, the dependencies are no longer up to date. You are still welcome to explore, learn, and use the code provided here.
>
> Modus is dedicated to supporting the community with innovative ideas, best-practice patterns, and inspiring open source solutions. Check out the latest [Modus Labs](https://labs.moduscreate.com?utm_source=github&utm_medium=readme&utm_campaign=deprecated) projects.

[![Modus Labs](https://res.cloudinary.com/modus-labs/image/upload/h_80/v1531492623/labs/logo-black.png)](https://labs.moduscreate.com?utm_source=github&utm_medium=readme&utm_campaign=deprecated)

---

Notes on building MilkyTracker
==============================

If you have obtained the MilkyTracker sources from the version control
repository, the autotools generated files (INSTALL, configure, etc) will
be missing. To obtain these either generate them using 'autoreconf -i'
(requires autoconf/automake to be installed) or obtain them from the
release package.

See INSTALL for a more general explanation of how 'configure' works.

The configure scripts try to check for everything needed, and will also
auto-detect ALSA and JACK adding support automatically; However, this
behaviour can be over-ridden using the following arguments to configure:

 --with-alsa | --with-jack
   Force build to use alsa/jack, build will fail if not found.
 --without-alsa | --without-jack
   Disable alsa/jack support.

Note that the configure scripts plus associated Makefiles are designed
to build the SDL version of MilkyTracker only. Build files for other
targets (OSX, win32, wince) can be found in the 'platforms' directory.


Dependencies
============

To build MilkyTracker you will need the following development libraries:

ALSA (optional)
JACK (optional)
SDL
libz

Note to package maintainers: MilkyTracker contains an internal copy of
libzzip that has been modified for use with MilkyTracker; An externally
linked libzzip will not work correctly (ZIP support will be broken).
