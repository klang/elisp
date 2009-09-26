;;; Wrapper to make .emacs self-compiling.
;; http://www.postulate.org/emacs.php
(defun byte-compile-if-needed (file)
  "byte-compile file.el if it is newer than file.elc"
  (let* ((compiled (concat (car (split-string file "\\.el$")) ".elc")))
    (message "%s %s" file compiled)
       (if (file-newer-than-file-p file compiled)
   	(progn
   	  (load file)
   	  (byte-compile-file file))
         (load compiled))))

;(byte-compile-if-needed "~/elisp/00-vital-functions.el")

(defvar emacs-startup-load-regexp "^[0-9]+.*\\.el$"
  "Regexp for files to match in order to get loaded automatically")

(defvar emacs-startup-load-dir
  (or
   (getenv "EMACS_STARTUP_LOAD_DIR")
   (cond
    ((file-directory-p "~/elisp")
     "~/elisp")
    (t
     (message "You have copied the .emacs from '/usr/lib/emacs/elisp', Plase make sure you understand what the implications of that is!")
     (sleep-for 2)
     "/usr/lib/emacs/elisp"))))

(defun load-elisp-files (&optional dir)
  "This functions scans the .elisp directory for files to execute"
  (interactive "DDirectory: ")
  ;; first of all, lets find the dir containing the files
  (let* ((load-dir
	  (or dir
	      emacs-startup-load-dir))
	 ;; Okay, lets get a list of files
	 (files (if load-dir
		    (directory-files load-dir t emacs-startup-load-regexp nil))))
    (mapcar 'load files)
    load-dir))

(add-to-list 'load-path emacs-startup-load-dir)
(add-to-list 'load-path (concat emacs-startup-load-dir "/site/"))

(load-elisp-files "~/elisp")

(defun elisp-update ()
 "Update elisp."
 (interactive)
 (message "Updating...")
 (let ((repo "~/elisp"))
   (unless (= 0 (shell-command (format "cd %s; git pull origin master" repo)))
     (error "elisp update failed: %s" repo))))

