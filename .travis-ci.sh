OPAM_DEPENDS="ocamlfind optcomp" # For the tests

install_on_linux () {
    # Install OCaml and OPAM PPAs
    case "$OCAML_VERSION,$OPAM_VERSION" in
	4.00.1,1.1.0) ppa=avsm/ocaml40+opam11 ;;
	4.01.0,1.1.0) ppa=avsm/ocaml41+opam11 ;;
	4.02.0,1.1.0) ppa=avsm/ocaml41+opam11 ;;
	*) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
    esac

    echo "yes" | sudo add-apt-repository ppa:$ppa
    sudo apt-get update -qq
    sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam time
}

install_on_linux

echo OCaml version
ocaml -version

export OPAMYES=1
export OPAMVERBOSE=1

opam init git://github.com/ocaml/opam-repository >/dev/null 2>&1

case "$TRAVIS_OS_NAME,$OCAML_VERSION" in
    osx,4.00.1) opam switch 4.00.1 ;;
    *,4.02.0)   opam switch 4.02.0+trunk ;;
esac

opam install ${OPAM_DEPENDS}

eval `opam config env`
make
make install
make distclean
