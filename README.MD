# lxmake

A shell script that, by design, takes a path to your main `*.tex` file and
produces a `*.pdf` out of it. All of the compilation stages, auxiliary files and
other junk is abstracted away. Just `lxmake document.tex` gives you
`document.pdf` (assuming everything went right, of course).

This script is quite opinionated and exists for personal use, but it should
generally work with most XeLaTeX projects.

**Features:**  
- compiles once, twice or three times depending on some "smart" metrics
- correctly handles subfiles (use `lxmake -m subfile.tex` to compile the entire
  document that a subfile belongs to, instead of the default which is to compile
  only that subfile)
- reports progress on command-line, or through `notify-send` and `mako` if
  running in non-interactive mode (this is useful e.g. if you bind `lxmake` in
  your text editor)
