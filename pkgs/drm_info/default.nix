args_@{ lib, fetchFromGitLab, drm_info, scdoc, ... }:

let
  metadata = import ./metadata.nix;
  # remove fetchFromGitLab once nixpkgs uses fetchFromGitLab for drm_info
  ignore = [ "drm_info" "fetchFromGitLab" "scdoc" ];
  args = lib.filterAttrs (n: _v: (!builtins.elem n ignore)) args_;
in
(drm_info.override args).overrideAttrs (old: {
  buildInputs = [ scdoc ] ++ old.buildInputs;
  version = metadata.rev;
  src = fetchFromGitLab {
    inherit (metadata) domain owner repo rev sha256;
  };
})

