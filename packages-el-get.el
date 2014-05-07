(defun eval-url (url)
  (let ((buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer)))))

;;
;; Load el-get - installs if necessary
;;
(add-to-list 'load-path (concat dotfiles-dir "el-get/el-get"))

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(unless (require 'el-get nil t)
  ;(install-el-get)
(url-retrieve
 "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
 (lambda (s)
   (goto-char (point-max))
   (eval-print-last-sexp)))
)

;; http://www.emacswiki.org/emacs/download/sqlplus.el

(setq el-get-sources
      '(
;;	(:name dirtree
;;         :description "Directory tree view in Emacs"
;;         :type git
;;         :url "https://github.com/zkim/emacs-dirtree.git"
;;         :depends (tree-mode windata)
;;         :features dirtree)
;;        (:name tree-mode
;;         :type emacswiki
;;         :features tree-mode)
        (:name sqlplus
         :type emacswiki
         :features sqlplus)
	;; running off the latest preview of nrepl
;;	(:name cider
;;	 :type git
;;	 :url "https://github.com/clojure-emacs/cider.git"
;;         :features cider)
;;	;; ac-nrepl needs auto-complete from elpa
;;	(:name ac-nrepl
;;         :type git
;;         :url "https://github.com/clojure-emacs/ac-nrepl.git"
;;	 :features ac-nrepl)
;;	(:name four-clj
;;         :type git
;;         :url "https://github.com/klang/4clj-el")
;;        (:name yaml-mode
;;         :type git
;;         :url "https://github.com/yoshiki/yaml-mode.git"
;;         :features yaml-mode)
	))

(setq my-el-get-packages
      (append
       '(sqlplus)
       (mapcar 'el-get-source-name el-get-sources)))
  
(el-get 'sync my-el-get-packages)
