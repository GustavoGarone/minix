{
  den.aspects.services.sunshine = {
    nixos = {
      services.sunshine = {
        enable = true;
        autoStart = true;
        # Needed for KMS/DRM screen capture.
        capSysAdmin = true;
        # Opens TCP 47984/47989/47990/48010 and UDP 47998-48000/48002/48010.
        openFirewall = true;
      };
    };
  };
}
