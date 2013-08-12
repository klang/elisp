;; ~/.emacs.d/elisp
;; ~/.emacs.d/package.el
;; ln -s ~/.emacs.d/elisp/init.el ~/.emacs.d/init.el

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path)
  (push "/usr/local/git/bin/" exec-path))

(defvar dotfiles-dir (file-name-directory 
		      (or load-file-name (buffer-file-name))))

(add-to-list 'load-path dotfiles-dir)
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

;; http://www.emacswiki.org/emacs/download/sqlplus.el

;;(when (not (file-exists-p (concat root-dir "el-get")))
;;  ;; load extra packages
;;  (load-file (concat root-dir "packages-el-get.el")))


