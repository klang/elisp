(setq cider-popup-stacktraces 1)
(setq cider-show-error-buffer 1)
(setq cider-auto-select-error-buffer 1)
(setq cider-stacktrace-default-filters '(tooling dup))
;;(setq cider-known-endpoints '(("host-a" "10.10.10.1" "7888") ("host-b" "7888")))

(setq nrepl-hide-special-buffers t)
;;(setq cider-repl-tab-command #'indent-for-tab-command)
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'subword-mode)

(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)

(provide 'dash-at-point)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

;; http://github.com/briancarper/dotfiles/raw/master/.emacs
;; {} are not handled correctly by paredit in the repl,
;; but these lines fixes it
(defvar slime-override-map (make-keymap))
(define-minor-mode slime-override-mode
  "Fix SLIME REPL keybindings"
  nil " SLIME-override" slime-override-map)

(define-key slime-override-map (kbd "<C-return>") 'paredit-newline)
(define-key slime-override-map (kbd "{") 'paredit-open-curly)
(define-key slime-override-map (kbd "}") 'paredit-close-curly)
(define-key slime-override-map [delete] 'paredit-forward-delete)
(define-key slime-override-map [backspace] 'paredit-backward-delete)
;;(define-key slime-override-map "\C-j" 'slime-repl-return)
(define-key slime-override-map (kbd "æ") 'paredit-open-round)
(define-key slime-override-map (kbd "ø") 'paredit-open-square)
(define-key slime-override-map (kbd "å") 'paredit-open-curly)
(define-key slime-override-map (kbd "Æ") 'paredit-close-round)
(define-key slime-override-map (kbd "Ø") 'paredit-close-square)
(define-key slime-override-map (kbd "Å") 'paredit-close-curly)
;; 
(defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
	      (slime-override-mode t)
	      (modify-syntax-entry ?\[ "(]")
	      (modify-syntax-entry ?\] ")[")
	      (modify-syntax-entry ?\{ "(}")
	      (modify-syntax-entry ?\} "){")))

(add-hook 'clojure-mode-hook 'clojure-mode-slime-font-lock)
(add-hook 'cider-repl-mode-hook 'clojure-mode-slime-font-lock)
(add-hook 'cider-repl-mode-hook #'paredit-mode)


;; show paren's
(require 'paren)
(show-paren-mode 1)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#df73ff")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(defadvice show-paren-function
      (after show-matching-paren-offscreen activate)
      "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
      (interactive)
      (let* ((cb (char-before (point)))
             (matching-text (and cb
                                 (char-equal (char-syntax cb) ?\) )
                                 (blink-matching-open))))
        (when matching-text (message matching-text))))
