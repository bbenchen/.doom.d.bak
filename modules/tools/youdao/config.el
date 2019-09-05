;;; tools/youdao-dictionary/config.el -*- lexical-binding: t; -*-

(use-package! youdao-dictionary
  :defer t
  :config
  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file (concat doom-cache-dir "youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t))

(map! "C-x C-y" (if (featurep! +childframe)
                    #'youdao-dictionary-search-at-point-posframe
                  #'youdao-dictionary-search-at-point-tooltip))
