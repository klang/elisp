(defun set-auto-mode-alist (regexp mode)
  "Sets emacs to automatically use MODE when a file satifying REGEXP is loaded
set-auto-mode checks that the requested MODE exists"
  (if (functionp mode)
      (add-to-list 'auto-mode-alist (cons regexp mode))))

;; set special modes
;; could be done nicer..
(add-to-list 'auto-mode-alist '("\\.cgi$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.esh$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode))

;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
