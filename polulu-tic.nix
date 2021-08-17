{ stdenv, lib, fetchFromGitHub, polulu-usb, pkg-config, cmake, libudev, qt5 }:
qt5.mkDerivation rec {
  pname = "pololu-tic-software";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "pololu";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "1drxy90p6gdqchjbymaggk69prsvhdb6qhizz8k9rkdrl2hzkyqb";
  };

  nativeBuildInputs = [ pkg-config cmake ];

  buildInputs = [ polulu-usb libudev qt5.qtbase ];
}
