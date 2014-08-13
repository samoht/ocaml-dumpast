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
    parse_all Parse.implementation ~tool_name Config.ast_impl_magic_number ppf
      sourcefile
  let parse_interface ppf ~tool_name sourcefile =
    parse_all Parse.interface ~tool_name Config.ast_intf_magic_number ppf sourcefile
