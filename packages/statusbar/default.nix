{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "1.3.9";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ppCqK5loy2vtKsH+LNgq+rOVSvgOOD4d2hGgcQZKLA0=";
  };

  cargoHash = "sha256-6ESgzlMj3eYsnqwqix6iBpSd+52/giR/DLjhY1ayzaU=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    openssl
  ];

  checkFlags = [
    # Not sure why but in GitHub CI does not work
    "--skip=network::network_test::test_get_ip"
  ];

  meta = {
    description = "A custom statusbar, written in rust, to be used with swaybar";
    homepage = "https://gitlab.com/yellowhat-labs/statusbar";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
  };
}
