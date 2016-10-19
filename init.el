;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; ~/.emacs.d/elisp
;; ~/.emacs.d/package.el
;; ln -s ~/.emacs.d/elisp/init.el ~/.emacs.d/init.el

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path)
  (push "/usr/local/git/bin/" exec-path))

(defvar dotfiles-dir (file-name-directory 
		      (or load-file-name (buffer-file-name))))

;;(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "elisp"))

(load (concat dotfiles-dir "elisp/packages-elpa.el"))
(load (concat dotfiles-dir "elisp/packages-el-get.el"))

;; make sure that emacs saves custom variables somewhere else than in .emacs
(setq custom-file (concat dotfiles-dir ".emacs-custom.el"))
(load custom-file 'noerror)

;; load ^[0-9]+.*\\.el files from ~/elisp
;(load "~/elisp/load-elisp-files.el" nil t)
(load (concat dotfiles-dir "elisp/load-elisp-files.el") nil t)

;; load the file that contain all the wrk sets
(load (concat dotfiles-dir "elisp/dot_wrk-current.el"))

(include 'server)

(unless (server-running-p) (server-start))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ac-nrepl zenburn-theme yasnippet yaml-mode xml-rpc web-mode undo-tree sql-indent solarized-theme rect-mark rainbow-mode python-mode php-mode paredit json-mode jira idle-highlight hl-sexp highline highlight-symbol highlight-parentheses git-gutter exec-path-from-shell etags-select epc crosshairs col-highlight ansible-doc ac-cider-compliment ac-cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
