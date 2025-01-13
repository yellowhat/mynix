{
  pkgs,
  lib,
  stdenv,
  fetchFromGitLab,
}:

stdenv.mkDerivation rec {
  pname = "sf";
  version = "v1.0.2";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-whdbS3eoDH/2/ZoytlC6MK5lc7zozM17wKGsDTkGHxo=";
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
