;;; I always anted a (indent-buffer) function
(if (not (functionp 'indent-buffer))
    (defun indent-buffer (&optional buffer)
      "Indent the BUFFER (default current) according to mode"
      (interactive "bIndent buffer: ")
      (save-excursion
	(set-buffer (or buffer
			current-buffer))
	(indent-region (point-min) (point-max) nil))))

(defun php2sql nil
  "makes sql copied from php executable in mysql"
  (interactive)
  (query-replace-regexp "\\( \" \.\\| \"\.\\|\";\\| +\"\\)" "")
)

(defun sort-lines-buffer nil
  "Sorts all lines in current buffer"
  (interactive)
  (save-excursion
    (setq sort-fold-case t)
    (sort-lines nil (point-min) (point-max))))

(defun replace-filename-html nil
  "Automatically replace filename with html-tag"
  (interactive)
  (save-excursion
    (while (query-replace-regexp "^.*:.. \\(.*\\)$" "<img src=\"\\1\">"))))

(defun make-file-list nil
  "make file-list"
  (interactive)
  (save-excursion
    (while (query-replace-regexp "^.*\\(~/.*\\)$" "(find-file \"\\1\")"))))

(defun dos2unix nil nil (interactive)
  (set-buffer-file-coding-system 'undecided-unix))

(defun replace-multiple (replaces)
  (while replaces
    (save-excursion
      (replace-string (car (car replaces)) (cdr (car replaces)))
      (setq replaces (cdr replaces))
      )
    )
  )

(defun narrow-to-function ()
  "Narrows to current function (php or perl)"
  (interactive)
  (save-excursion
    (search-backward-regexp "^ *\\(function\\|sub\\) ")
    (let ((beg (point)))
      (search-forward-regexp "^ *}" nil t)
      (narrow-to-region beg (point)))
    )
  )

;; extra functions
(require 'htmlize)
(put 'narrow-to-region 'disabled nil)

;(require 'highlight-tail)
;(highlight-tail-mode)

(require 'highlight-current-line)
;; M-x highlight-current-line-minor-mode

(define-skeleton reddit-href-anchor
  "reddit anchor tag."
  "URL: "
  "[" _ "](" str ")")

(defun unfill-paragraph ()
  "Do the opposite of `fill-paragraph'; stuff all lines in the
current paragraph into a single long line."
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (fill-paragraph nil))) 