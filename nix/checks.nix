# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022 Unikie

{ config ? import ../nix/eval-config.nix {} }:

{
  recurseForDerivations = true;

  shellcheck = config.pkgs.callPackage (
    { lib, runCommand, shellcheck }:
    runCommand "spectrum-shellcheck" {
      src = lib.cleanSourceWith {
        filter = path: type:
          type == "directory" || builtins.match ''.*[^/]\.sh'' path != null;
        src = lib.cleanSource ../.;
      };

      nativeBuildInputs = [ shellcheck ];
    } ''
      shellcheck $src/**/*.sh
      touch $out
    ''
  ) {};
}
