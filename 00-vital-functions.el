(if (boundp 'user-specific-dir)
    (add-to-list 'load-path (concat user-specific-dir "/site")))

(defun include (feature &optional file-name)
  "Conditional include, like (require), but doesn't  (error) when the file's not there.

Also returns t if FEATURE is defined as a function." 
  (if (not (or (featurep feature)
	       (functionp feature)))
      (progn 
	(if (load (or file-name
		      (symbol-name feature)) t)
	    (message "Loaded: %s" (or file-name
				      (symbol-name feature)))))
    (message "Already loaded: %s" (symbol-name feature)))
  (or (featurep feature)
      (functionp feature)))





