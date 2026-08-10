{
  __findFile,
  inputs,
  ...
}: {
  den.aspects.apps.discord = {host, ...}: {
    includes = [(<den/unfree> ["discord"])];

    homeManager = {
      imports = [inputs.nixcord.homeModules.nixcord];

      programs.nixcord = {
        enable = true;
        discord.enable = false;
        vesktop.enable = true;

        config = {
          plugins = {
            alwaysTrust.enable = true;
            anonymiseFileNames.enable = true;
            betterUploadButton.enable = true;
            BlurNSFW.enable = true;
            ClearURLs.enable = true;
            copyEmojiMarkdown.enable = true;
            crashHandler.enable = true;
            fakeNitro.enable = true;
            fixYoutubeEmbeds.enable = true;
            friendInvites.enable = true;
            gifPaste.enable = true;
            mentionAvatars.enable = true;
            messageClickActions.enable = true;
            messageLinkEmbeds.enable = true;
            noF1.enable = true;
            noTypingAnimation.enable = true;
            openInApp.enable = true;
            pictureInPicture.enable = true;
            PinDMs.enable = true;
            typingTweaks.enable = true;
            validReply.enable = true;
            validUser.enable = true;
            voiceDownload.enable = true;
            volumeBooster.enable = true;
            whoReacted.enable = true;
            youtubeAdblock.enable = true;
          };
        };
      };
    };
  };
}
