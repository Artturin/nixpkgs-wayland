args_@{ lib, fetchFromGitLab, wlroots, libdrm, ... }:

let
  metadata = import ./metadata.nix;
  ignore = [ "wlroots" "libdrm" ];
  args = lib.filterAttrs (n: v: (!builtins.elem n ignore)) args_;
in
(wlroots.override args).overrideAttrs(old: {
  buildInputs = [ libdrm ] ++ old.buildInputs;
  version = "${metadata.rev}";
  src = fetchFromGitLab {
    inherit (metadata) domain owner repo rev sha256;
  };
})
