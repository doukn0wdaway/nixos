{ config
, pkgs
, ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    terminal = "tmux-256color";
    prefix = "F12";
    escapeTime = 5;
    # extraConfig = ''
    #   unbind C-b
    #    set -g prefix F12
    # '';
  };
}
