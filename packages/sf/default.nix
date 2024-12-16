{
  pkgs,
  lib,
  stdenv,
  fetchFromGitLab,
}:

stdenv.mkDerivation rec {
  pname = "sf";
  version = "v1.0.1";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-xaw/qT1wN1p97KgmVK+xYVF7aOwByuED2dcQrRFCLBA=";
  };

  buildInputs = [ pkgs.python3 ];

  installPhase = ''
    mkdir -p $out/bin
    cp sf.py $out/bin/sf
    chmod +x $out/bin/sf
  '';

  meta = {
    description = "A simple console file manager written in python";
    homepage = "https://gitlab.com/yellowhat-labs/sf";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "sf";
  };
}
