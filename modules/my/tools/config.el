;;; my/tools/config.el -*- lexical-binding: t; -*-

;; lookup
(when (and IS-MAC
           (featurep 'xwidget-internal))
  (setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn
        browse-url-browser-function #'xwidget-webkit-browse-url)
  (if (boundp 'xwidget-webkit-enable-plugins)
      (setq xwidget-webkit-enable-plugins t)))

;; vterm
(after! vterm
  (setq vterm-disable-underline t))

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :when IS-MAC
  :init
  (setq exec-path-from-shell-warn-duration-millis 2000)
  (setq exec-path-from-shell-arguments '("-l"))
  (setq exec-path-from-shell-variables '("LANG"
                                         "LC_ALL"
                                         "TERM"
                                         "PATH"
                                         "MANPATH"
                                         "JAVA_HOME"
                                         "JAVA_OPTS"
                                         "SBT_OPTS"
                                         "GOPATH"
                                         "GOBIN"
                                         "GO111MODULE"
                                         "GOPROXY"
                                         "LSP_USE_PLISTS"))
  ;; (setq exec-path-from-shell-debug t)
  (exec-path-from-shell-initialize))

(use-package! command-log-mode
  :commands global-command-log-mode
  :init
  (setq command-log-mode-auto-show nil)

  (defvar command-window-frame nil)

  (defun toggle-command-window ()
    "Show or hide the command window"
    (interactive)
    (if (posframe-workable-p)
        (progn
          (if command-window-frame
              (progn
                (global-command-log-mode -1)
                (posframe-delete-frame clm/command-log-buffer)
                (setq command-window-frame nil))
            (progn
              (global-command-log-mode 1)
              (with-current-buffer
                  (setq clm/command-log-buffer
                        (get-buffer-create " *command-log*"))
                (text-scale-set -0.5))
              (setq command-window-frame
                    (posframe-show
                     clm/command-log-buffer
                     :position `(,(- (x-display-pixel-width) 420) . 0)
                     :width 55
                     :height 5
                     :min-width 55
                     :min-height 5
                     :internal-border-width 10
                     :background-color (face-background 'mode-line)
                     :foreground-color (face-foreground 'mode-line)
                     :override-parameters '((parent-frame . nil)))))))
      (progn
        (if (not command-log-mode-auto-show)
            (setq command-log-mode-auto-show t))
        (if (bound-and-true-p global-command-log-mode)
            (global-command-log-mode -1)
          (global-command-log-mode 1))))))

(use-package! pinentry
  :defer t
  :init
  (pinentry-start)
  :config
  (add-hook! 'kill-emacs-hook #'pinentry-stop))

(use-package! eaf
  :load-path (lambda () (list (expand-file-name "site-lisp/eaf" doom-private-dir)))
  :when IS-LINUX
  :defer 2
  :custom
  (eaf-config-location (expand-file-name "eaf/" doom-etc-dir))
  (eaf-wm-focus-fix-wms '("i3" "bspwm" "dwm" "LG3D" "Xpra" "EXWM" "Xfwm4"))
  (eaf-proxy-type "http")
  (eaf-proxy-host "127.0.0.1")
  (eaf-proxy-port "7890")
  :config
  (require 'eaf-all-the-icons nil t)
  (require 'eaf-image-viewer nil t)
  (require 'eaf-pdf-viewer nil t)
  (require 'eaf-browser nil t)
  (require 'eaf-markdown-previewer nil t)
  (require 'eaf-file-manager nil t)
  (require 'eaf-org-previewer nil t)

  (setq +lookup-open-url-fn #'eaf-open-browser
        browse-url-browser-function #'eaf-open-browser
        eaf-browser-enable-adblocker t
        eaf-browser-aria2-proxy-host "127.0.0.1"
        eaf-browser-aria2-proxy-port "7890"
        eaf-file-manager-show-icon nil)

  (if-let ((bookmarks (cond (IS-MAC "~/Library/Application Support/Google/Chrome/Default/Bookmarks")
                            (IS-LINUX (file-exists-p! (and (or "chromium/Default/Bookmarks"
                                                               "google-chrome/Default/Bookmarks"))
                                                      "~/.config"))
                            (t nil))))
      (setq eaf-chrome-bookmark-file bookmarks))

  (if-let ((history (cond (IS-MAC "~/Library/Application Support/Google/Chrome/Default/History")
                          (IS-LINUX (file-exists-p! (and (or "chromium/Default/History"
                                                             "google-chrome/Default/History"))
                                                    "~/.config"))
                          (t nil))))
      (setq eaf-browser-chrome-history-file history))

  (unbind-key "C-c i" eaf-mode-map*)

  (after! mu4e
    (require 'eaf-mail))

  (after! org
    (require 'eaf-org)
    (defun eaf-org-open-file (file &rest _)
      "An wrapper function on `eaf-open'."
      (eaf-open file))

    ;; use `emacs-application-framework' to open PDF file: link
    (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file))))
