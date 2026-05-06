{
  # Enable the OpenSSH daemon.
  services.openssh = {
    ports = [22];
    openFirewall = true;
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
  services.openssh.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
