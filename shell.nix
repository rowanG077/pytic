with ((import (fetchTarball {
  name = "nixpkgs-master-2021-04-11";
  url = "https://github.com/nixos/nixpkgs/archive/a73020b2a150322c9832b50baeb0296ba3b13dd7.tar.gz";
  sha256 = "1s0ckc2qscrflr7bssd0s32zddp48dg5jk22w1dip2q2q7ks6cj0";
}) {}));
  let extensions = (with pkgs.vscode-extensions; [
      ms-vsliveshare.vsliveshare
      ms-python.python
      bbenoist.Nix
      redhat.vscode-yaml
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "pyright";
      publisher = "ms-pyright";
      version = "1.1.153";
      sha256 = "0jcrrn7g6pwdhs7jfpyb61wym344p42vz12pcq6k9palrb1q929p";
    }]);

  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

  polulu-usb = pkgs.callPackage ./polulu-usb.nix { };
  polulu-tic = pkgs.callPackage ./polulu-tic.nix {
    polulu-usb = polulu-usb;
  };

  pytic = pkgs.python37Packages.callPackage ./default.nix {
    polulu-tic = polulu-tic;
    polulu-usb = polulu-usb;
  };

in pytic.overrideAttrs (old: {
  buildInputs = old.buildInputs ++ [
    nodePackages.pyright
    vscode-with-extensions
  ];
})
