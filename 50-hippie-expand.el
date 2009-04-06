;;; Hippie expand is SO cool, and saves a lot of time when you are typing

(if (include 'hippie-expand)
    (progn
      ;; Now the "fun" begins, emacs & xemacs disagree over key spec's.
      (cond ((string-match "Xemacs" (emacs-version))
	     ;; Let's make sure that the "F1" key hippie expands
	     (global-set-key '(f1) 'hippie-expand)
	     ;; althoug xemacs goes on for hours about being better
	     ;; at handling kyes, i there is no shift iso-lefttab
	     ;; keyevent. So we'll have to let that be
	     nil)

	    (t
	     (global-set-key '[f1] 'hippie-expand)
	     (global-set-key [S-iso-lefttab] 'hippie-expand)))))

;; This is a simple function to return the point at the beginning of the symbol to be completed
(defun he-tag-beg ()
  (let ((p
         (save-excursion
           (backward-word 1)
           (point))))
    p))


;; The actual expansion function
(defun try-expand-tag (old)
  ;; old is true if we have already attempted an expansion
  (unless  old
    ;; he-init-string is used to capture the string we are trying to complete
    (he-init-string (he-tag-beg) (point))
    ;; he-expand list is the list of possible expansions
    (setq he-expand-list (sort
                          (all-completions he-search-string 'tags-complete-tag) 'string-lessp)))
  ;; now we go through the list, looking for an expansion that isn't in the table of previously
  ;; tried expansions
  (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
              (setq he-expand-list (cdr he-expand-list)))
  ;; if we didn't have any expansions left, reset the expansion list
  (if (null he-expand-list)
      (progn
        (when old (he-reset-string))
        ())
    ;; otherwise offer the expansion at the head of the list
    (he-substitute-string (car he-expand-list))
    ;; and put that expansion into the tried expansions list
    (setq he-expand-list (cdr he-expand-list))
    t))
;; done, now we just use it as a clause in our make-hippie-expand-function (as above)


;; hippie expand slime symbol
(defun he-slime-symbol-beg ()
  (let ((p
         (slime-symbol-start-pos)))
    p))

(defun try-expand-slime-symbol (old)
  (unless  old
    (he-init-string (he-slime-symbol-beg) (point))
    (setq he-expand-list (sort
                          (car (slime-contextual-completions (slime-symbol-start-pos) (slime-symbol-end-pos))) 'string-lessp)))
  (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
              (setq he-expand-list (cdr he-expand-list)))
  (if (null he-expand-list)
      (progn
        (when old (he-reset-string))
        ())
    (he-substitute-string (car he-expand-list))
    (setq he-expand-list (cdr he-expand-list))
    t))
