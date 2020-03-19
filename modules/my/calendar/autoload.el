;;; my/calendar/autoload.el -*- lexical-binding: t; -*-

;; https://emacs-china.org/t/topic/2119
;;;###autoload
(defun +diary-chinese-anniversary (lunar-month lunar-day &optional year mark)
  "在org文件中使用下面的方式来调用该函数
%%(+diary-chinese-anniversary 9 23 1993) 这是农历 1993 年 9 月 23 日生人的第 %d%s 个生日"
  (if year
      (let* ((d-date (diary-make-date lunar-month lunar-day year))
             (a-date (calendar-absolute-from-gregorian d-date))
             (c-date (calendar-chinese-from-absolute a-date))
             (cycle (car c-date))
             (yy (cadr c-date))
             (y (+ (* 100 cycle) yy)))
        (diary-chinese-anniversary lunar-month lunar-day y mark))
    (diary-chinese-anniversary lunar-month lunar-day year mark)))
