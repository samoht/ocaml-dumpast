### OCaml AST dumper

Usage:

```
ocaml-dumpast <pp-tool> <pp-options>* <input>
```

The only feature of that tool is to *not* call `<pp-tool>` if
`<pp-options>` are empty, but use compiler-libs directly.
