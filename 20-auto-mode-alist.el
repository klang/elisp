(defun set-auto-mode-alist (regexp mode)
  "Sets emacs to automatically use MODE when a file satifying REGEXP is loaded
set-auto-mode checks that the requested MODE exists"
  (if (functionp mode)
      (add-to-list 'auto-mode-alist (cons regexp mode))))

;; set special modes
;; could be done nicer..
(add-to-list 'auto-mode-alist '("\\.cgi$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

