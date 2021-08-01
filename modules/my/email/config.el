;;; my/email/config.el -*- lexical-binding: t; -*-

(setenv "XAPIAN_CJK_NGRAM" "1")

(setq +mu4e-backend 'mbsync)

(set-email-account! "fa-software.com"
                    '((mu4e-sent-folder       . "/fa-software.com/已发送")
                      (mu4e-drafts-folder     . "/fa-software.com/草稿")
                      (mu4e-trash-folder      . "/fa-software.com/已删除")
                      (mu4e-refile-folder     . "/fa-software.com/INBOX")
                      (mu4e-update-interval   . nil)
                      (smtpmail-smtp-user     . "xianbin.chen@fa-software.com")
                      (smtpmail-smtp-server   . "smtp.qiye.aliyun.com")
                      (smtpmail-smtp-service  . 465)
                      (smtpmail-stream-type   . ssl)
                      (user-full-name         . "Mike Chen")
                      (user-mail-address      . "xianbin.chen@fa-software.com"))
                    t)

(after! mu4e
  (setq mu4e-bookmarks
        `(,(make-mu4e-bookmark
            :name  "Unread messages"
            :query "flag:unread AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?u)
          ,(make-mu4e-bookmark
            :name "Today's messages"
            :query "date:today..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?t)
          ,(make-mu4e-bookmark
            :name "Last week"
            :query "date:1w..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?w)
          ,(make-mu4e-bookmark
            :name "Last month"
            :query "date:1m..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?m)
          ,(make-mu4e-bookmark
            :name "Last season"
            :query "date:3m..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?s)
          ,(make-mu4e-bookmark
            :name "Last half year"
            :query "date:6m..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?h)
          ,(make-mu4e-bookmark
            :name "Last year"
            :query "date:1y..now AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?y)
          ,(make-mu4e-bookmark
            :name "All in inbox"
            :query "maildir:/INBOX/ AND NOT flag:trash"
            :key ?a)
          ,(make-mu4e-bookmark
            :name "Important"
            :query "prio:high AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?i)
          ,(make-mu4e-bookmark
            :name "Mailing lists"
            :query "flag:list AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?l)
          ,(make-mu4e-bookmark
            :name "With attachments"
            :query "flag:attach AND maildir:/INBOX/ AND NOT flag:trash"
            :key ?p))))

(after! mu4e-alert
  (if IS-MAC
      (mu4e-alert-set-default-style 'notifier))

  ;; Show notifications for mails already notified
  (setq mu4e-alert-notify-repeated-mails nil)

  (setq mu4e-alert-interesting-mail-query "flag:unread AND maildir:/INBOX/ AND NOT flag:trash"))

;; (after! org-msg
;;   (setq org-msg-convert-citation t
;;         org-msg-signature "

;;  Best Regards,

;;  #+begin_signature
;;  *陈显彬（Mike Chen）*
;;  #+end_signature"))

;; (use-package! mu4e-views
;;   :after mu4e
;;   :config
;;   (map! (:map mu4e-headers-mode-map
;;          "M-n" #'mu4e-views-cursor-msg-view-window-down
;;          "M-p" #'mu4e-views-cursor-msg-view-window-up
;;          "o" #'mu4e-views-mu4e-view-open-attachment
;;          "e" #'mu4e-views-mu4e-view-save-attachment))
;;   (setq mu4e-views-completion-method 'ivy)
;;   (setq mu4e-views-default-view-method "html")
;;   (mu4e-views-mu4e-use-view-msg-method "html")
;;   ;; (setq mu4e-views-next-previous-message-behaviour 'always-switch-to-view)
;;   (setq mu4e-views-auto-view-selected-message t)
;;   (defadvice! mu4e~headers-quit-buffer-a (fun)
;;     :around #'mu4e~headers-quit-buffer
;;     (if (mu4e-views-get-view-window-maybe)
;;         (mu4e-views-mu4e-headers-windows-only)
;;       (funcall fun))))
