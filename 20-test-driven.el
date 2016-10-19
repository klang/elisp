(defun bash-basename (file) "returns name.ext for file /path/name.ext"
  (first (last (split-string file "\\/"))))

(defun bash-dirname (file) "returns /path/ for file /path/name.ext"
  (first (split-string file (bash-basename file))))

(defun bash-dirname-trail-with-slash (path) "returns path/ for path or path/"
  (replace-regexp-in-string "/?$" "/" path) )

(defun bash-extension (file) "returns ext for file name.ext"
  (first (last (split-string (bash-basename file) "\\."))))

(defun bash-filename (file) "returns name for file name.ext"
  (car (split-string (bash-basename file) (concat "\\." (bash-extension file) "$") t)))

(defgroup testdriven nil
  "Testdriven is used for easing the work in test driven development.
Switching between test and production code made easy."
  :prefix "td-"
  :link '(url-link "http://github.com/klang/elisp"))

(defcustom testdriven-testfile-marker "_test"
  ""
  :group 'testdriven
  :type 'string)

(defun td-test-file (file &optional marker) 
  "returns a sensible test script filename, without path. 
name.ext -> name-marker.ext if marker is given
         -> name-test.ext otherwise"
  (or marker (setq marker "_test"))
  (concat (bash-filename file) marker "." (bash-extension file)))

;; (defun ut-doc-string (file) 
;;   "returns \"Unit testing 'name' using SimpleTest\""
;;   (concat "Unit testing '" (bash-filename file) "' using SimpleTest"))

;; (defun ut-all (file) 
;;    (let* ( (name     (concat "wrk-unittest-" (bash-filename file))) 
;; 	   (docs     (ut-doc-string file))
;; 	   (test     (concat (bash-dirname file) (td-test-file file))) )
;;      (message "%s %s %s %s" name docs file test)
;;     ))

;; used in td-toggle
(defun td-prod-file (file &optional marker)
  "returns a sensible production file name, without path. 
name-marker.ext -> name.ext if marker is given
name-test.ext   -> name.ext otherwise"
  (or marker (setq marker "_test"))
  (replace-regexp-in-string marker "" file))

;; used in td-toggle
(defun td-test-filep (file &optional marker) 
  "returns true if file is of the form name-marker.ext or name-test.ext"
  (or marker (setq marker "_test"))
  (equal (first (split-string file marker)) file))

;; used in switch-to-buffer-or-find-file
(defun td-toggle (&optional file marker)
  "toggles between name-test.ext and name.ext"
  (or file (setq file (buffer-name)))
  (or marker (setq marker "_test"))
  (if (td-test-filep file marker)
      (td-test-file file marker)
    (td-prod-file file marker)))

;;; toggle style when selecting "the other file"
(defun td-find-file-pair (file &optional marker)
  "opens two files"
  (interactive "FFind files:")
  (or marker (setq marker "_test"))
  (split-window)
  (td-other-file file marker)
  (find-file-other-window file))

(defun td-other-file (&optional file marker)
  "opens name-marker.ext for file name.ext"
  (interactive)
  (or file (setq file (buffer-name)))
  (or marker (setq marker "_test"))
  (let ((target (td-toggle file)))
    (if (get-buffer target) 
	(switch-to-buffer target) 
      (find-file target))))

(defun td-other-file-other-window ()
  "td-other-file in other-window"
  (interactive)
  (delete-other-windows)
  (split-window)
  (td-other-file))

(global-set-key [f7] 'td-other-file)
(global-set-key "\C-xt" 'td-other-file)
(global-set-key "\C-x5t" 'td-other-file-other-window)

;;; -- new and compact way to do the same

(defun td-toggle-related (file to from)
  "toggles between file.from.ext and file.to.ext"
  (let ((to-from (replace-regexp-in-string to from file)) 
        (from-to (replace-regexp-in-string from to file)))
    (if (equal file to-from) from-to to-from)))

(defun td-toggle-model-view (&optional file)
  "opens related file"
  (interactive)
  (or file (setq file (buffer-name)))
  (let ((target (td-toggle-related file ".model.php" ".view.html.php")))
    (if (get-buffer target) 
	(switch-to-buffer target) 
      (find-file target))))

(defun td-toggle-model-test (&optional file)
  "opens related file"
  (interactive)
  (or file (setq file (buffer-name)))
  (let ((target (td-toggle-related file ".model.php" ".model-test.php")))
    (if (get-buffer target) 
	(switch-to-buffer target) 
      (find-file target))))

(defun td-related-file-other-window (target)
  "td-other-file in other-window"
  (delete-other-windows)
  (split-window)
  (funcall target))

(defun td-model-view-other-window ()
 "open in a different window"
 (interactive)
 (delete-other-windows)
 (split-window)
 (td-toggle-model-view))

(defun td-model-test-other-window ()
 "open in a different window"
 (interactive)
 (delete-other-windows)
 (split-window)
 (td-toggle-model-test))

;;(global-set-key "\C-x5r" 'td-model-view-other-window)
;;(global-set-key "\C-x5t" 'td-model-test-other-window)

;;(global-set-key "\C-xr" 'td-toggle-model-view)
;;(global-set-key "\C-xt" 'td-toggle-model-test)
