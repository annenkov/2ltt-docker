# A docker image for 2LTT development
A docker image for the two-level type theory formalisation in Lean: https://github.com/annenkov/two-level

Steps to build
==============

* Clone this repo.
* Install `docker`.
* In the terminal, go to the directory you cloned this repo and run (notice `.` at the end) `docker build -t lean-image .`
* After building step is complete (this might take some time), run `docker run -it lean-image` to connect your current terminal session to the container.
* In the container, type `emacs ~/two-level/fibrantlimits.lean` to start editing `fibrantlimits.lean` with the lean-mode in Emacs.
