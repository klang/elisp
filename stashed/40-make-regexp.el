(if (not (include 'make-regexp))
    (progn
      (defun make-regexp-list (list)
	(if (cdr list)
	    (concat (car list) "\\|" (make-regexp-list (cdr list)))
	  (car list)))
      
      (defun make-regexp (list)
	(if list
	    (concat "\\(" (make-regexp-list list) "\\)")))))
