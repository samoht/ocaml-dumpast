open Assemblage

let unix = pkg "unix"
let bytecomp = pkg "compiler-libs.bytecomp"

let ocaml_version =
  Scanf.sscanf Sys.ocaml_version "%d.%d" (fun i j -> i,j)

let bin = bin "ocaml-dumpast" ~deps:[bytecomp; unix] (`Units [
    (if ocaml_version < (4,2) then unit "parse_compat" (`Path ["src";"401"])
     else unit "parse_compat" (`Path ["src";"402"]));
    unit "dumpast" (`Path ["src"])
  ])

let t = project "dumpast" [ bin ]

let () = assemble t
