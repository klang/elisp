;;; Emacs and xemacs differ on paren-highligting
;;; we need to "hack" that.

(when (<= emacs-major-version 23)
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
	  (add-hook 'find-file-hooks 'paren-mode-if-wanted))))

(when (> emacs-major-version 24)
  (if (require 'paren)
      (progn (set-face-background 'show-paren-match-face (face-background 'default))
	     (set-face-foreground 'show-paren-match-face "#fff")
	     (set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)
	     (show-paren-mode))))


;;; highlight current s-expression
(when  (<= emacs-major-version 23)
  (if (include 'mic-paren) ;; taget fra Emacs.app
      (progn
	(defface paren-face-match-fancy-automatic
	  '((((class color)) (:background "#335353"))
	    (t (:background "gray")))
	  "Mic-paren mode face used for a matching paren."
	  :group 'faces
	  :group 'mic-paren-matching)

	(defface paren-face-match-fancy
	  '((((class color)) (:background "#335353"))
	    (t (:background "gray")))
	  "Mic-paren mode face used for a matching paren."
	  :group 'faces
	  :group 'mic-paren-matching)

	(defface paren-face-match-misterioso
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
	)))

(if (include 'paredit)
    (defun paredit-space-for-delimiter-p (endp delimiter)
      (and (not (if endp (eobp) (bobp)))
	   (memq (char-syntax (if endp (char-after) (char-before)))
		 (list ?\" ;; REMOVED ?w ?_
		       (let ((matching (matching-paren delimiter)))
			 (and matching (char-syntax matching))))))))

