;;; my/keybindings/config.el -*- lexical-binding: t; -*-

(map! "C-z" nil
      "M-z" nil
      "C-x C-z" nil

      "M-n" #'forward-paragraph
      "M-p" #'backward-paragraph)

(map! :leader
      (:prefix-map ("f" . "file")
       :desc "Find file in dotfiles" "t" #'find-in-dotfiles
       :desc "Browse dotfiles" "T" #'browse-dotfiles)

      (:prefix-map ("t" . "toggle")
       :desc "Frame transparency" "T" #'toggle-frame-transparency
       :desc "Window maximize" "m" #'doom/window-maximize-buffer
       :desc "Proxy" "p" #'toggle-proxy-http)

      (:prefix-map ("w" . "workspaces/windows")
       "<up>" #'shrink-window
       "<down>" #'enlarge-window
       "<left>" #'shrink-window-horizontally
       "<right>" #'enlarge-window-horizontally))

(map! (:when (featurep! :tools make)
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
       "M-+" #'text-scale-increase
       "M-=" #'text-scale-increase
       "M--" #'text-scale-decrease
       "<s-up>" #'shrink-window
       "<s-down>" #'enlarge-window
       "<s-left>" #'shrink-window-horizontally
       "<s-right>" #'enlarge-window-horizontally))

(add-hook! 'after-init-hook #'windmove-default-keybindings)
