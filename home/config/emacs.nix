{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      evil
      magit
      helm
      doom-modeline
      doom-themes
      neotree
      all-the-icons
    ];
  };

  home.file.".emacs".text = ''
    (require 'evil)
    (require 'magit)
    (require 'helm)
    (require 'doom-modeline)
    (require 'doom-themes)
    (require 'neotree)
    (require 'all-the-icons)

    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (tooltip-mode -1)

    (evil-mode t)

    (when (version<= "26.0.50" emacs-version )
      (global-display-line-numbers-mode))

    (doom-modeline-mode 1)

    (setq doom-modeline-height 25)
    (setq doom-modeline-bar-width 3)
    (setq doom-modeline-window-width-limit fill-column)
    (setq doom-modeline-buffer-file-name-style 'auto)
    (setq doom-modeline-icon (display-graphic-p))
    (setq doom-modeline-major-mode-icon t)
    (setq doom-modeline-major-mode-color-icon t)
    (setq doom-modeline-buffer-state-icon t)
    (setq doom-modeline-buffer-modification-icon t)
    (setq doom-modeline-unicode-fallback t)
    (setq doom-modeline-minor-modes t)
    (setq doom-modeline-buffer-encoding t)
    (setq doom-modeline-indent-info nil)
    (setq doom-modeline-vcs-max-length 12)
    (setq doom-modeline-workspace-name t)
    (setq doom-modeline-persp-name t)
    (setq doom-modeline-persp-icon t)
    (setq doom-modeline-lsp t)
    (setq doom-modeline-modal-icon t)
    (setq doom-modeline-env-version t)
    (setq doom-modeline-env-rust-executable "rustc")
    (setq doom-modeline-env-load-string "...")

    (setq doom-themes-enable-bold t
          doom-themes-enable-italic t)
    (load-theme 'doom-vibrant t)

    (global-set-key [f8] 'neotree-toggle)
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (setq neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$" "\\.agdai$"))
    (setq neo-smart-open t)
    (setq neo-window-fixed-size nil)
    (setq neo-window-width 50)
    (doom-themes-neotree-config)

    (setq split-width-threshold 0)
    (setq split-height-threshold nil)

    (setq inhibit-startup-screen t)
    (setq initial-scratch-message nil)
    (setq sentence-end-double-space nil)
    (setq ring-bell-function 'ignore)
    (setq use-dialog-box nil)
    (setq mark-even-if-inactive nil)
    (setq kill-whole-line t)
    (setq case-fold-search nil)

    (set-charset-priority 'unicode)
    (setq locale-coding-system 'utf-8)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (set-selection-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)
    (setq default-process-coding-system '(utf-8-unix . utf-8-unix))

    (delete-selection-mode t)
    (column-number-mode)

    (require 'hl-line)
    (add-hook 'prog-mode-hook #'hl-line-mode)
    (add-hook 'text-mode-hook #'hl-line-mode)
    (set-face-attribute 'hl-line nil :background "gray21")

    (setq make-backup-files nil)
    (setq auto-save-default nil)
    (setq create-lockfiles nil)

    (global-unset-key (kbd "C-x C-f"))
    (global-unset-key (kbd "C-x C-d"))
    (global-unset-key (kbd "C-z"))
    (global-unset-key (kbd "M-o"))
    (global-unset-key (kbd "<mouse-2>"))
    (global-unset-key (kbd "<C-wheel-down>"))

    (add-hook 'before-save-hook #'delete-trailing-whitespace)
    (setq require-final-newline t)

    (show-paren-mode)

    (load-file (let ((coding-system-for-read 'utf-8))
                    (shell-command-to-string "agda-mode locate")))
  '';
}
