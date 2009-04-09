;; cc-mode configurations
(if (include 'cc-mode)
    (progn 
      (set-auto-mode-alist "\\.[ch]\\'" 'c-mode)
      (set-auto-mode-alist "\\.\\([CH]\\|cc\\|hh\\)\\'" 'c++-mode)
      (set-auto-mode-alist "\\.[ch]\\(pp\\|xx\\|\\+\\+\\)\\'" 'c++-mode)
      (set-auto-mode-alist "\\.java\\'" 'java-mode)
      (set-auto-mode-alist "\\.jsp\\'" 'java-mode)
      (set-auto-mode-alist "\\.lex\\'" 'c-mode)
      (set-auto-mode-alist "\\.m\\'" 'objc-mode)
      (defun c-modes-setup nil
	(interactive)
	(c-toggle-auto-state 1)
	(c-toggle-hungry-state 1)
	(c-set-style "gnu"))
      (add-hook 'c-mode-common-hook 'c-modes-setup)))

;; perl-mode configurations
;; special perl-mode indent
; Various indentation styles:       K&R  BSD  BLK  GNU  LW
;   perl-indent-level                5    8    0    2    4
;   perl-continued-statement-offset  5    8    4    2    4
;   perl-continued-brace-offset      0    0    0    0   -4
;   perl-brace-offset               -5   -8    0    0    0
;   perl-brace-imaginary-offset      0    0    4    0    0
;   perl-label-offset               -5   -8   -2   -2   -2

;; perl "GNU" style
(defun perl-indentation-style nil
  "Select indentation style for perl-mode"
  (interactive)
  (setq perl-indent-level 2)
  (setq perl-continued-statement-offset 2)
  (setq perl-continued-brace-offset 0)
  (setq perl-brace-offset 0)
  (setq perl-brace-imaginary-offset 0)
  (setq perl-label-offset -2)
  )

;; php-mode configurations
;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-php-mode-customizations ()
  ;; other customizations
  (setq tab-width 2
	c-basic-offset 2
	c-set-style "awk"
        ;; this will make sure spaces are used instead of tabs
	indent-tabs-mode nil)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map ";" 'self-insert-command)
  (define-key c-mode-base-map "," 'self-insert-command)
  )

(require 'php-mode)
(add-hook 'php-mode-hook 'my-php-mode-customizations)

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

;; lisp-mode configurations

;;;;
;;;; this part is tested and works
;;;;
;;;;
(defun wrk-lisp nil "sets up lisp mode (clisp)" (interactive)
  (add-to-list 'load-path "~/lisp/slime/")
  (add-to-list 'exec-path "c:/cygwin/bin/")
  (setq inferior-lisp-program "clisp.exe -lp ~/lisp/clisp/ -i init.lisp")
  (if (include 'slime) (slime-setup))
  (setq default-directory "~/lisp/clisp/")
  (message "to start clisp: M-x slime")
)

;;;;
;;;; Here there be tygres
;;;; (this did work, at some point..)
;;;;
(defun wrk-slime-wrk nil "sets up slime" (interactive)
  (add-to-list 'load-path "~/slime/")
  (if (include 'slime) (slime-setup))
;; plink -L 4005:localhost:4005 klang@ubuntu197377
  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

  (setq lisp-indent-function 'common-lisp-indent-function
	slime-complete-symbol-function 'slime-fuzzy-complete-symbol
 	;;common-lisp-hyperspec-root "file:///c/klang/lisp/HyperSpec/"
 	slime-startup-animation t)
  (setf slime-translate-to-lisp-filename-function
       (lambda (file-name)
	 (subseq file-name (length "/klang@ubuntu197377:")))

       slime-translate-from-lisp-filename-function
       (lambda (file-name)
	 (concat ("/klang@ubuntu197377:" file-name)))
       )
)


(defun wrk-slime-prv nil "sets up slime" (interactive)
  (add-to-list 'load-path "~/slime/")
  (if (include 'slime) (slime-setup))
;; plink -L 4005:localhost:4005 klang@Feersum-Endjinn
  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

  (setq lisp-indent-function 'common-lisp-indent-function
	slime-complete-symbol-function 'slime-fuzzy-complete-symbol
 	;;common-lisp-hyperspec-root "file:///c/klang/lisp/HyperSpec/"
 	slime-startup-animation t)
  (setf slime-translate-to-lisp-filename-function
       (lambda (file-name)
	 (subseq file-name (length "/klang@Feersum-Endjinn:")))

       slime-translate-from-lisp-filename-function
       (lambda (file-name)
	 (concat ("/klang@Feersum-Endjinn:" file-name)))
       )
)

(defun wrk-slime nil "sets up slime" (interactive)
  (add-to-list 'load-path "~/slime/")
  (if (include 'slime) (slime-setup))
;; plink -L 4005:localhost:4005 klang@ubuntu197377
  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

  (setq inferior-lisp-program "c:/cygwin/bin/clisp.exe"
 	lisp-indent-function 'common-lisp-indent-function
	slime-complete-symbol-function 'slime-fuzzy-complete-symbol
 	;;common-lisp-hyperspec-root "file:///c/klang/lisp/HyperSpec/"
 	slime-startup-animation t)
  (setf slime-translate-to-lisp-filename-function
       (lambda (file-name)
	 (subseq file-name (length "/klang@ubuntu197377:")))

       slime-translate-from-lisp-filename-function
       (lambda (file-name)
	 (concat ("/klang@ubuntu197377:" file-name)))
       )
)



(defun wrk-sbcl nil "sets up lisp mode (Steel Bank Common Lisp)" (interactive)
  (add-to-list 'load-path "~/slime/")
  (setq exec-path (cons "c:/klang/lisp/sbcl" exec-path))
  (setq inferior-lisp-program "sbcl.exe --core sbcl.core")
  (if (include 'slime) (slime-setup))
)

;; default-process-coding-system
;; (set-buffer-process-coding-system decoding encoding)
;; (set-buffer-process-coding-system iso-latin-1 iso-latin-1)
;; http://www.cliki.net/SLIME%20Tips
;; Cygwin: . Starting an inferior lisp in Windows NT Emacs and using Cygwin
;; (e.g., starting the CLisp that comes with Cygwin) may produce errors of
;; this sort:
;;
;;; ...A file with name
;;; /c/cygwin/usr/share/emacs/site-lisp/slime/swank-loader
;;; does not exist...

;; One easy fix is to mount the Windows volume under the Cygwin root:

; mkdir /c
; touch /c/NOT_MOUNTED
; mount C:\\ /c




