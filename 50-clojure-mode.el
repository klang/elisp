;; (defun klang/clojure-mode-init ()
;;   "adjust some key bindings in clojure-mode"
;;   (define-key clojure-mode-hook [f6] '(lambda () (interactive) (find-file "~/elisp/50-clojure-mode.el"))))
;; (add-hook 'clojure-mode-hook 'klang/clojure-mode-init)

;(global-set-key [f6] '(lambda () (interactive) (find-file "~/elisp/50-clojure-mode.el")))

(when (eq system-type 'windows-nt)
  (setenv "JAVA_HOME" "c:/jdk1.6.0_11")
  (setenv "ANT_HOME" "~/tools/apache-ant-1.7.1")
  (setenv "PATH"
	  (concat (getenv "ANT_HOME") "/bin;"
		  (getenv "JAVA_HOME") "/bin;"
		  (getenv "PATH"))))

(setq clojure-src-root "~/lisp/clj")

;; git clone git://github.com/technomancy/clojure-mode.git
(setq swank-clojure-extra-classpaths
;;			(append
       (cons (concat clojure-src-root "/swank-clojure/")
     	    (when (file-directory-p "~/.clojure")
     	      (directory-files "~/.clojure" t ".jar$")))
;;  			 (list
;;  				(concat clojure-src-root "/Clogger/src/") 
;; 				(concat clojure-src-root "/Clogger/src/site/") 
;;  				(concat clojure-src-root "/compojure/compojure.jar"))
;; 			 (directory-files 
;; 				(concat clojure-src-root "/compojure/deps") t "\.jar$")
;; 			 (directory-files "~/java/lib" t "\.jar$")
;; 			 )
			)

;; in clojure
;;(println (seq (.getURLs (java.lang.ClassLoader/getSystemClassLoader))))
(add-to-list 'load-path "~/lisp/clj/technomancy_clojure-mode")
;(add-to-list 'load-path "~/lisp/clj/jochu_clojure-mode")
(if (include 'clojure-mode)

;; M-x clojure-install
;; we let clojure-mode get all the source clojure, clojure-contrib,
;; swank-clojure and slime AND do the compile for us.
;;
;; if clojure and swank-clojure does not play nice
;; rolling back to origin/1.0 will make things work again.
;;
;; > cd ~/lisp/clj/clojure
;; > git checkout origin/1.0
;; > ant
;;
;; restart emacs and write M-x slime to start things up nicely

    (eval-after-load 'clojure-mode '(clojure-slime-config))

	;; change the clojure.jar we use, so it matches the compojure.jar
;;   (swank-clojure-config
;;    (setq swank-clojure-jar-path 
;; 	 (concat clojure-src-root "/compojure/deps/clojure.jar"))
;;    (setq swank-clojure-extra-classpaths
;; 	 (cons 
;; 	  (concat clojure-src-root "/compojure/compojure.jar")
;; 	  (directory-files 
;; 	   (concat clojure-src-root "/compojure/deps") "\.jar$"))))
  )

;; (System/getProperty "java.class.path")
;; (all-ns)
;; (println (seq (.getURLs (java.lang.ClassLoader/getSystemClassLoader))))


