;; http://www.djcbsoftware.nl/dot-emacs.html
;; some commands for rectangular selections;
;; http://www.emacswiki.org/cgi-bin/wiki/RectangleMark
(if (include 'rect-mark)
    (progn
      (define-key ctl-x-map "r\C-@" 'rm-set-mark)
      (define-key ctl-x-map [?r ?\C-\ ] 'rm-set-mark)
      (define-key ctl-x-map "r\C-x" 'rm-exchange-point-and-mark)
      (define-key ctl-x-map "r\C-w" 'rm-kill-region)
      (define-key ctl-x-map "r\M-w" 'rm-kill-ring-save)
      (define-key global-map [S-down-mouse-1] 'rm-mouse-drag-region)
      (autoload 'rm-set-mark "rect-mark"
	"Set mark for rectangle." t)
      (autoload 'rm-exchange-point-and-mark "rect-mark"
	"Exchange point and mark for rectangle." t)
      (autoload 'rm-kill-region "rect-mark"
	"Kill a rectangular region and save it in the kill ring." t)
      (autoload 'rm-kill-ring-save "rect-mark"
	"Copy a rectangular region to the kill ring." t)
      (autoload 'rm-mouse-drag-region "rect-mark"
	"Drag out a rectangular region with the mouse." t)

      ;; Use this section in your "~/.emacs" to modify picture mode so that
      ;; it automatically uses the rect-mark equivalents of many commands.

      ;; One vision of a better picture mode.
      (add-hook 'picture-mode-hook 'rm-example-picture-mode-bindings)
      (autoload 'rm-example-picture-mode-bindings "rect-mark"
	"Example rect-mark key and mouse bindings for picture mode.")
      )
  (message "rect-mark not present")
  )
