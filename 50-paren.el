;;; Emacs and xemacs differ on paren-highligting
;;; we need to "hack" that.

(if (include 'paren)
    (progn
      (defvar global-paren-mode t)
      (if (functionp 'paren-set-mode)
	  (progn
	    ;; set paren level for xemacs
	    (setq paren-mode 'sexp))
	;; set paren level for emacs20
	(setq show-paren-style 'parenthesis))

      (defun paren-mode-if-wanted nil
	"Enters paren mode if global-paren-mode is set"
	(interactive)
	(message "(paren-mode-if-wanted) run")
	;; We need to hack for xemacs and emacs to work both
	(cond
	 ;; emacs uses "show-paren-mode"
	 ((functionp 'show-paren-mode)
	  (show-paren-mode global-paren-mode))
	 ;; xemacs is more complicated
	 ((functionp 'paren-set-mode)
	  (if global-paren-mode
	      (paren-set-mode paren-mode)))))

      (paren-mode-if-wanted)
      (add-hook 'find-file-hooks 'paren-mode-if-wanted)))

;;; highlight current s-expression
(require 'mic-paren) ;; taget fra Emacs.app
(defface paren-face-match-fancy
  '((((class color)) (:background "#335353"))
    (t (:background "gray")))
  "Mic-paren mode face used for a matching paren."
  :group 'faces
  :group 'mic-paren-matching)

(defface paren-face-match-normal
  '((((class color)) (:background "azure"))
    (t (:background "gray")))
  "Mic-paren mode face used for a matching paren."
  :group 'faces
  :group 'mic-paren-matching)

(paren-activate)
;;(setq paren-match-face (quote paren-face-match-normal))
(setq paren-sexp-mode t)
