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




