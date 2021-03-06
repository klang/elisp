;; Copy this file to ~/.emacs if you want to make you own changes
;; or
;; make af softlink (ln -s ~/elisp/init/elisp.el ~/.emacs) if you want to use it 'as is'
;; make sure that emacs saves custom variables somewhere else than in .emacs
(setq custom-file "~/elisp/.emacs-custom.el")
(load custom-file 'noerror)

;; load ^[0-9]+.*\\.el files from ~/elisp
(load "~/elisp/load-elisp-files.el" nil t)

;; load the file that contain all the wrk sets
(load "~/elisp/dot_wrk-current.el")

