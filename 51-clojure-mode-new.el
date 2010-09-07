(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))

(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))

(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
(add-hook 'slime-connected-hook 'my-tab-fix)
;;(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

;(autoload 'paredit-mode "paredit"
;  "Minor mode for pseudo-structurally editing Lisp code." 
;  t)

(autoload 'paredit-mode "paredit")

(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
;;(add-hook 'slime-connected-hook 'enable-paredit-mode)
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))

;(paredit-mode)

;; turn on syntax highlighting in *slime-repl clojure*
(load "~/projects/gists/421306/clojure-font-lock-setup.el")

    ;; set paredit keys
;;    (when (and (featurep 'paredit) paredit-mode (>= paredit-version 21))
;;      (define-key slime-repl-mode-map "{" 'paredit-open-curly)
;;      (define-key slime-repl-mode-map "}" 'paredit-close-curly))

;; we are not using version 20 of paredit .. we have it installed twice

(require 'paredit)
(eval-after-load 'paredit
  '(progn (define-key paredit-mode-map (kbd "{")
	    'paredit-open-curly)
	  (define-key paredit-mode-map (kbd "}")
	    'paredit-close-curly)
	  (define-key paredit-mode-map (kbd "M-}")
	    'paredit-close-curly-and-newline)))

(add-hook 'clojure-mode-hook 'enable-paredit-mode)