### OCaml AST dumper

[![Build Status](https://travis-ci.org/samoht/ocaml-dumpast.svg?branch=master)](https://travis-ci.org/samoht/ocaml-dumpast)

Usage:

```
ocaml-dumpast [TOOL FLAGS*]? INPUT
```

The only feature of that tool is to *not* call `TOOL` if
`FLAGS` are empty, but use compiler-libs directly.
