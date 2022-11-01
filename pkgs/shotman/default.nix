{ stdenv
, lib
, fetchFromSourcehut
, rustPlatform
, pkg-config
, libxkbcommon
}:

let
  metadata = import ./metadata.nix;
in
rustPlatform.buildRustPackage rec {
  pname = "shotman";
  version = metadata.rev;

  src = fetchFromSourcehut {
    inherit (metadata) owner repo rev sha256;
  };

  inherit (metadata) cargoSha256;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libxkbcommon
  ];

  meta = with lib; {
    description = "Uncompromising screenshot GUI for Wayland";
    homepage = "https://git.sr.ht/~whynothugo/shotman";
  };
}