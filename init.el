;; ~/.emacs.d/elisp
;; ~/.emacs.d/package.el
;; ln -s ~/.emacs.d/elisp/init.el ~/.emacs.d/init.el

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "elisp"))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    ;; Clojure stuff
    clojure-mode 
    ;; nrepl -- running bleeding edge instead 
    ;; Fuzzy match
;    fuzzy fuzzy-match
    ;; multiple-cursors
;    multiple-cursors
    ;; Eye-candy
    highlight-parentheses highline col-highlight crosshairs vline
    highlight-symbol hl-sexp idle-highlight
    rainbow-mode
    ;; Paren matching
;    mic-paren
    ;; Color themes
    zenburn-theme solarized-theme
    ;; Undo tree
    undo-tree)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; https://github.com/kumarshantanu/emacs24-config/blob/master/dot-emacs.d/init.el

;; make sure that emacs saves custom variables somewhere else than in .emacs
(setq custom-file (concat dotfiles-dir ".emacs-custom.el"))
(load custom-file 'noerror)

;; load ^[0-9]+.*\\.el files from ~/elisp
;(load "~/elisp/load-elisp-files.el" nil t)
(load (concat dotfiles-dir "elisp/load-elisp-files.el") nil t)

;; load the file that contain all the wrk sets
(load (concat dotfiles-dir "elisp/dot_wrk-current.el"))

