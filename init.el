;; ~/.emacs.d/elisp
;; ~/.emacs.d/package.el
;; ln -s ~/.emacs.d/elisp/init.el ~/.emacs.d/init.el

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "elisp"))

;;git clone git://GitHub.com/technomancy/package.el
(add-to-list 'load-path (concat dotfiles-dir "package.el"))

(require 'package)
(package-initialize)

;; make sure that emacs saves custom variables somewhere else than in .emacs
(setq custom-file (concat dotfiles-dir ".emacs-custom.el"))
(load custom-file 'noerror)

;; load ^[0-9]+.*\\.el files from ~/elisp
;(load "~/elisp/load-elisp-files.el" nil t)
(load (concat dotfiles-dir "elisp/load-elisp-files.el") nil t)

;; load the file that contain all the wrk sets
(load (concat dotfiles-dir "elisp/dot_wrk-current.el"))
