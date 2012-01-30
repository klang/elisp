(if (include 'font-lock)
    ;; check if we have (global-font-lock-mode)
    (if (functionp 'global-font-lock-mode)
	;; Nice, lets turn on font-lock globally
	(global-font-lock-mode t)
      ;; OK, no (global-font-lock), we'll need to hack it
      (defvar global-font-lock-mode-hack t) ; font-lock wanted
      (defun font-lock-mode-if-wanted nil
	"Function to turn on font-lock-mode if wanted, will be called from 'find-file-hooks"
	(interactive)
	(font-lock-mode global-font-lock-mode-hack))
      ;; Do font-lock if wanted on every loaded file
      (add-hook 'find-file-hooks 'font-lock-mode-if-wanted))
  ;; We REALLY want some cool font decorations
  (setq font-lock-maximum-decoration t))
