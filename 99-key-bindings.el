;;; Key bindings
(global-set-key [C-S-tab] 'previous-buffer)
(global-set-key [C-S-iso-lefttab] 'previous-buffer)
(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-S-f6] 'previous-buffer)
(global-set-key [C-f6] 'next-buffer)

(global-set-key [C-M-up] '(lambda () (interactive) (shrink-window -1)) )
(global-set-key [C-M-down] '(lambda () (interactive) (shrink-window 1)) )
;; (global-set-key [C-M-left] '(lambda () (interactive) (shrink-window -1 1)) )
;; (global-set-key [C-M-right] '(lambda () (interactive) (shrink-window 1 1)) )

(global-set-key [f4] 'speedbar-get-focus)
(define-key global-map [(meta return)] 'hippie-expand)
;; fjern try-expand-line fra default værdi
(setq hippie-expand-try-functions-list (remove 'try-expand-line hippie-expand-try-functions-list))
;; get out of recursive editing mode [[[(fundamental)]]]
(global-set-key [f2] 'top-level)
(global-set-key [f3] 'other-frame)
(global-set-key [C-f3] 'other-window)
(global-set-key [f9] '(lambda () (interactive) (save-buffer) (server-edit)) )
;; (global-set-key [C-c C-c] 'comment-region)
(global-set-key [C-f11] '(lambda () (interactive) (setq show-trailing-whitespace t)))
(global-set-key [f11] '(lambda () (interactive) (switch-to-buffer "*scratch*")))
; toggles luddite mode
(global-set-key [f12] '(lambda () (interactive) (tool-bar-mode -1) (menu-bar-mode nil) (scroll-bar-mode nil)))

; run buffer as php/perl/sh script
(global-set-key [f10] 'execute-buffer-script)

;; linenumbers
;;(require 'linum)
;; M-x linum

; toggles linenum+highlight mode
(global-set-key [C-f12] '(lambda () (interactive) (highlight-current-line-minor-mode nil) (if (include 'linum) (linum))))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

