(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    sql-indent
    ;; old stuff moved from elisp/site
    rect-mark
    paredit
    php-mode
    yasnippet
    ;; Clojure stuff
    clojure-mode 
    ;; nrepl -- running bleeding edge instead 
    ;; Fuzzy match
;    fuzzy fuzzy-match
    ;; multiple-cursors
;    multiple-cursors
    ;; Eye-candy
    highlight-parentheses highline col-highlight crosshairs vline
    highlight-symbol hl-sexp idle-highlight
    rainbow-mode
    ;; Paren matching
;    mic-paren
    ;; Color themes
    zenburn-theme solarized-theme
    ;; Undo tree
    undo-tree)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; https://github.com/kumarshantanu/emacs24-config/blob/master/dot-emacs.d/init.el
