(*
 * Copyright (c) 2014 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(* Dump an AST to a file. *)

open Misc
open Format
open Compenv
open Printf

let ppf = Format.err_formatter
let tool_name = "ocaml-astdump"

#if ocaml_version < (4, 2)
module Pparse = struct
  include Pparse
  (* from `ocaml-4.02/driver/pparse.ml' *)
  let parse_all ~tool_name:_ parse_fun magic ppf sourcefile =
    Location.input_name := sourcefile;
    let inputfile = Pparse.preprocess sourcefile in
    let ast =
      try Pparse.file ppf (*~tool_name*) inputfile parse_fun magic
      with exn ->
        Pparse.remove_preprocessed inputfile;
        raise exn
    in
    Pparse.remove_preprocessed inputfile;
    ast
  let parse_implementation ppf ~tool_name sourcefile =
    parse_all Parse.implementation ~tool_name Config.ast_impl_magic_number ppf sourcefile
  let parse_interface ppf ~tool_name sourcefile =
    parse_all Parse.interface ~tool_name Config.ast_intf_magic_number ppf sourcefile
end
#endif

let dump fn magic oc file =
  Compmisc.init_path false;
  let modulename =
    String.capitalize (Filename.basename (chop_extension_if_any file))
  in
  Env.set_unit_name modulename;
  let ast = fn ppf ~tool_name file in
  output_string oc magic;
  output_value oc !Location.input_name;
  output_value oc ast

let interface =
  dump Pparse.parse_interface Config.ast_intf_magic_number

let implementation =
  dump Pparse.parse_implementation Config.ast_impl_magic_number

let dump oc file =
  try
    if Filename.check_suffix file ".ml" then implementation oc file
    else interface oc file
  with x ->
    Errors.report_error ppf x;
    exit 2

let error () =
  eprintf "Usage: ocaml-astdump [TOOL [FLAGS]*]? FILENAME\n";
  exit 1

let () =
  let args = List.tl (Array.to_list Sys.argv) in
  let input, args = match List.rev args with
    | ["-v"]|["--version"] -> printf "0.1\n"; exit 0
    | []   -> error ()
    | h::t -> h, List.rev t
  in
  match args with
  | [] | [_] -> dump stdout input; flush stdout
  | tool::args ->
    let args = tool :: args @ [input] in
    Unix.execvp tool (Array.of_list args)
