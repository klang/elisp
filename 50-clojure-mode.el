(when (eq system-type 'windows-nt)
  (setenv "JAVA_HOME" "c:/jdk1.6.0_11")
  (setenv "ANT_HOME" "~/tools/apache-ant-1.7.1")
  (setenv "PATH" (concat (getenv "ANT_HOME") "/bin;"
			 (getenv "JAVA_HOME") "/bin;"
			 (getenv "PATH"))))

(when (eq system-type 'gnu/linux)
  (setenv "JAVA_HOME" "/usr/lib/jvm/java-6-sun-1.6.0.16"))

(when (or (eq system-type 'gnu/linux)
	  (eq system-type 'windows-nt))
  (setq clojure-src-root "~/.clj")
  (setq clojure-examples "~/wrk-clojure/tutorial/programming-clojure")
  (add-to-list 'load-path (concat clojure-src-root "/clojure-mode"))
  ;; cd ~/.clj 
  ;; git clone git://github.com/technomancy/clojure-mode.git

  (if (include 'clojure-mode)
      (if (not (and (file-directory-p (concat clojure-src-root "/slime"))
		    (file-directory-p (concat clojure-src-root "/clojure"))))
	  (message "clojure not configured: M-x clojure-install")
	(eval-after-load 'clojure-mode '(clojure-slime-config)))))

;; (System/getProperty "java.class.path")
;; (all-ns)
;; (println (seq (.getURLs (java.lang.ClassLoader/getSystemClassLoader))))

