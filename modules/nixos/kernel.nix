{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernel.sysctl = {
      "vm.swappiness" = 90;
      # BBR congestion control
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
  };
}
