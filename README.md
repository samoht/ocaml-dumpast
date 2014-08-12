### OCaml AST dumper

[![Build Status](https://travis-ci.org/samoht/ocaml-dumpast.svg?branch=master)](https://travis-ci.org/samoht/ocaml-dumpast)

Usage:

```
ocaml-dumpast <pp-tool> <pp-options>* <input>
```

The only feature of that tool is to *not* call `<pp-tool>` if
`<pp-options>` are empty, but use compiler-libs directly.
