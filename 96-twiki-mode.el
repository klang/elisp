(defun twiki-code (beg end)
  "puts standard code tags around the region.
<font color=grey>
<verbatim>
region
</verbatim>
</font>
"
  (interactive "r")
  (save-excursion
    ;; as point will move as soon as we insert text,
    ;; we insert the last part of the text first.
    (goto-char end)
    (insert "</verbatim>\n</font>\n")
    (goto-char beg)
    (insert "<font color=grey>\n<verbatim>\n")
    )
  )
