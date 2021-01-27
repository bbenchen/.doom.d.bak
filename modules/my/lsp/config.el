;;; my/lsp/config.el -*- lexical-binding: t; -*-

(if (featurep! :editor snippets)
    (setq +lsp-company-backends '(company-capf :with company-yasnippet)))

;; lsp
(after! lsp-mode
  (setq lsp-enable-snippet nil
        lsp-enable-folding nil
        lsp-enable-links nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-file-watchers nil
        lsp-file-watch-threshold 5000
        lsp-eldoc-enable-hover nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-signature-auto-activate nil
        lsp-headerline-breadcrumb-enable nil)

  ;; don't scan 3rd party javascript libraries
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored-directories) ;; json

  ;; kotlin
  (setq lsp-clients-kotlin-server-executable (concat lsp-server-install-dir "kotlin/server/bin/kotlin-language-server")
        lsp-kotlin-debug-adapter-path (concat lsp-server-install-dir "kotlin/adapter/bin/kotlin-debug-adapter")))

(after! lsp-ui
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-ignore-duplicate t)

  (defun +lsp-ui-util-line-number-display-width ()
    "Safe way to get value from function `line-number-display-width'."
    (if (bound-and-true-p display-line-numbers-mode)
        ;; For some reason, function `line-number-display-width' gave
        ;; us error `args-out-of-range' even we do not pass anything towards
        ;; to it function. See the following links,
        ;;
        ;; - https://github.com/emacs-lsp/lsp-ui/issues/294
        ;; - https://github.com/emacs-lsp/lsp-ui/issues/533 (duplicate)
        (+ (or (ignore-errors (line-number-display-width)) 0) 2)
      0))

  (defadvice! lsp-ui-sideline--margin-width-a ()
    :override #'lsp-ui-sideline--margin-width
    (+ (if fringes-outside-margins right-margin-width 0)
       (or (and (boundp 'fringe-mode)
                (consp fringe-mode)
                (or (equal (car fringe-mode) 0)
                    (equal (cdr fringe-mode) 0))
                1)
           (and (boundp 'fringe-mode) (equal fringe-mode 0) 1)
           0)
       (let ((win-fringes (window-fringes)))
         (if (or (equal (car win-fringes) 0)
                 (equal (cadr win-fringes) 0))
             2
           0))
       (if (< emacs-major-version 27)
           ;; This was necessary with emacs < 27, recent versions take
           ;; into account the display-line width with :align-to
           (+lsp-ui-util-line-number-display-width)
         0)
       (if (or
            (bound-and-true-p whitespace-mode)
            (bound-and-true-p global-whitespace-mode))
           1
         0)))

  (defadvice! lsp-ui-sideline--window-width-a ()
    :override #'lsp-ui-sideline--window-width
    (- (min (window-text-width) (window-body-width))
       (lsp-ui-sideline--margin-width)
       (or (and (>= emacs-major-version 27)
                ;; We still need this number when calculating available space
                ;; even with emacs >= 27
                (+lsp-ui-util-line-number-display-width))
           0))))

(use-package! lsp-treemacs
  :after lsp-mode
  :bind (:map lsp-mode-map
         ("C-<f8>" . #'lsp-treemacs-java-deps-list)
         ("M-<f8>" . #'lsp-treemacs-symbols))
  :init (lsp-treemacs-sync-mode 1)
  :config
  (with-eval-after-load 'ace-window
    (when (boundp 'aw-ignored-buffers)
      (push 'lsp-treemacs-symbols-mode aw-ignored-buffers)
      (push 'lsp-treemacs-java-deps-mode aw-ignored-buffers)))

  (after! treemacs
    (when (require 'all-the-icons nil t)
      (treemacs-create-theme "lsp-colors"
        :extends "doom-colors"
        :config
        (progn
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "repo" :height 1.0 :v-adjust -0.1 :face 'all-the-icons-blue))
           :extensions (root))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
           :extensions (boolean-data))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "settings_input_component" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-orange))
           :extensions (class))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "palette" :height 0.95 :v-adjust -0.15))
           :extensions (color-palette))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "square-o" :height 0.95 :v-adjust -0.15))
           :extensions (constant))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "file-text-o" :height 0.95 :v-adjust -0.05))
           :extensions (document))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "storage" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-orange))
           :extensions (enumerator))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "format_align_right" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
           :extensions (enumitem))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "bolt" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-orange))
           :extensions (event))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
           :extensions (field))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "search" :height 0.95 :v-adjust -0.05))
           :extensions (indexer))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "filter_center_focus" :height 0.95 :v-adjust -0.15))
           :extensions (intellisense-keyword))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "share" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
           :extensions (interface))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
           :extensions (localvariable))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "cube" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-purple))
           :extensions (method))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "view_module" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
           :extensions (namespace))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "format_list_numbered" :height 0.95 :v-adjust -0.15))
           :extensions (numeric))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "control_point" :height 0.95 :v-adjust -0.2))
           :extensions (operator))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.05))
           :extensions (property))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "format_align_center" :height 0.95 :v-adjust -0.15))
           :extensions (snippet))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "text-width" :height 0.9 :v-adjust -0.05))
           :extensions (string))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange))
           :extensions (structure))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "format_align_center" :height 0.95 :v-adjust -0.15))
           :extensions (template))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "chevron-right" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
           :extensions (collapsed) :fallback "+")
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "chevron-down" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
           :extensions (expanded) :fallback "-")
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-binary" :height 0.9  :v-adjust 0.0 :face 'font-lock-doc-face))
           :extensions (classfile))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-blue))
           :extensions (default-folder-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-blue))
           :extensions (default-folder))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-green))
           :extensions (default-root-folder-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-green))
           :extensions (default-root-folder))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-binary" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
           :extensions ("class"))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-zip" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
           :extensions (file-type-jar))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (folder-open))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
           :extensions (folder))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-orange))
           :extensions (folder-type-component-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-orange))
           :extensions (folder-type-component))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-green))
           :extensions (folder-type-library-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-green))
           :extensions (folder-type-library))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-pink))
           :extensions (folder-type-maven-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-pink))
           :extensions (folder-type-maven))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'font-lock-type-face))
           :extensions (folder-type-package-opened))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'font-lock-type-face))
           :extensions (folder-type-package))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "plus" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (icon-create))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "list" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (icon-flat))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-material "share" :height 0.95 :v-adjust -0.2 :face 'all-the-icons-lblue))
           :extensions (icon-hierarchical))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "link" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (icon-link))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "refresh" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (icon-refresh))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "chain-broken" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (icon-unlink))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-alltheicon "java" :height 1.0 :v-adjust 0.0 :face 'all-the-icons-orange))
           :extensions (jar))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "book" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-green))
           :extensions (library))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "folder-open" :face 'all-the-icons-lblue))
           :extensions (packagefolder-open))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
           :extensions (packagefolder))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-faicon "archive" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
           :extensions (package))
          (treemacs-create-icon
           :icon (format "%s " (all-the-icons-octicon "repo" :height 1.0 :v-adjust -0.1 :face 'all-the-icons-blue))
           :extensions (java-project))))
      (setq lsp-treemacs-theme "lsp-colors"))))
