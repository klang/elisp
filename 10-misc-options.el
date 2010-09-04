;;; Make the startup message disseapear
(setq inhibit-startup-message t) ; i know this by heart
(setq initial-scratch-message nil)

;;; Make the modeline hold line and coloumn number
(line-number-mode t) ; make line numbers in mode-line
(column-number-mode t)

;;; Newline adding
(setq next-line-add-newlines nil) ; Don't extend buffer

;;; Ignore some files when completing
(setq completion-ignored-extensions
  '("~" ".aux" ".a" ".bbl" ".blg" ".dvi" ".elc"
    ".hc" ".hi" ".log" ".mlc" ".o" ".toc" ".ast"))

;;; Use one of these files when completing, if possible
;; complete to these regexps if possible
(setq pref-file-names-regexp
      "\\(\\.java\\|\\.pl$\\|\\.php$\\|\\.xml$\\|rc$\\|\\.html$\\|\\.el$\\|/$\\)" )

;;; don't change group on visited files
(setq backup-by-copying-when-mismatch t)

;;; Turn on transparent use of compressed files
(if (functionp 'auto-compression-mode)
    (auto-compression-mode t)
  (if (functionp 'toggle-auto-compression)
      (toggle-auto-compression t)))

;;; misc
(setq show-trailing-whitespace t)
(setq case-replace nil)
(setq case-fold-search t)
(setq search-highlight t                 ; highlight when searching...
  query-replace-highlight t)             ; ...and replacing
(fset 'yes-or-no-p 'y-or-n-p)            ; enable y/n answers to yes/no

;;; making sure that emacs starts in HOME and not where emacs.exe lives
(setq default-directory "~/")

;;; http://www.emacswiki.org/cgi-bin/wiki/IswitchBuffers
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^ " "^*"))

;;; http://code.google.com/p/yasnippet/
;(add-to-list 'load-path "~/elisp/site/yasnippet-0.5.7")
;(require 'yasnippet) ;; not yasnippet-bundle
(if (fboundp 'yas/initialize) 
 (progn (yas/initialize)
	(yas/load-directory "~/elisp/site/yasnippets")))

;;(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "cedet/srecode")))
;;(require 'srecode-load)
