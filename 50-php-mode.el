;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun klang/php-mode-init ()
  "Set some buffer-local variables."
  ;; other customizations (cc-styles.el)
  (c-set-style "awk")
  (setq tab-width 2)
  ;; this will make sure spaces are used instead of tabs
  (set 'indent-tabs-mode nil)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map ";" 'self-insert-command)
  (define-key c-mode-base-map "," 'self-insert-command)
  
  (setq case-fold-search t)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0))

(defconst klang-php-style 
  '((c-basic-offset . 2)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist
     (defun-open after)
     (defun-close . c-snug-1line-defun-close)
     (substatement-open after)
     (block-close . c-snug-do-while))
    (c-hanging-semi&comma-criteria)
    (c-cleanup-list)
    (c-offsets-alist
     (statement-block-intro . +)
     (substatement-open . 0)
     (statement-cont . +))) 
  "AWK style with differnet basic offset")


;; (defun my-php-mode-customizations ()
;;   ;; other customizations (cc-styles.el)
;;   (setq c-set-style "awk"
;;         tab-width 2
;;         c-basic-offset 2
;;         ;; this will make sure spaces are used instead of tabs
;;         indent-tabs-mode nil)
;;   ;; we like auto-newline and hungry-delete
;;   (c-toggle-auto-hungry-state 1)
;;   ;; keybindings for all supported languages.  We can put these in
;;   ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
;;   ;; java-mode-map, and idl-mode-map inherit from it.
;;   (define-key c-mode-base-map "\C-m" 'newline-and-indent)
;;   (define-key c-mode-base-map ";" 'self-insert-command)
;;   (define-key c-mode-base-map "," 'self-insert-command)
;;   )

;; (add-hook 'php-mode-hook 'my-php-mode-customizations)
;(add-hook 'php-mode-hook 'klang/php-mode-init)
(require 'php-mode)


;(add-hook 'php-mode-hook
;	  '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))


;;(set-face-underline 'font-lock-warning-face "yellow")

;;(add-hook 'c-mode-common-hook
;;;;(add-hook 'php-mode-common-hook
;;               (lambda ()
;;                (font-lock-add-keywords nil
;;                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; (defun php-mode-hook ()
;;   (setq tab-width 2
;;  	c-basic-offset 2
;;  	c-hanging-comment-ender-p nil
;;  	indent-tabs-mode
;;   	(not
;;   	 (and (string-match "/\\(PEAR\\|pear\\)/" (buffer-file-name))
;;   	      (string-match "\.php$" (buffer-file-name))))
;;   	))

;;; ---------------------------------------8<----------------------------------
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(c-hanging-braces-alist (quote ((brace-list-open after) (brace-entry-open) (statement-cont) (substatement-open after) (block-close . c-snug-do-while) (extern-lang-open after) (namespace-open after) (module-open after) (composition-open after) (inexpr-class-open after) (inexpr-class-close before)))))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )

;; (defun php-mode-hook ()
;;   (setq tab-width 2
;;         c-basic-offset 2
;;         c-hanging-comment-ender-p nil
;;         indent-tabs-mode
;; 	(and (string-match "\.php$" (buffer-file-name)) (c-set-style "awk"))))


;; (add-to-list 'auto-mode-alist '("\\.klp\\'" . php-mode))

;; ;; php indentation
;; (defconst my-php-style
;;   '((c-tab-always-indent          . t)
;;     (c-comment-only-line-offset   . 4)
;;     (c-hanging-braces-alist       . ((substatement-open after)
;;                                      (brace-list-open)))
;;     (c-hanging-colons-alist       . ((member-init-intro before)
;;                                      (inher-intro)
;;                                      (case-label after)
;;                                      (label after)
;;                                      (access-label after)))
;;     (c-cleanup-list               . (scope-operator
;;                                      empty-defun-braces
;;                                      defun-close-semi))
;;     (c-offsets-alist              . ((arglist-close . c-lineup-arglist)
;;                                      (substatement-open . 0)
;;                                      (case-label        . 0)
;;                                      (block-open        . 0)
;;                                      (knr-argdecl-intro . -)))
;;     (c-echo-syntactic-information-p . t)
;;     )
;;   "My php Programming Style")

;; ;; Customizations for all modes in CC Mode.
;; (defun my-php-mode-common-hook ()
;;   (c-add-style "PERSONAL" my-php-style t)
;;   (setq tab-width 4
;;         indent-tabs-mode t
;;         c-basic-offset 4)
;;   (c-toggle-auto-state -1)              ; disable auto-newline mode
;;   (c-toggle-hungry-state 1)             ; enable hungry-delete mode

;;   ;; return 
;;   (define-key c-mode-base-map "\C-m" 'newline-and-indent)

;;   ;; C-c RET
;;   (define-key c-mode-base-map [(control c)(return)] 'ff-find-other-file)

;;   (c-set-offset 'substatement-open 0)
;;   (c-set-offset 'member-init-intro '++)
;;   (c-set-offset 'inline-open 0)
;;   (c-set-offset 'comment-intro 0)
;;   (c-set-offset 'label 0)
;;   (c-set-offset 'arglist-intro '++)

;;   (hs-minor-mode 1)
;;   )

;; (add-hook 'c-mode-common-hook 'my-php-mode-common-hook)

