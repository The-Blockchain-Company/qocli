{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:tbco/flake-utils";
    rust-nix.url = "github:The-Blockchain-Company/rust.nix/work";
    rust-nix.inputs.nixpkgs.follows = "nixpkgs";
    tbco-nix = {
      url = "github:The-Blockchain-Company/tbco-nix";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, utils, rust-nix, tbco-nix }:
    utils.lib.simpleFlake {
      inherit nixpkgs;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      preOverlays = [ rust-nix (tbco-nix + /overlays/crypto) ];
      overlay = final: prev:
        let lib = prev.lib;
        in {
          fakeGit = final.writeShellScriptBin "git" "true";
          qocli = final.rust-nix.buildPackage {
            inherit ((builtins.fromTOML
              (builtins.readFile ./Cargo.toml)).package)
              name version;
            root = ./.;
            nativeBuildInputs = with final; [
              pkg-config
              protobuf
              rustfmt
              fakeGit
              m4
              autoconf
              automake
            ];

            cargoBuildOptions = x: x ++ [ "--features" "libsodium-sys" ];
            buildInputs = with final; [ openssl libsodium ];

            PROTOC = "${final.protobuf}/bin/protoc";
            PROTOC_INCLUDE = "${final.protobuf}/include";
          };
        };
      packages = { qocli }@pkgs: pkgs;
      devShell = { mkShell, rustc, cargo, pkg-config, openssl, protobuf }:
        mkShell {
          PROTOC = "${protobuf}/bin/protoc";
          PROTOC_INCLUDE = "${protobuf}/include";
          buildInputs = [ rustc cargo pkg-config openssl protobuf ];
        };
    };
}
