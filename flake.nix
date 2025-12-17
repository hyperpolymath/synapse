# SPDX-License-Identifier: MIT OR AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2024-2025 hyperpolymath
#
# synapse - Nix Flake (fallback to Guix)
# Usage: nix develop
{
  description = "Synapse - Rust-to-SwiftUI meta-compiler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "synapse-dev";

          buildInputs = with pkgs; [
            # Build tools
            zig
            just

            # Development tools
            git

            # Documentation
            asciidoctor
          ];

          shellHook = ''
            echo "Synapse development environment (Nix fallback)"
            echo "Primary package manager: Guix (guix.scm)"
            echo ""
            echo "Available commands:"
            echo "  zig build        - Build Synapse"
            echo "  zig build test   - Run tests"
            echo "  just gen-ui      - Generate Swift from examples"
            echo "  just validate    - RSR compliance check"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "synapse";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [ zig ];

          buildPhase = ''
            zig build --release=safe
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp zig-out/bin/synapse $out/bin/ 2>/dev/null || true
          '';

          meta = with pkgs.lib; {
            description = "Rust-to-SwiftUI meta-compiler";
            homepage = "https://github.com/hyperpolymath/synapse";
            license = with licenses; [ mit agpl3Plus ];
            maintainers = [ ];
            platforms = platforms.all;
          };
        };
      }
    );
}
