(defun ut-basename (file) "returns name.ext for file /path/name.ext"
  (first (last (split-string file "\\/"))))

(defun ut-path (file) "returns /path/ for file /path/name.ext"
  (first (split-string file (ut-basename file))))

(defun ut-ext (file) "returns ext for file name.ext"
  (first (last (split-string (ut-basename file) "\\."))))

(defun ut-name (file) "returns name for file name.ext"
  (car (split-string (ut-basename file) (concat "\\." (ut-ext file) "$") t)))

(defun ut-trail-with-slash (path) "returns path/ for path or path/"
  (replace-regexp-in-string "/?$" "/" path) )

(defun ut-test-file (file &optional marker) 
  "returns a sensible test script filename, without path. 
name.ext -> name-marker.ext if marker is given
         -> name-test.ext otherwise"
  (or marker (setq marker "-test"))
  (concat (ut-name file) marker "." (ut-ext file)))

;; (defun ut-doc-string (file) 
;;   "returns \"Unit testing 'name' using SimpleTest\""
;;   (concat "Unit testing '" (ut-name file) "' using SimpleTest"))

;; (defun ut-all (file) 
;;    (let* ( (name     (concat "wrk-unittest-" (ut-name file))) 
;; 	   (docs     (ut-doc-string file))
;; 	   (test     (concat (ut-path file) (ut-test-file file))) )
;;      (message "%s %s %s %s" name docs file test)
;;     ))

;; used in ut-toggle
(defun ut-prod-file (file &optional marker)
  "returns a sensible production file name, without path. 
name-marker.ext -> name.ext if marker is given
name-test.ext   -> name.ext otherwise"
  (or marker (setq marker "-test"))
  (replace-regexp-in-string marker "" file))

;; used in ut-toggle
(defun ut-test-filep (file &optional marker) 
  "returns true if file is of the form name-marker.ext or name-test.ext"
  (or marker (setq marker "-test"))
  (equal (first (split-string file marker)) file))

;; used in switch-to-buffer-or-find-file
(defun ut-toggle (&optional file marker)
  "toggles between name-test.ext and name.ext"
  (or file (setq file (buffer-name)))
  (or marker (setq marker "-test"))
  (if (ut-test-filep file marker)
      (ut-test-file file marker)
    (ut-prod-file file marker)))

;;; toggle style when selecting "the other file"
(defun ut-find-file-pair (file &optional marker)
  "opens two files"
  (interactive "FFind files:")
  (or marker (setq marker "-test"))
  (split-window)
  (ut-other-file file marker)
  (find-file-other-window file))

(defun ut-other-file (&optional file marker)
  "opens name-marker.ext for file name.ext"
  (interactive)
  (or file (setq file (buffer-name)))
  (or marker (setq marker "-test"))
  (let ((target (ut-toggle file)))
    (if (get-buffer target) 
	(switch-to-buffer target) 
      (find-file target))))

(defun ut-other-file-other-window ()
  "ut-other-file in other-window"
  (interactive)
  (split-window)
  (ut-other-file))

(global-set-key [f7] 'ut-other-file)


