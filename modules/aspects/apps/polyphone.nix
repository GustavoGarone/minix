{
  den.aspects.apps.polyphone = {
    homeManager = {pkgs, ...}: let
      salamander = pkgs.stdenvNoCC.mkDerivation {
        pname = "soundfont-salamander-grand-piano";
        version = "3-20200602";

        src = pkgs.fetchurl {
          url = "https://freepats.zenvoid.org/Piano/SalamanderGrandPiano/SalamanderGrandPiano-SF2-V3%2B20200602.tar.xz";
          hash = "sha256-Fe2wYde6YNWDMvctuo+M5AmIBIzHA/k15jIPN9ZQ4hM=";
        };

        sourceRoot = ".";
        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
          runHook preInstall

          soundfont="$(find . -type f -name '*.sf2')"
          test -f "$soundfont"
          install -Dm444 "$soundfont" "$out/share/soundfonts/SalamanderGrandPiano.sf2"

          runHook postInstall
        '';

        meta = {
          description = "Salamander Grand Piano by Alexander Holm, in SF2 format";
          homepage = "https://freepats.zenvoid.org/Piano/acoustic-grand-piano.html";
          license = pkgs.lib.licenses.cc-by-30;
          platforms = pkgs.lib.platforms.all;
        };
      };
      piano = "${salamander}/share/soundfonts/SalamanderGrandPiano.sf2";
    in {
      home.packages = [
        pkgs.polyphone
        salamander
        pkgs.soundfont-generaluser-gs
      ];

      xdg.dataFile = {
        "soundfonts/SalamanderGrandPiano.sf2".source = piano;
        "soundfonts/GeneralUser-GS.sf2".source = "${pkgs.soundfont-generaluser-gs}/share/soundfonts/GeneralUser-GS.sf2";
      };

      xdg.desktopEntries.polyphone-synth = {
        name = "Polyphone Synth";
        comment = "Play Salamander Grand Piano with a MIDI keyboard";
        exec = "${pkgs.polyphone}/bin/polyphone -s ${piano}";
        icon = "polyphone";
        terminal = false;
        categories = ["AudioVideo" "Audio" "Midi"];
      };
    };
  };
}
