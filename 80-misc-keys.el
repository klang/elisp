;;; Setup some shortcuts to some of the emacs built in functions

;;; Keys handling buffers/windows/frames

(global-set-key "\C-xk" 'kill-buffer)
(global-set-key "\C-c\C-e" 'eval-current-buffer)

(if (functionp 'indent-buffer)
    (global-set-key "\C-ci" 'indent-buffer))

(global-set-key "\C-xi" 'insert-file)

(global-set-key "\C-xo" 'other-window)
(global-set-key "\C-x1" 'delete-other-windows)

;;; just some easy shortcuts

(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-c\C-a" 'auto-fill-mode)
(global-set-key "\C-c\C-r" 'toggle-read-only)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-s" 'isearch-forward)
(global-set-key "\M-g" 'goto-line)

;;; mess aroud with backspace/insert/delete
(global-unset-key [insert])
(global-set-key  [delete] 'delete-char)

;;; some easy point<->register swappin
(cond ((string-match "XEmacs" (emacs-version))
       (global-set-key '(control >) 'point-to-register)
       (global-set-key '(control <) 'register-to-point))
      (t
       (global-set-key [?\C->] 'point-to-register)
       (global-set-key [?\C-<] 'register-to-point)))



