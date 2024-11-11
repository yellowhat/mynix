{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "v1.3.1";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-uS/g+wz00ZTfStpySnf061qqfUs3UAdWayWbGewAj1E=";
  };

  cargoHash = "sha256-fBSINWAiOjHBfJutU39MquzhBmYvagbQadM7atYR0ww=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    openssl
  ];

  meta = {
    description = "A custom statusbar, written in rust, to be used with swaybar";
    homepage = "https://gitlab.com/yellowhat-labs/statusbar";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
  };
}
