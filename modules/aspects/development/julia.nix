{inputs, ...}: {
  den.aspects.development.julia = {
    homeManager = {pkgs, ...}: {
      # The exact Julia JETLS (Helix) runs on: nixpkgs' julia-bin, the official
      # upstream binaries, as a normal julia install. They ship their full set
      # of compiler support libraries (libgfortran, libquadmath, libstdc++, ...)
      # laid out as Julia's BinaryBuilder artifacts (JLLs) expect, so packages
      # like Distributions/SpecialFunctions work without per-library fixes.
      # nixpkgs' source-built `julia` doesn't: its GCC 14 libgfortran no longer
      # pulls in libquadmath, so OpenSpecFun_jll fails to load.
      #
      # Sharing one build with JETLS also shares ~/.julia/compiled: package
      # caches are keyed by the exact Julia build, so packages compile once.
      home.packages = [(inputs.jetls-nix.lib.packagesFor pkgs).julia];
    };
  };
}
