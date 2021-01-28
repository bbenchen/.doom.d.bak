;;; my/tools/config.el -*- lexical-binding: t; -*-

;; lookup
(if (and IS-MAC
         (featurep 'xwidget-internal))
    (setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn))

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
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
                                           "GOPROXY"))
    ;; (setq exec-path-from-shell-debug t)
    (exec-path-from-shell-initialize)))

(use-package! command-log-mode
  :commands global-command-log-mode
  :config
  (setq command-log-mode-auto-show t))

(use-package! eaf
  :when IS-LINUX
  :defer 2
  :custom
  (eaf-config-location (expand-file-name "eaf/" doom-etc-dir))
  (eaf-wm-focus-fix-wms '("i3" "bspwm" "LG3D"))
  (eaf-find-alternate-file-in-dired t)
  (eaf-proxy-type "http")
  (eaf-proxy-host "127.0.0.1")
  (eaf-proxy-port "8889")
  (browse-url-browser-function #'eaf-open-browser)
  :config
  (if-let ((bookmarks (file-exists-p! (and (or "chromium/Default/Bookmarks"
                                               "google-chrome/Default/Bookmarks"))
                                      "~/.config")))
      (setq eaf-chrome-bookmark-file bookmarks))

  (if-let ((history (file-exists-p! (and (or "chromium/Default/History"
                                             "google-chrome/Default/History"))
                                    "~/.config")))
      (eaf-setq eaf-browser-chrome-history-file history))

  ;; (defalias 'browse-web #'eaf-open-browser)
  (eaf-setq eaf-browser-aria2-proxy-host "127.0.0.1")
  (eaf-setq eaf-browser-aria2-proxy-port "8889")
  ;; (eaf-setq eaf-browser-dark-mode "false")
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-setq eaf-terminal-font-size "11")
  (eaf-setq eaf-terminal-font-family "Sarasa Mono SC Nerd")
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (unbind-key "C-c i" eaf-mode-map*)

  (require 'eaf-org)
  (defun eaf-org-open-file (file &rest _)
    "An wrapper function on `eaf-open'."
    (eaf-open file))

  ;; use `emacs-application-framework' to open PDF file: link
  (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file)))
