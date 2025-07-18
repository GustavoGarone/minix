{inputs, ...}: {
  programs.zen-browser.enable = true;
  xdg.mimeApps = {
    defaultApplications = {
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
      "text/html" = "zen-beta.desktop";
      "application/pdf" = "zen-beta.desktop";
      "image/png" = "zen-beta.desktop";
    };
  };
}
