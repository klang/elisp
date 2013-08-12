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
  (install-el-get))

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
