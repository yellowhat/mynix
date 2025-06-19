{
  lib,
  buildGoModule,
  fetchFromGitHub,
  which,
  makeWrapper,
  rsync,
  installShellFiles,
  runtimeShell,
  nixosTests,

  components ? [
    "cmd/kubelet"
    # Do not build, as they will run in a container, reduce size 420 > 130 MB
    # "cmd/kube-apiserver"
    # "cmd/kube-controller-manager"
    # "cmd/kube-proxy"
    # "cmd/kube-scheduler"
    # Include kubectl
    "cmd/kubectl"
    "cmd/kubectl-convert"
  ]
}:

buildGoModule rec {
  pname = "kubernetes";
  version = "1.33.2";

  src = fetchFromGitHub {
    owner = "kubernetes";
    repo = "kubernetes";
    rev = "v${version}";
    hash = "sha256-Ef/tpjM5RGQzO8rZxTad23DuM6VLlV3N54LOu7dtc6A=";
  };

  vendorHash = null;

  doCheck = false;

  nativeBuildInputs = [
    makeWrapper
    which
    rsync
    installShellFiles
  ];

  outputs = [
    "out"
    "man"
    "pause"
  ];

  patches = [ ./fixup-addonmanager-lib-path.patch ];

  WHAT = lib.concatStringsSep " " (
    [
      "cmd/kubeadm"
    ]
    ++ components
  );

  buildPhase = ''
    runHook preBuild
    substituteInPlace "hack/update-generated-docs.sh" --replace "make" "make SHELL=${runtimeShell}"
    patchShebangs ./hack ./cluster/addons/addon-manager
    make "SHELL=${runtimeShell}" "WHAT=$WHAT"
    ./hack/update-generated-docs.sh
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    for p in $WHAT; do
      install -D _output/local/go/bin/''${p##*/} -t $out/bin
    done

    cc build/pause/linux/pause.c -o pause
    install -D pause -t $pause/bin

    installManPage docs/man/man1/*.[1-9]

    # Unfortunately, kube-addons-main.sh only looks for the lib file in either the
    # current working dir or in /opt. We have to patch this for now.
    substitute cluster/addons/addon-manager/kube-addons-main.sh $out/bin/kube-addons \
      --subst-var out

    chmod +x $out/bin/kube-addons
    wrapProgram $out/bin/kube-addons --set "KUBECTL_BIN" "$out/bin/kubectl"

    cp cluster/addons/addon-manager/kube-addons.sh $out/bin/kube-addons-lib.sh

    installShellCompletion --cmd kubeadm \
      --bash <($out/bin/kubeadm completion bash) \
      --fish <($out/bin/kubectl completion fish) \
      --zsh <($out/bin/kubeadm completion zsh)

    installShellCompletion --cmd kubectl \
      --bash <($out/bin/kubectl completion bash) \
      --fish <($out/bin/kubectl completion fish) \
      --zsh <($out/bin/kubectl completion zsh)

    runHook postInstall
  '';

  meta = with lib; {
    description = "Production-Grade Container Scheduling and Management";
    license = licenses.asl20;
    homepage = "https://kubernetes.io";
    maintainers = with maintainers; [ ] ++ teams.kubernetes.members;
    platforms = platforms.linux;
  };

  passthru.tests = nixosTests.kubernetes;
}
