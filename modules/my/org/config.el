;;; my/org/config.el -*- lexical-binding: t; -*-

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
