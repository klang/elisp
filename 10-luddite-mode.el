;; first, remove all the crap that looks different from emacs 20.7.1
; luddite mode
(cond ((> emacs-major-version 20)
       (tool-bar-mode -1) ; introduced in emacs 21
       (menu-bar-mode -1)
       (scroll-bar-mode -1)
       (menu-bar-showhide-fringe-menu-customize-disable)
       (blink-cursor-mode -1)
       (windmove-default-keybindings 'meta)))

; toggles luddite mode
(global-set-key [f12] '(lambda () (interactive) (menu-bar-mode nil) (scroll-bar-mode nil)))

(defun toggle-mode-line () "toggles the modeline on and off"
  (interactive)
  (setq mode-line-format
	(if (equal mode-line-format nil)
	    (default-value 'mode-line-format)))
  (redraw-display))

(global-set-key [M-f12] 'toggle-mode-line)

(defun new-buffer-without-minibuffer () 
  "opens a new buffer without making a mini-buffer"
  (interactive)
  (setq default-minibuffer-frame
	(make-frame
	 '((name . "minibuffer") (width . 0) (height . 0)
	   (minibuffer . only) (top . 0) (left . 0))))
  (setq new-frame
	(make-frame
	 '((name . "editor") (width . 80) (height . 30) 
	   (minibuffer . nil) (top . 50) (left . 0)))))

