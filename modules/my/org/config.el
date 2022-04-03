;;; my/org/config.el -*- lexical-binding: t; -*-

(after! org
  (add-to-list 'org-modules 'org-tempo t)

  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("li" . "src lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("json" . "src json"))
  (add-to-list 'org-structure-template-alist '("sql" . "src sql")))

(after! ob-ditaa
  (setq org-ditaa-jar-path (expand-file-name "ditaa.jar" doom-private-dir)
        org-ditaa-eps-jar-path (expand-file-name "DitaaEps.jar" doom-private-dir)))

(after! ox-latex
  ;; @see https://yuchi.me/post/export-org-mode-in-chinese-to-pdf-with-custom-latex-class
  ;; download elegantpaper.cls and place it in the same level as the org document
  (setq org-latex-pdf-process '("latexmk -xelatex -quiet -shell-escape -f %f"))
  (add-to-list 'org-latex-classes
               '("elegantpaper"
                 "\\documentclass[lang=cn]{elegantpaper}
                 [NO-DEFAULT-PACKAGES]
                 [PACKAGES]
                 [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-listings 'minted)
  (add-to-list 'org-latex-packages-alist '("" "minted")))

(use-package! org-appear
  :defer t
  :init (add-hook! org-mode #'org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autosubmarkers t
        org-appear-delay 0.3))
