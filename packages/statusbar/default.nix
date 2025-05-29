{
  lib,
  fetchFromGitLab,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "statusbar";
  version = "v1.3.7";

  src = fetchFromGitLab {
    owner = "yellowhat-labs";
    repo = pname;
    rev = version;
    hash = "sha256-mKgzPVkF3sYLkg0VggDFsKqIVl9xOutYarI5pWLB0zo=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-fuVDbGecUAj4Jmh7kHCjRkVBhLDAMD00o2Lmdbuj5zc=";

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
