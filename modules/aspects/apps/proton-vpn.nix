{
  den.aspects.apps.proton-vpn = {
    nixos = {pkgs, ...}: {
      networking.networkmanager.enable = true;
      networking.firewall.checkReversePath = "loose";
      environment.systemPackages = with pkgs; [
        wireguard-tools
        proton-vpn
      ];
    };
  };
}
