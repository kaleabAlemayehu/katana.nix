{ config, pkgs, ... }:
{
  programs.i3 = {
    enable = true;
    config = {
      colors = {
        focused = {
          border = "#82AAFF";
          background = "#292D3E";
          text = "#A6ACCD";
          indicator = "#82AAFF";
          childBorder = "#82AAFF";
        };
        focusedInactive = {
          border = "#222436";
          background = "#222436";
          text = "#676E95";
          indicator = "#222436";
          childBorder = "#222436";
        };
        unfocused = {
          border = "#222436";
          background = "#222436";
          text = "#676E95";
          indicator = "#222436";
          childBorder = "#222436";
        };
        urgent = {
          border = "#F07178";
          background = "#F07178";
          text = "#292D3E";
          indicator = "#F07178";
          childBorder = "#F07178";
        };
      };
    };
  };
}
