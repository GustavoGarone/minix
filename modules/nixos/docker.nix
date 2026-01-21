{
  virtualisation.docker = {
    enable = true;
  };
  users.users.storce.extraGroups = ["docker"];
}
