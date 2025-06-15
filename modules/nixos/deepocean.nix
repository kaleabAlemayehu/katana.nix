{ config, pkgs, ... }:
{
  programs.i3 = {
    enable = true;
    config = {
      colors = {
        focused = {
          border = "#82AAFF";
          background = "#263238";
          text = "#CDD3DE";
          indicator = "#82AAFF";
          childBorder = "#82AAFF";
        };
        focusedInactive = {
          border = "#1A2327";
          background = "#1A2327";
          text = "#546E7A";
          indicator = "#1A2327";
          childBorder = "#1A2327";
        };
        unfocused = {
          border = "#1A2327";
          background = "#1A2327";
          text = "#546E7A";
          indicator = "#1A2327";
          childBorder = "#1A2327";
        };
        urgent = {
          border = "#F07178";
          background = "#F07178";
          text = "#263238";
          indicator = "#F07178";
          childBorder = "#F07178";
        };
      };
    };
  };
}
