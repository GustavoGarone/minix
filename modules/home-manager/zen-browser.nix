let
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });

  extensions = mkExtensionSettings {
    "addon@darkreader.org" = "darkreader";
    "78272b6fa58f4a1abaac99321d503a20@proton.me" = "proton-pass";
    "uBlock0@raymondhill.net" = "ublock-origin";
    "com.program1519.youtube.removeborder@example.com" = "youtube-remove-border-radius";
    "myallychou@gmail.com" = "youtube-recommended-videos"; # Unhook
    "jobcentertycoon@gmail.com" = "cookie-auto-decline";
  };
in {
  stylix.targets.zen-browser.profileNames = ["minze"];

  programs.zen-browser = {
    enable = true;

    profiles.minze = rec {
      mods = let
        zenMods = {
          betterUnloadedTabs = "f7c71d9a-bce2-420f-ae44-a64bd92975ab";
          floatingStatusBar = "906c6915-5677-48ff-9bfc-096a02a72379";
          cleanedURLBar = "a5f6a231-e3c8-4ce8-8a8e-3e93efd6adec";
          noHighlightSplit = "f50841b2-5e4a-4534-985d-b7f7b96088c2";
        };
      in [
        zenMods.betterUnloadedTabs
        zenMods.cleanedURLBar
        zenMods.floatingStatusBar
        zenMods.noHighlightSplit
      ];

      settings = {
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "browser.tabs.hoverPreview.enabled" = true;

        "zen.urlbar.behavior" = "float";
        "zen.workspaces.separate-essentials" = false;
        "zen.tabs.vertical.right-side" = true;
        "zen.welcome-screen.seen" = true;
      };

      containersForce = true;
      containers = {
        personal = {
          color = "blue";
          icon = "circle";
          id = 1;
        };
        usp = {
          color = "yellow";
          icon = "circle";
          id = 2;
        };
        imejr = {
          color = "toolbar";
          icon = "circle";
          id = 3;
        };
      };

      spacesForce = true;
      spaces = {
        Web = {
          id = "de7d131e-3288-4f6d-be4c-98fe7b93b452";
          position = 1000;
          icon = "🌐";
          container = containers.personal.id;
        };
        Estudo = {
          id = "011f8c91-f813-4167-a19c-549f0ae642e5";
          position = 1001;
          icon = "📖";
          container = containers.usp.id;
        };
        Website = {
          id = "8fd5039b-932a-419f-b285-2a1d4a39ec04";
          position = 1002;
          icon = "⚖️";
          container = containers.personal.id;
        };
        ImeJR = {
          id = "5480623c-f3af-4388-9d89-00b69b03a63c";
          position = 1003;
          icon = "🧊";
          container = containers.imejr.id;
        };
        Drelling = {
          id = "323feae8-6836-4953-a5d0-d9d339dfc315";
          position = 1004;
          icon = "🍧";
          container = containers.personal.id;
        };
      };

      pinsForce = true;
      pins = {
        "WhatsApp" = {
          id = "13f437da-1564-4ba4-99dc-dd96da61c6fc";
          url = "https://web.whatsapp.com/";
          workspace = spaces.Web.id;
          isEssential = true;
          position = 100;
        };
        "GitHub" = {
          id = "e683b800-b46d-411e-9200-cf46369bfc0e";
          url = "https://github.com/GustavoGarone";
          workspace = spaces.Web.id;
          isEssential = true;
          position = 101;
        };
        "Proton" = {
          id = "10cbb0e5-3430-4f3c-b137-ede86c924482";
          workspace = spaces.Web.id;
          isGroup = true;
          isFolderCollapsed = true;
          editedTitle = true;
          position = 201;
        };
        "Proton Pass" = {
          id = "62a365f0-ce35-49b1-a49a-da7463b7ac98";
          url = "https://pass.proton.me/";
          workspace = spaces.Web.id;
          position = 202;
          folderParentId = pins."Proton".id;
        };
        "Proton Mail" = {
          id = "be358c6a-d206-4e5d-b6af-a26edecbc767";
          url = "https://mail.proton.me/";
          workspace = spaces.Web.id;
          position = 203;
          folderParentId = pins."Proton".id;
        };
        "Proton Calendar" = {
          id = "42045310-e4ea-42db-932e-4354c80db62f";
          url = "https://calendar.proton.me/";
          workspace = spaces.Web.id;
          position = 204;
          folderParentId = pins."Proton".id;
        };
        "Gmail" = {
          id = "ae243614-8c89-4794-8ca7-bafa24692679";
          url = "https://mail.google.com/mail/";
          workspace = spaces.Web.id;
          position = 205;
        };
        "Emailusp" = {
          id = "822909a8-c0df-4896-b168-f2eeaf3adb4a";
          url = "https://mail.google.com/mail/";
          workspace = spaces.Estudo.id;
          position = 206;
        };
        "E-Disciplinas" = {
          id = "fad77e17-dd16-4f2e-8e60-926df017a1c9";
          url = "https://edisciplinas.usp.br/";
          workspace = spaces.Estudo.id;
          position = 207;
        };
        "Alexandre Langaro" = {
          id = "df3b3417-42f3-4290-ae2a-f3004f65501b";
          url = "https://alexandrelangaro.com/";
          workspace = spaces.Website.id;
          position = 208;
        };
        "EmailJr" = {
          id = "aff7e87a-d521-4deb-a2d2-1e2b18773610";
          url = "https://mail.google.com/mail/";
          workspace = spaces.ImeJR.id;
          position = 209;
        };
        "imood" = {
          id = "0be7ba2c-d369-4e2f-9442-b3a25d890f69";
          url = "https://www.imood.com/dashboard";
          workspace = spaces.Drelling.id;
          position = 210;
        };
      };
    };

    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      AutofillCreditCartEnabled = false;
      AutofillAddressEnabled = false;
      ExtensionSettings = extensions;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };
}
