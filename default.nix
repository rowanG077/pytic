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

buildPythonPackage rec {
  pname = "pytic";
  version = "0.4.1";

  src = ./.;

  doCheck = false;

  buildInputs = [
    python
    polulu-usb
    polulu-tic
  ];

  propagatedBuildInputs = [
    pyyaml
  ];

  # Fix the backend library lookup
  postPatch =
    ''
      usb=${polulu-usb.out}/lib/libusbp-1.so
      tic=${polulu-tic.out}/lib/libpololu-tic-1.so
      sed -i -e "s|cdll.LoadLibrary(\"libusbp-1.so\")|cdll.LoadLibrary(\"$usb\")|" pytic/pytic.py
      sed -i -e "s|cdll.LoadLibrary(\"libpololu-tic-1.so\")|cdll.LoadLibrary(\"$tic\")|" pytic/pytic.py
    '';
}
