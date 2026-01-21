{
  virtualisation.docker = {
    enable = true;
  };
  users.users.minze.extraGroups = ["docker"];
}
