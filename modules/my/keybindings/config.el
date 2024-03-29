;;; my/keybindings/config.el -*- lexical-binding: t; -*-

(map! "C-z" nil
      "M-z" nil
      "C-x C-z" nil

      "M-n" #'forward-paragraph
      "M-p" #'backward-paragraph

      "C-s" #'phi-search
      "s-F" #'phi-search
      "C-r" #'phi-search-backward
      "s-d" #'phi-search-backward
      "M-%" #'phi-replace)

(map! :leader
      (:prefix-map ("f" . "file")
       :desc "Find file in dotfiles" "t" #'find-in-dotfiles
       :desc "Browse dotfiles" "T" #'browse-dotfiles)

      (:prefix-map ("t" . "toggle")
       :desc "Command window" "C" #'toggle-command-window
       :desc "Frame transparency" "T" #'toggle-frame-transparency
       :desc "Window maximize" "m" #'doom/window-maximize-buffer
       :desc "Proxy" "p" #'toggle-proxy-http)

      (:prefix-map ("w" . "workspaces/windows")
       "<up>" #'shrink-window
       "<down>" #'enlarge-window
       "<left>" #'shrink-window-horizontally
       "<right>" #'enlarge-window-horizontally)

      (:when (and (modulep! :tools magit)
                  (modulep! :my magit))
       (:prefix-map ("v" . "versioning")
        :desc "Blamer show commit" "b" #'blamer-show-posframe-commit-info
        :desc "Blamer" "B" #'blamer-mode)))

(map! (:when (modulep! :tools make)
       (:map makefile-mode-map
        :localleader
        :desc "Run task" "r" #'+make/run)))

(map! (:map vterm-mode-map
       "C-\\" #'toggle-input-method))

(map! (:when IS-MAC
       "s-x" #'kill-region
       "s-+" #'text-scale-increase
       "s-=" #'text-scale-increase
       "s--" #'text-scale-decrease
       "<s-up>" #'shrink-window
       "<s-down>" #'enlarge-window
       "<s-left>" #'shrink-window-horizontally
       "<s-right>" #'enlarge-window-horizontally))

(add-hook! 'after-init-hook #'windmove-default-keybindings)
