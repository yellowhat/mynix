{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "1.3.8";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-sxf45yiy7eQRW9TS7/7wf32t+ClEcfcj7gpuTbXl9Hg=";
  };

  cargoHash = "sha256-BACU1xoCj9dY0syThruGhvXupEQP/xyoCqLX77VHR1w=";

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
