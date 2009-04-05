;
; fold              :: (a -> b -> b) -> b -> ([a] -> b)
; fold f v []       = v
; fold f v (x : xs) = f x (fold f v xs)
;
(defun fold (list operator &optional init)
  (if list
      (fold (cdr list)
	    operator 
	    (funcall operator init (car list)))
    init))

;
; filter   :: (a -> bool) -> ([a] -> [a])
; filter p = fold (lambda x xs -> if p x then x:xs else xs) []
;
(defun filter (list predicate)
  (if list
      (if (funcall predicate (car list))
	  (cons (car list) (filter (cdr list) predicate))
	(filter (cdr list) predicate))
    nil))

(defun alist-keys (alist)
  (if alist
      (cons (car (car alist)) (alist-keys (cdr alist)))
    nil))

(defun join (list &optional seperator)
  (if list
      (concat (car list) 
	      (if (cdr list)
		  seperator)
	      (join (cdr list) seperator))))

