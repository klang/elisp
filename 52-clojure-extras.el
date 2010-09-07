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

;(autoload 'paredit-mode "paredit"
;  "Minor mode for pseudo-structurally editing Lisp code." 
;  t)
(autoload 'paredit-mode "paredit")

(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))
;;(add-hook 'slime-connected-hook 'enable-paredit-mode)

(setq slime-protocol-version 'ignore)

;; turn on syntax highlighting in *slime-repl clojure*
;;(load "~/projects/gists/421306/clojure-font-lock-setup.el")

;; (require 'paredit)
;; (eval-after-load 'paredit
;;   '(progn (define-key paredit-mode-map (kbd "{")
;; 	    'paredit-open-curly)
;; 	  (define-key paredit-mode-map (kbd "}")
;; 	    'paredit-close-curly)
;; 	  (define-key paredit-mode-map (kbd "M-}")
;; 	    'paredit-close-curly-and-newline)))
;; 
;; (add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; -- color mode
;; (defun lisp-enable-paredit-hook () (paredit-mode 1))
;; (add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)
;; 
;; (defmacro defclojureface (name color desc &optional others)
;;   `(defface ,name '((((class color)) (:foreground ,color ,@others))) ,desc :group 'faces))
;; 
;; (defclojureface clojure-parens       "DimGrey"   "Clojure parens")
;; (defclojureface clojure-braces       "#49b2c7"   "Clojure braces")
;; (defclojureface clojure-brackets     "SteelBlue" "Clojure brackets")
;; (defclojureface clojure-keyword      "khaki"     "Clojure keywords")
;; (defclojureface clojure-namespace    "#c476f1"   "Clojure namespace")
;; (defclojureface clojure-java-call    "#4bcf68"   "Clojure Java calls")
;; (defclojureface clojure-special      "#b8bb00"   "Clojure special")
;; (defclojureface clojure-double-quote "#b8bb00"   "Clojure special" (:background "unspecified"))
;; 
;; (defun tweak-clojure-syntax ()
;;   (mapcar (lambda (x) (font-lock-add-keywords nil x))
;;           '((("#?['`]*(\\|)"       . 'clojure-parens))
;;             (("#?\\^?{\\|}"        . 'clojure-brackets))
;;             (("\\[\\|\\]"          . 'clojure-braces))
;;             ((":\\w+"              . 'clojure-keyword))
;;             (("#?\""               0 'clojure-double-quote prepend))
;;             (("nil\\|true\\|false\\|%[1-9]?" . 'clojure-special))
;;             (("(\\(\\.[^ \n)]*\\|[^ \n)]+\\.\\|new\\)\\([ )\n]\\|$\\)" 1 'clojure-java-call))
;;             )))
;; 
;; (add-hook 'clojure-mode-hook 'tweak-clojure-syntax)
;; 
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(slime-highlight-edits-face ((((class color) (background dark)) (:background "#202020")))))
;; 


(require 'ido)
(ido-mode nil)
;;(include 'dominating-file) ; http://github.com/technomancy/emacs-starter-kit
