{ lib
, buildPythonPackage
, python
, flake8
, autopep8
, pylint
, pyyaml
, polulu-usb
, polulu-tic
}:

let
in buildPythonPackage rec {
  pname = "pytic";
  version = "0.4.1";

  src = ./.;

  doCheck = false;

  buildInputs = [
    python
    flake8
    autopep8
    pylint
    pyyaml
    polulu-usb
    polulu-tic
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${lib.makeLibraryPath ["${polulu-usb}" "${polulu-tic}"]}
  '';
}
