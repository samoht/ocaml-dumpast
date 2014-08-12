open Assemblage

let unix = pkg "unix"
let bytecomp = pkg "compiler-libs.bytecomp"
let optcomp = pkg_pp "optcomp"

let bin = bin "ocaml-dumpast" (`Units [
    unit ~deps:[unix;optcomp;bytecomp] "dumpast" (`Dir "src")
  ])

let t = project "dumpast" [ bin ]

let () = assemble t
