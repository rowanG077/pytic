{ stdenv, lib, fetchFromGitHub, pkg-config, cmake, qt5 }:
qt5.mkDerivation rec {
  pname = "libusbp";
  version = "v1-latest";

  src = fetchFromGitHub {
    owner = "pololu";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "1mi3d612lf9zbhpib5h92vz6h340q2ic5g6xpi4xrnww2xingcv2";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  
  buildInputs = [ qt5.qtbase ];
}
