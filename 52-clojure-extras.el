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

(defun whatthefuck ()
  ;; trying to fix missing { control in repl..
  (defvar slime-override-map (make-keymap))

  (define-minor-mode slime-override-mode
    "Fix SLIME REPL keybindings"
    nil " SLIME-override" slime-override-map)

  (define-key slime-override-map (kbd "{") 'paredit-open-curly)
  (define-key slime-override-map (kbd "}") 'paredit-close-curly)

  (add-hook 'slime-repl-mode-hook (lambda ()
				    (slime-override-mode t)
				    (slime-redirect-inferior-output)
				    (modify-syntax-entry ?\[ "(]")
				    (modify-syntax-entry ?\] ")[")
				    (modify-syntax-entry ?\{ "(}")
				    (modify-syntax-entry ?\} "){")))
  )
 
;; add hooks for modes you want to use the tab completion for:
;;(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." 
  t)

(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

(require 'ido)
(ido-mode nil)
;;(include 'dominating-file) ; http://github.com/technomancy/emacs-starter-kit
