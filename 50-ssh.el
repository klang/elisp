(cond
 ((eq system-type 'windows-nt)
  ;; to make tramp work with plink, putty and pageant
  (setq exec-path (cons "~/bin" exec-path))
  (setq tramp-default-method "plink")
  ;; cygwin replaces bash
  (require 'setup-cygwin)
  ;; for emacs running on citrix, cygwin is installed somewhere else
  ;;(setenv "PATH" (concat "f:/cygwin/bin;" (getenv "PATH")))
  ;;(setq exec-path (cons "f:/cygwin/bin/" exec-path))
  (load "cygwin-tab-complete"))
 ((eq system-type 'gnu/linux)
  (setq tramp-default-method "ssh")
  (setq exec-path (cons "~/bin/" exec-path))))
