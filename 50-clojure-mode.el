(setenv "JAVA_HOME" "c:/jdk1.6.0_11")
(setenv "ANT_HOME" "~/tools/apache-ant-1.7.1")
(setenv "PATH" 
	(concat (getenv "ANT_HOME") "/bin;" 
		(getenv "JAVA_HOME") "/bin;" 
		(getenv "PATH")))

(setq clojure-src-root "~/lisp/clj")

;; this does make origin/master work
;; (setq swank-clojure-extra-classpaths
;;       (cons (concat clojure-src-root "/swank-clojure")
;;         (when (file-directory-p "~/.clojure")
;;           (directory-files "~/.clojure" t ".jar$"))))

(add-to-list 'load-path "~/lisp/clj/clojure-mode")
(require 'clojure-mode)

;; M-x clojure-install
;; we let clojure-mode get all the source clojure, clojure-contrib,
;; swank-clojure and slime AND do the compile for us.
;;
;; as clojure and swank-clojure does not play nice at the moment
;; rolling back to origin/1.0 will make things work again.
;; 
;; > cd ~/lisp/clj/clojure
;; > git checkout origin/1.0 
;; > ant
;;
;; restart emacs and write M-x slime to start things up nicely

(eval-after-load 'clojure-mode '(clojure-slime-config))
