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
       :desc "Window maximize" "m" #'doom/window-maximize-buffer)

      (:prefix-map ("w" . "workspaces/windows")
       "<up>" #'shrink-window
       "<down>" #'enlarge-window
       "<left>" #'shrink-window-horizontally
       "<right>" #'enlarge-window-horizontally))

(map! (:when (featurep! :tools make)
        (:map makefile-mode-map
          :localleader
          :desc "Run task" "r" #'+make/run)))

(map! (:when (featurep! :checkers spell)
        :map flyspell-mode-map
        "s-;" #'flyspell-correct-wrapper))

(map! (:when IS-LINUX
        "s-w" #'+delete-window
        "s-W" #'delete-frame
        "s-n" #'+default/new-buffer
        "s-k" #'doom/kill-this-buffer-in-all-windows
        "s-s" #'save-buffer
        "s-a" #'mark-whole-buffer
        "s-f" #'swiper
        "s-u" #'revert-buffer
        "s-z" #'undo
        "s-/" (λ! (save-excursion (comment-line 1)))))

(map! (:when IS-MAC
        "<s-up>" #'shrink-window
        "<s-down>" #'enlarge-window
        "<s-left>" #'shrink-window-horizontally
        "<s-right>" #'enlarge-window-horizontally))
