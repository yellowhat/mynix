{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "v1.3.6";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-UeCMgCjMQg82x5Q8AEV1CZbi86A8oeic8BO8GOwq4LU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-qJbRw6WMudmHASSKdR6GHFry8lfYyEusPaf42MbY1DE=";

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
