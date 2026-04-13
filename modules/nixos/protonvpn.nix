{pkgs, ...}: {
  networking.firewall.checkReversePath = "loose";
  environment.systemPackages = with pkgs; [wireguard-tools protonvpn-gui];
}
