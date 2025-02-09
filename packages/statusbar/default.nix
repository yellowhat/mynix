{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "v1.3.5";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-YLLqZjyd1OppyEFqT5o5qtBPB8o+I1wkMEaQDOfhXs4=";
  };

  cargoHash = "sha256-dZFaZkWFXe7tV+09dizJjb8IEdWLcsEWRA3fQtUAlZY=";

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
