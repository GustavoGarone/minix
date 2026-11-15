{inputs, ...}: {
  den.aspects.development.julia = {
    homeManager = {
      pkgs,
      lib,
      ...
    }: let
      # The official upstream binaries, as a normal julia install. They ship
      # their full set of compiler support libraries (libgfortran, libquadmath,
      # libstdc++, ...) laid out as Julia's BinaryBuilder artifacts (JLLs)
      # expect, so packages like Distributions/SpecialFunctions work without
      # any per-library fixes.
      #
      # nixpkgs' source-built `julia` links against Nix's own GCC runtime,
      # which drifts from that layout: e.g. its GCC 14 libgfortran no longer
      # pulls in libquadmath, so OpenSpecFun_jll fails to load.
      julia = pkgs.julia-bin;

      # JETLS (Helix) runs on the cached source-built Julia; only the version
      # has to match for projects to resolve the same way.
      jetlsJulia = (inputs.jetls-nix.lib.packagesFor pkgs).julia;
    in {
      home.packages = [julia];

      warnings = lib.optional (julia.version != jetlsJulia.version) ''
        julia (${julia.version}) differs from the Julia JETLS runs on
        (${jetlsJulia.version}); Helix may resolve projects differently.
      '';
    };
  };
}
