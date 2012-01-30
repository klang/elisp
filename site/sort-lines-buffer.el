(defun sort-lines-buffer nil
  "Sorts all lines in current buffer"
  (interactive)
  (save-excursion
    (setq sort-fold-case t)
    (sort-lines nil (point-min) (point-max))))
