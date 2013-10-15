(if (include 'shell)
    ;; Have some reasonable indentation
    (setq-default sh-indentation 2))

;;; Make some radical improvements on interfacing to "external" programs
(include 'term)

;;; pull in the environment variables of the system shell
;;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
