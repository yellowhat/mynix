{
  pkgs,
  lib,
  stdenv,
  fetchFromGitLab,
}:

stdenv.mkDerivation rec {
  pname = "sf";
  version = "1.1.0";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-wr63WsNwPG33/eLwtSXLb7YThrOTmIzd6PSEiG9QzxE=";
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
