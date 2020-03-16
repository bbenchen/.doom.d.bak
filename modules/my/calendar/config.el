;;; my/calendar/config.el -*- lexical-binding: t; -*-

(use-package! cal-china-x
  :config
  (progn
    (setq mark-holidays-in-calendar t)
    (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
    (setq cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")
                                         (holiday-lunar 7 7 "七夕节")
                                         (holiday-lunar 9 9 "重阳节")
                                         ))
    (setq calendar-holidays
          (append cal-china-x-important-holidays
                  cal-china-x-general-holidays))))
