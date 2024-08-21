{ callPackage
, lib
, buildGoModule
, stdenv
, fetchurl
, nixos
, testers
}:

buildGoModule rec {
  pname = "my-go";
  version = "1.0.0";
  vendorHash = null;

  meta = with lib; {
    mainProgram = "my-go";
    description = "Go Program";
    homepage = "https://github.com/yellowhat/mynix";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };

  src = ./.;
}
