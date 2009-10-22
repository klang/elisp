;; (defun klang/clojure-mode-init ()
;;   "adjust some key bindings in clojure-mode"
;;   (define-key clojure-mode-hook [f6] '(lambda () (interactive) (find-file "~/elisp/50-clojure-mode.el"))))
;; (add-hook 'clojure-mode-hook 'klang/clojure-mode-init)

(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))
 
(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))
 
;; add hooks for modes you want to use the tab completion for:
;;(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

;;; 

(require 'ido)
(ido-mode nil)
(include 'dominating-file) ; http://github.com/technomancy/emacs-starter-kit


(defun prg-clojure nil
  "Start project with classpath for Programming Clojure by Stuart Halloway"
  (interactive)
  ;; setting default directory, will include it in classpath
  ;; (def mkdir-task (org.apache.tools.ant.taskdefs.Mkdir.))
  ;; (.setDir mkdir-task (java.io.File. "sample-dir"))
  ;; (.execute mkdir-task)
  ;; will create a directory in 'default-directory
  (setq default-directory "~/wrk-clojure/tutorials/programming-clojure/")

  ;; swank-clojure-project could also be used, this version includes . in
  ;; classpath though, which is needed to (use 'examples.introduction)
  (clojure-project default-directory)
  ;; M-x slime-redirect-inferior-output
  )

(defun prg-clojure-snippets nil
  "Start custom project"
  (interactive)
  (setq default-directory "~/wrk-clojure/snippets/")
  (clojure-project default-directory))

(defun prg-clojure-journal-server nil
  "Start custom project"
  (interactive)
  (setq default-directory "~/wrk-clojure/projects/journal-server/")
  (clojure-project default-directory))

(defun clojure-project (path)
  "Setup classpaths for a clojure project and starts a new SLIME session.
     Kills existing SLIME session, if any."
  (interactive (list
		(ido-read-directory-name
		 "Project root: "
		 (locate-dominating-file default-directory "src"))))
  (require 'swank-clojure)
  (when (get-buffer "*inferior-lisp*")
    (kill-buffer "*inferior-lisp*"))
  (add-to-list 'swank-clojure-extra-vm-args
	       (format "-Dclojure.compile.path=%s"
		       (expand-file-name "target/classes/" path)))
  (setq swank-clojure-binary nil
	swank-clojure-jar-path (expand-file-name "target/dependency/" path)
	swank-clojure-extra-classpaths
	(append (mapcar (lambda (d) (expand-file-name d path))
			'("." "src/" "target/classes/" "test/"))
		(let ((lib (expand-file-name "lib" path)))
		  (if (file-exists-p lib)
		      (directory-files lib t ".jar$"))))
	slime-lisp-implementations
	(cons `(clojure ,(swank-clojure-cmd) :init swank-clojure-init)
	      (remove-if #'(lambda (x) (eq (car x) 'clojure))
			 slime-lisp-implementations)))
  (save-window-excursion
    (slime)))

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." 
  t)

(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
