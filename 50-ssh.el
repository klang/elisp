(cond
 ((eq system-type 'windows-nt)
  ;; to make tramp work with plink, putty and pageant
  (setq exec-path (cons "~/bin" exec-path))
  (setq tramp-default-method "plink")
  (setq exec-path (cons "c:/cygwin/bin/" exec-path))
  ;; cygwin replaces bash
  (require 'setup-cygwin)
  (load "cygwin-tab-complete"))
 ((eq system-type 'gnu/linux)
  (setq tramp-default-method "ssh")
  (setq exec-path (cons "~/bin/" exec-path))))
