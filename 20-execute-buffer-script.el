; macro writes a bit of elisp code that figures out which executable to run based on
; the file extension of the buffer-name. After that it runs that executable as a
; shell-command with the buffer-name as argument.
(defmacro execute-buffer-script-generator (&rest ext-exe-pairs)
  `(let ( (ext (first (last (split-string (buffer-name) "\\." t)))) )
     (cond
      ,@(loop while ext-exe-pairs collecting
	      `((equal ,(pop ext-exe-pairs) ext)
		(zerop (shell-command (concat ,(pop ext-exe-pairs) " " (buffer-name))))
		(message "executing %s script" ext)))
      (1 (message "%s unknown extension" ext)))))

(defun execute-buffer-script-1 ()
  "executes the script in the current buffer"
  (interactive)
  (execute-buffer-script-generator
   "pl" "perl"
   "php" "php -f"
   "sh" "bash")
  )

;; based on "pl" "perl", "php" "php -f" and "sh" "bash", the macro expands to:
;; (let ( (extention (first (last (split-string (buffer-name) "\\." t)))) )
;;       (cond ((equal "pl" extention)
;; 	     (zerop (shell-command (concat "perl" " " (buffer-name))))
;; 	     (message "%s" extention))
;; 	    ((equal "php" extention)
;; 	     (zerop (shell-command (concat "php -f" " " (buffer-name))))
;; 	     (message "%s" extention))))))

;; now, I could just have written _that_, but where is the fun?
;; Karsten Lang Pedersen, karsten@lang.dk, 20080806 .. trying to learn lisp

(defvar extsion-to-executer-bindings ())
(add-to-list 'extsion-to-executer-bindings '("pl" . "perl"))
(add-to-list 'extsion-to-executer-bindings '("php" . "php -f"))
(add-to-list 'extsion-to-executer-bindings '("sh" . "bash"))

;; -> maybe finding that binding in the first line of the buffer would be an idea?
;;    (that strategy does not work consistently for php, though.)
;; #!/usr/local/bin/perl
;; <?php
;; #!/bin/bash
;;
(defun lookup-executer (ext) 
   "find appropriate executer for script"
   (interactive)
   (cdr (assoc ext extsion-to-executer-bindings )) )

(defun execute-buffer-script ()
  "executes the script in the current buffer"
  (interactive)
  (let ( (ext (first (last (split-string (buffer-name) "\\." t)))) )
    (zerop (shell-command (concat (lookup-executer ext) " " (buffer-name))))))

;; comming to think about it .. there was another way to do this, without the macro
;; Karsten Lang Pedersen, karsten@lang.dk, 20090703 .. still trying to learn lisp

(global-set-key [f10] 'execute-buffer-script)
