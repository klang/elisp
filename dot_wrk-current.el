;; f11 is bound to the same functionality in 99-key-bindings.el
(defun wrk-scratch ()
  "makes or switches to *scratch* without me having to write *scratch* every other day"
  (interactive)
  (switch-to-buffer "*scratch*"))

(defwrk wrk-dotemacs "emacs configuration files and friends" "~/.bash_profile" "~/.emacs")
(defwrk wrk-current "load the file that contain all the crap I am currently working on"
  "~/dot_wrk-current.el")

;; Each task is usually associated with a set of files.
;; defwrk makes an easy way to get to that set, by simply defining a function that loads them.
;;
