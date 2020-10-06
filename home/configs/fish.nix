{ config, pkgs, ...}:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set -x COLORTERM truecolor
      set -x TERM xterm-256color

      function fish_prompt --description 'Write out the prompt'
        set SSH_PROMPT ""
        if [ -n "$SSH_CLIENT" ]
          set SSH_PROMPT " "(set_color -o white --bold)(whoami)(set_color -o normal)"@"(set_color -o green)(hostname)(set_color -o normal)
        end
        echo -n -s "$SSH_PROMPT$status_message " (set_color -o purple) (prompt_pwd) (set_color normal) " " (set_color -o blue) "❯" (set_color -o green) "❯" (set_color -o yellow) "❯" (set_color -o red) "❯ " (set_color normal)
      end
    '';
  };
}
