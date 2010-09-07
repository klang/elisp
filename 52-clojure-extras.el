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
(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

(autoload 'paredit-mode "paredit")
;; alternative way to hook paredit mode
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))
;;(add-hook 'clojure-mode-hook 'enable-paredit-mode)
;;(add-hook 'slime-connected-hook 'enable-paredit-mode)
(setq slime-protocol-version 'ignore)

;; this does not work (things do not terminate in the repl)
;;(add-hook 'slime-connected-hook (lambda () (clojure-mode)))

;; turn on syntax highlighting in *slime-repl clojure*
;;(load "~/projects/gists/421306/clojure-font-lock-setup.el")

;; this doesn't seem to do anything...
;; (require 'paredit)
;; (eval-after-load 'paredit
;;   '(progn (define-key paredit-mode-map (kbd "{")
;; 	    'paredit-open-curly)
;; 	  (define-key paredit-mode-map (kbd "}")
;; 	    'paredit-close-curly)
;; 	  (define-key paredit-mode-map (kbd "M-}")
;; 	    'paredit-close-curly-and-newline)))
;; 
(load "~/projects/gists/421306/clojure-font-lock-setup.el")
(load "./clojure-color.el")

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

(require 'ido)
(ido-mode t)
;;(include 'dominating-file) ; http://github.com/technomancy/emacs-starter-kit


;; http://github.com/briancarper/dotfiles/raw/master/.emacs
;; this fixes paredit mode in the repl
(defvar slime-override-map (make-keymap))
(define-minor-mode slime-override-mode
  "Fix SLIME REPL keybindings"
  nil " SLIME-override" slime-override-map)
(define-key slime-override-map (kbd "<C-return>") 'paredit-newline)
(define-key slime-override-map (kbd "{") 'paredit-open-curly)
(define-key slime-override-map (kbd "}") 'paredit-close-curly)
(define-key slime-override-map [delete] 'paredit-forward-delete)
(define-key slime-override-map [backspace] 'paredit-backward-delete)
;;(define-key slime-override-map (kbd "<C-return>") 'paredit-newline)
;;(define-key slime-override-map "\C-j" 'slime-repl-return)

(add-hook 'slime-repl-mode-hook (lambda ()
                                  (slime-override-mode t)
                                  (slime-redirect-inferior-output)
                                  (modify-syntax-entry ?\[ "(]")
                                  (modify-syntax-entry ?\] ")[")
                                  (modify-syntax-entry ?\{ "(}")
                                  (modify-syntax-entry ?\} "){")))

(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)
;; -- error (slime-setup '(slime-repl))
(add-hook 'slime-connected-hook 'slime-redirect-inferior-output)

