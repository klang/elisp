;;; I always anted a (indent-buffer) function
(if (not (functionp 'indent-buffer))
    (defun indent-buffer (&optional buffer)
      "Indent the BUFFER (default current) according to mode"
      (interactive "bIndent buffer: ")
      (save-excursion
	(set-buffer (or buffer
			current-buffer))
	(indent-region (point-min) (point-max) nil))))

