;; first shot, using while
;; (defmacro defwrk (name description &rest files)
;;    `(defun ,name ()
;; 	,description
;; 	(interactive)
;; 	(let ((files '(,@files)))
;; 	  (while files
;; 	    (find-file (car files))
;; 	    (setq files (cdr files))))))

;; second shot, using loop while collecting
 (defmacro defwrk (name description &rest files)
    `(defun ,name ()
 	,description
 	(interactive)
 	(let ((files '(,@files)))
 	  (loop while files collecting (find-file (pop files))))))
;; produces this:
;;(defun wrk-p1 nil "project p1" (interactive)
;;  (let ((files (quote ("~/a" "~/b" "~/c"))))
;;    (loop while files collecting (find-file (pop files)))))


; (defwrk wrk-project "description" "paths" "to" "files")
; M-x wrk-project
; to load files
;; (print (macroexpand '(defwrk wrk-p1 "project p1" "~/a" "~/b" "~/c")))
;; (defun wrk-p1
;;   nil
;;   "project p1"
;;   (interactive)
;;   (let ((files (quote ("~/a" "~/b" "~/c"))))
;;     (loop while files collecting (find-file (pop files)))
;;     ))


;; (print (macroexpand '(defwrk wrk-p1 "project p1" "~/a" "~/b" "~/c")))
;; (defwrk wrk-p1 "project p1" "~/a" "~/b" "~/c")

(setq *projects* '((p1 "description of project 1"
		    ("~/a" "~/b" "~/c"))
		   (p2 "description of project 2"
		    ("~/d" "~/e" "~/f"))))

;; dump this data structure to disk and read it into memory again.

;; (defun cp-add-file-to-project "add a file to a specified project" nil)
;; (defun cp-remove-file-from-project "remove a file from a specified project" nil)
;; (defun cp-remove-project "removes an entire project" nil)
;; (defun cp-create-project-from-open-buffers "creates a new project from the currently open buffers, asking y/n for each file" nil)
;; (defun cp-update-project-from-open-buffers "updates a project with the currently open buffers" nil)

;; (defun cp-open-project "open the project/set of files" nil)
;; (defun cp-close-project "closes the project/set of files" nil)

;; (defmacro cp-wrk-define (name description files)
;;   "defines a macro"
;;    `(defun ,name ()
;; 	,description
;; 	(interactive)
;; 	(let ((files ',files))
;; 	  (while files
;; 	    (find-file (car files))
;; 	    (setq files (cdr files))))))

;; (define-open-project-file wrk-project ("list" "of" "paths" "to" "files"))
;; (define-open-project-file wrk-p1 "project p1" ("~/a" "~/b" "~/c"))
;; M-x wrk-project
;; to load files

;; (setf *project* 'p1)
;; (print *projects* (get-buffer "NOTES"))
;; (print (concat "(setq *projecats* '" *projects* ")") (get-buffer "NOTES"))

;; (progn
;;   (princ "(setq *projects* '" (get-buffer "NOTES"))
;;   (print *projects* (get-buffer "NOTES"))
;;   (princ ")" (get-buffer "NOTES"))
;; )

;; (princ "(setq *projects '" *projects* ")" (get-buffer "NOTES"))

;(defun get-project (project projects)
;  (second (assoc project projects)))
; this was correct befor "description" was added

;;(get-project *project* *projects*)


;;(provide 'current-project)

;; other systems that does the same
;; (filesets-init)

