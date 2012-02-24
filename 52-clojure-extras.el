
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

;; add hooks for modes you want to use the tab completion for:
(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
;;(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

(autoload 'paredit-mode "paredit")
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))
(add-hook 'elisp-mode-hook (lambda () (paredit-mode +1)))
(setq slime-protocol-version 'ignore)

;;;
(defun lein-swank ()
  (interactive)
  (let ((root (locate-dominating-file default-directory "project.clj")))
    (when (not root)
      (error "Not in a Leiningen project."))
    ;; you can customize slime-port using .dir-locals.el
    (shell-command (format "cd %s && lein swank %s &" root slime-port)
                   "*lein-swank*")
    (set-process-filter (get-buffer-process "*lein-swank*")
                        (lambda (process output)
                          (when (string-match "Connection opened on" output)
                            (slime-connect "localhost" slime-port)
                            (set-process-filter process nil))))
    (message "Starting swank server...")))
;;;

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
              (clojure-mode-font-lock-setup)
	      (slime-override-mode t)
	      (modify-syntax-entry ?\[ "(]")
	      (modify-syntax-entry ?\] ")[")
	      (modify-syntax-entry ?\{ "(}")
	      (modify-syntax-entry ?\} "){")))

(add-hook 'slime-repl-mode-hook 'clojure-mode-slime-font-lock)
(add-hook 'clojure-mode-hook 'clojure-mode-slime-font-lock)

(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)
;;(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)
