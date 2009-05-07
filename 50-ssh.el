(cond
 ((eq system-type 'windows-nt)
  ;; to make tramp work with plink, putty and pageant
  ;; for emacs running on citrix, cygwin is installed somewhere else
  (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
  (setq exec-path (cons "c:/cygwin/bin/" exec-path))
  (setq exec-path (cons "~/bin" exec-path))
  (setq tramp-default-method "plink")
  ;; cygwin replaces bash
  (require 'setup-cygwin)

  (load "cygwin-tab-complete"))
 ((eq system-type 'gnu/linux)
  (setq tramp-default-method "ssh")
  (setq exec-path (cons "~/bin/" exec-path))))

