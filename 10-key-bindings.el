;;; Key bindings
(global-set-key [f4] 'speedbar-get-focus)
(define-key global-map [(meta return)] 'hippie-expand)
;; remove try-expand-line from default value
(setq hippie-expand-try-functions-list (remove 'try-expand-line hippie-expand-try-functions-list))
;; get out of recursive editing mode [[[(fundamental)]]]
(global-set-key [f2] 'top-level)

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

;;; Keys handling buffers/windows/frames
(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-S-tab] 'previous-buffer)
(global-set-key [C-S-iso-lefttab] 'previous-buffer)
(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-S-f6] 'previous-buffer)
(global-set-key [XF86Back] 'previous-buffer)
(global-set-key [XF86Forward] 'next-buffer)
(global-set-key [C-f6] 'next-buffer)
(global-set-key [C-M-up] '(lambda () (interactive) (shrink-window -1)) )
(global-set-key [C-M-down] '(lambda () (interactive) (shrink-window 1)) )
;; (global-set-key [C-M-left] '(lambda () (interactive) (shrink-window -1 1)) )
;; (global-set-key [C-M-right] '(lambda () (interactive) (shrink-window 1 1)) )
(global-set-key [f3] 'other-frame)
(global-set-key [C-f3] 'other-window)
(global-set-key "\C-xo" 'other-window)
(global-set-key "\C-x1" 'delete-other-windows)
(global-set-key "\C-xk" 'kill-buffer)
(global-set-key "\C-c\C-e" 'eval-current-buffer)
(if (functionp 'indent-buffer) (global-set-key "\C-ci" 'indent-buffer))
(global-set-key "\C-xi" 'insert-file)

(global-set-key [f9] '(lambda () (interactive) (save-buffer) (server-edit)) )
(defun my-done ()
  (interactive)
  (server-edit)
  (make-frame-invisible nil t))
(global-set-key (kbd "C-x C-c") 'my-done)
(global-set-key [f9] '(lambda () (interactive) (save-buffer) (my-done)))

(defun look-of-disapproval ()
  (interactive)
  (insert "ಠ_ಠ"))

(global-set-key [C-f11] 'dos2unix)
(global-set-key [(f8)] 'narrow-to-function)
(global-set-key [(S-f8)] 'widen)

;; (global-set-key [C-c C-c] 'comment-region)
(global-set-key [M-f11] '(lambda () (interactive) (if (eq show-trailing-whitespace t) (setq show-trailing-whitespace nil) (setq show-trailing-whitespace t))))
(global-set-key [f11] '(lambda () (interactive) (switch-to-buffer "*scratch*")))
(global-set-key [C-f11] '(lambda () (interactive) (bash)))
; toggles luddite mode
(if (= emacs-major-version 23)
  (global-set-key [f12] '(lambda () (interactive) (tool-bar-mode -1) (menu-bar-mode nil) (scroll-bar-mode nil)))
  (global-set-key [f12] '(lambda () (interactive) (let ((toggle (if (get-scroll-bar-mode) 0 1)))
						    (tool-bar-mode -1)
						    (scroll-bar-mode toggle)
						    (menu-bar-mode toggle)))))

; run buffer as php/perl/sh script
(global-set-key [f10] 'execute-buffer-script)

;;; just some easy shortcuts
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-c\C-a" 'auto-fill-mode)
(global-set-key "\C-c\C-r" 'toggle-read-only)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-s" 'isearch-forward)
(global-set-key "\M-g" 'goto-line)

; toggles linenum+highlight mode
(global-set-key [C-f12] '(lambda () (interactive) (highlight-current-line-minor-mode nil) (if (include 'linum) (linum))))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(defun klang/org-mode-init ()
  "adjust some key bindings in org-mode"
  ; by default bound to 'org-force-cycle-archived, which is anoying
  (define-key org-mode-map [(control tab)] t)
  )

(add-hook 'org-mode-hook 'klang/org-mode-init)

;; http://steve.yegge.googlepages.com/effective-emacs
;1: Swap Caps-Lock and Control

; 2: Invoke M-x without the Alt key
; on windows use: ./reg/caps_lock_to_control.reg

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

; 3: Prefer backward-kill-word over Backspace
(global-set-key "\C-w" 'kill-region)
(global-set-key [(meta delete)] 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;(keyboard-translate ?\å ?\()
;(keyboard-translate ?\Å ?\[)
(defun klang/lisp-paren-mode ()
  (interactive)
  (keyboard-translate ?\æ ?\()
  (keyboard-translate ?\ø ?\[)
  (keyboard-translate ?\å ?\{)
  (keyboard-translate ?\Æ ?\))
  (keyboard-translate ?\Ø ?\])
  (keyboard-translate ?\Å ?\})
)

(defun klang/fundamental-paren-mode ()
  (interactive)
  (keyboard-translate ?\æ ?\æ)
  (keyboard-translate ?\ø ?\ø)
  (keyboard-translate ?\å ?\å)
  (keyboard-translate ?\Æ ?\Æ)
  (keyboard-translate ?\Ø ?\Ø)
  (keyboard-translate ?\Å ?\Å)
)

;; (defun klang/clojure-mode-init ()
;;   "adjust some key bindings in clojure-mode"
;;   ; fingers getting 
;;   (define-key clojure-mode-map [(control tab)] t)
;;   (global-set-key (kbd "æ") (lambda () (interactive) (insert "[") ))
;;   (global-set-key (kbd "ø") (lambda () (interactive) (insert "]") ))
;;   (global-set-key (kbd "Æ") (lambda () (interactive) (insert "(") ))
;;   (global-set-key (kbd "Ø") (lambda () (interactive) (insert ")") ))
;;   (global-set-key (kbd "C-æ") (lambda () (interactive) (insert "{") ))
;;   (global-set-key (kbd "C-ø") (lambda () (interactive) (insert "}") ))
;;   )

;; (add-hook 'clojure-mode-hook 'klang/clojure-mode-init)

;;(global-set-key (kbd "[") (lambda () (interactive) (insert "[]") (backward-char 1)))
;;(global-set-key (kbd "(") (lambda () (interactive) (insert "()") (backward-char 1)))
;;(global-set-key (kbd "{") (lambda () (interactive) (insert "{}") (backward-char 1)))
;;(global-set-key (kbd "\"") (lambda () (interactive) (insert "\"\"") (backward-char 1)))

(defun smart-line-beginning ()
"Move point to the beginning of text on the current line; if that is already the current position of point, then move it to the beginning of the line."
(interactive)
(let ((pt (point)))
  (beginning-of-line-text)
  (when (eq pt (point))
    (beginning-of-line))))

(global-set-key "\C-a" 'smart-line-beginning)
