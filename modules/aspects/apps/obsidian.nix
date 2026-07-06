{__findFile, ...}: {
  den.aspects.apps.obsidian = {
    includes = [
      (<den/unfree> ["obsidian"])
    ];

    homeManager = {
      programs.obsidian = {
        enable = true;
        vaults."obsidian/personal".enable = true;
        defaultSettings = {
          app = {
            zoomLevel = 120;
            showRibbon = false;
          };

          corePlugins = [
            "file-explorer"
            "global-search"
            "switcher"
            "graph"
            "backlink"
            "canvas"
            "outgoing-link"
            "tag-pane"
            "properties"
            "page-preview"
            "daily-notes"
            "templates"
            "note-composer"
            "command-palette"
            "editor-status"
            "bookmarks"
            "outline"
            "word-count"
            "file-recovery"
            "bases"
            "webviewer"
            {
              name = "templates";
              settings = {
                folder = "templates";
              };
            }
          ];
        };
      };
    };
  };
}
