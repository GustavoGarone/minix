{lib, ...}: {
  den.aspects.development.git = {host}: {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [git];
    };

    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.git-credential-manager
        pkgs.delta
      ];

      programs.gh = {
        enable = true;
      };

      programs.git = {
        enable = true;
        settings = {
          user =
            {
              name = "Gustavo Garone";
              email = "gustavogarone@protonmail.com";
            }
            // lib.optionalAttrs (host.gitSigningKey != null) {
              signingKey = host.gitSigningKey;
            };

          core = {
            compression = 9;
            whitespace = "error";
            preloadindex = true;
            pager = "delta";
          };

          status = {
            branch = true;
            showStash = true;
            showUntrackedFiles = "all";
          };

          commit = {
            gpgSign = host.gitSigningKey != null;
            verbose = true;
          };

          log = {
            abbrevCommit = true;
            graphColors = "blue,yellow,cyan,magenta,green,red";
          };

          pager = {
            branch = false;
            tag = false;
            blame = "delta";
          };

          interactive = {
            singlekey = true;
            diffFilter = "delta --color-only";
          };

          delta = {
            navigate = true;
            side-by-side = true;
            line-numbers = true;
            hyperlinks = true;
          };

          merge = {
            conflictStyle = "zdiff3";
          };

          credential = {
            helper = "manager";
            credentialStore = "gpg";
          };

          url."ssh://git@github.com/GustavoGarone/".insteadOf = "me:";
          url."ssh://git@github.com/".insteadOf = "gh:";
          url."ssh://git@codeberg.org/".insteadOf = "cb:";

          push.autoSetupRemote = true;
          branch.sort = "-committerdate";
          tag.sort = "-taggerdate";
          init.defaultBranch = "dev";

          color = {
            branch = {
              current = "magenta";
              local = "default";
              remote = "yellow";
              upstream = "green";
              plain = "blue";
            };
            decorate = {
              HEAD = "red";
              branch = "blue";
              tag = "yellow";
              remoteBranch = "magenta";
            };
          };
        };
      };
      home.shellAliases = {
        gs = "git status --short";
        gc = "git commit";
        gl = "git log --graph --all --pretty=format:\"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n\"";
        "gc!" = "git commit --amend";
        "gc!!" = "git commit --amend --no-edit";
        gp = "git push";
        "gp!" = "git push --force";
      };
    };
  };
}
