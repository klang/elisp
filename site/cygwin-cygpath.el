(defvar running-on-cygwin-p (memq system-type '(cygwin cygwin32)))
(defvar running-on-mswindows-p (memq system-type
				     '(windows-nt ms-windows cygwin cygwin32)))

(defun translate-path-canonical (path)
  (if (not running-on-mswindows-p)
      path
    (if running-on-cygwin-p
	(substring (shell-command-to-string (concat "cygpath -u '" path "'")) 0 -1)
      (subst-char-in-string ?\\ ?/ path))))

(defun translate-path-native (path)
  (if (not running-on-mswindows-p)
      path
    (if running-on-cygwin-p
	(substring (shell-command-to-string (concat "cygpath -wp " path)) 0 -1)
      (subst-char-in-string ?/ ?\\ path))))

(defun cygpath (path)
  (if (not running-on-mswindows-p)
      path
    (substring (shell-command-to-string (concat "cygpath -wp " path)) 0 -1)
    ))

;; does not work as advertised

(defun merge-translated-paths (file-A file-B file-ancestor &optional
				      startup-hooks merge-buffer-file)
  (ediff-merge-files-with-ancestor (translate-path-canonical file-A)
				   (translate-path-canonical file-B)
				   (translate-path-canonical file-ancestor)
				   startup-hooks
				   (translate-path-canonical merge-buffer-file)))

(cygpath "c:klang/lisp/clj/closure/trunk/closure.jar:~/lisp/clj/clojure-contrib/trunk/clojure-contrib.jar")
(translate-path-native "~/lisp/clj/closure/trunk/closure.jar:~/lisp/clj/clojure-contrib/trunk/clojure-contrib.jar")

;; w32-symlinks.el <<--- see this one
