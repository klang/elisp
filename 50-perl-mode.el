;; special perlmode indent

; Various indentation styles:       K&R  BSD  BLK  GNU  LW
;   perl-indent-level                5    8    0    2    4
;   perl-continued-statement-offset  5    8    4    2    4
;   perl-continued-brace-offset      0    0    0    0   -4
;   perl-brace-offset               -5   -8    0    0    0
;   perl-brace-imaginary-offset      0    0    4    0    0
;   perl-label-offset               -5   -8   -2   -2   -2

;; perl "GNU" style

(defun perl-indentation-style nil
  "Select indentation style for perl-mode"
  (interactive)
  (setq perl-indent-level 2)
  (setq perl-continued-statement-offset 2)
  (setq perl-continued-brace-offset -2)
  (setq perl-brace-offset 0)
  (setq perl-brace-imaginary-offset 0)
  (setq perl-label-offset -2)
  )

;;;;;;;
