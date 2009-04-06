;;; cygwin-mount.el --- Teach EMACS about cygwin styles and mount points.

;; Emacs Lisp Archive Entry
;; Filename: cygwin-mount.el
;; Version: 1.2.1 - 2001-05-13
;; Author: Klaus Berndl <berndl@sdm.de>
;; Maintenance: Klaus Berndl <berndl@sdm.de>
;; Original author: Michael Cook <mcook@cognex.com>
;; Keywords: files, mount, cygwin
;;
;; Additional info:
;; Copyright (C) 1997 Michael Cook <mcook@cognex.com>.
;;               2001 Klaus Berndl <berndl@sdm.de>
;; Additional code by: Keisuke Mori <ksk@ntts.com>
;;                     Drew Moseley (drewmoseley@mindspring.com)
;;                     James Ganong (jeg@bigseal.ucsc.edu)
;;                     Jeff Juliano <juliano@cs.unc.edu>
;;                     Klaus Berndl <berndl@sdm.de>
;;                     Nick Sieger <nsieger@bitstream.net>
;;                     Richard Y. Kim <ryk@dspwiz.com>
;; This file is *NOT* (yet?) part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary

;; This package does all necessary so you can use cygwin-style filenames like
;; "//D/any/path/to/file" or "/cygdrive/d/any/path/to/file" in exactly the
;; same manner as the normal Windows-style filenames like
;; "D:\any\path\to\file" or "D:/any/path/to/file".
;; Furthermore this package enables using all your cygwin-mounts in
;; file-operations. For example you can call all file-operations (e.g.
;; find-file) for a file named "/usr/bin/anyfile" if you have mounted the
;; related Windows-path to /usr/bin.
;; The package also makes sure that ange-ftp will work correct if you are
;; using cygwin-mount.el.

;;; Installation:

;; Put in your .emacs or site-start.el file the following lines:
;;   (require 'cygwin-mount)
;;   (cygwin-mount-activate)

;;; Customization and using

;; + All customization is done in the customize-group `cygwin-mount'.
;; + Activating: cygwin-mount-activate
;; + Deactivating: cygwin-mount-deactivate

;; ----------------------------------------------------------------------

;;; History:

;; Original version by Michael Cook <mcook@cognex.com>.
;; + modified Jun 18 1998 by Keisuke Mori <ksk@ntts.com> to make it work with
;;   ange-ftp and enable mapping a drive letter
;; + modified Oct 25 1999 by Drew Moseley (drewmoseley@mindspring.com) to
;;   support /cygdrive style drive maps and for better coexistence with
;;   ange-ftp.
;; + modified Feb 7 2000 by James Ganong (jeg@bigseal.ucsc.edu) to work when
;;   / is mounted in a subdirectory instead of top level of a drive, and to
;;   check longest directory names first, to a / mount does not shadow.
;; + modified Mar 23 2000 by Jeff Juliano <juliano@cs.unc.edu> to make a
;;   user-callable function that performs the mapping. I use this in my
;;   .emacs file to find my non-version-specific site-lisp directory since
;;   NTemacs doesn't have one in its search path.
;; + modified July 2000 by Jeff Juliano <juliano@cs.unc.edu>: ps-print to
;;   //machine/printer-name was broken. cygwin-mount would intercept and try
;;   to convert the name to a local path, even though one doesn't exist.
;;   Also, don't do mount table lookup as early as used to. warning: this
;;   isn't extensively tested, and may not be correct.
;; + modified January 2001 by Klaus Berndl (berndl@sdm.de):
;;   - Added customization
;;   - Added activating and deactivating functions (emacs-packages should not
;;     activating itself only by loading!). Deactivating removes any new
;;     filehandlers and restore the original ange-ftp function.
;;   - Added test, if mount-program exists in PATH and if system-type is
;;     windows-nt.
;;   - Corrects a bug in the longest mount point substitution (network devices
;;     like //Host/Path are now never substituted because a mount point / then
;;     would always be incorrectly substituted. Now all file-operations work
;;     correct with network devices.
;;   - corrects a bug in the /cygdrive/-style regexp.
;;   - Makes the first "real" emacs-package cygwin32-mount.el
;;   All my changes are only removing bugs and adding stuff, so this code
;;   becomes a correct emacs-package. All substantiell working code and ideas
;;   come from the other authors.
;; + modified may 2001 by Klaus Berndl (berndl@sdm.de):
;;   - renaming the package to cygwin-mount.el
;;   - Better finding of the mount-program
;;   - now works for different cygwin versions:
;;     * cygwin <= 1.1.8
;;     * cygwin >= 1.3.1
;;     There is a new option `cygwin-mount-parsing-regexp' where these regexps
;;     are defined and where also a custom regexp can be defined.
;;     Thanks for the idea and a first implementation to Charles Curley
;;     (ccurley@trib.com) and Karel Sprenger (karel.sprenger@compaq.com).
;;   - Fixes problem with expand-file-name handling. This behaves differently
;;     from most other primitives that is called via file-name-handler-alist,
;;     because it takes two arguments rather than one. Either one or both
;;     arguments could trigger the invocation of the file-name-handler-alist.
;;     Thanks for the patch to Richard Y. Kim (ryk@dspwiz.com).
;;   - Option to initialize the `cygwin-mount-table' either snychron (default)
;;     or asynchron: `cygwin-mount-build-mount-table-asynch'.
;;     Thanks for the idea and a first implementation to Nick Sieger
;;     (nsieger@bitstream.net).

(require 'cl)

(if (locate-library "executable")
    (require 'executable)
  (error "You need the executable library to use cygwin-mount!"))
    

(defgroup cygwin-mount nil
  "Proper handling of cygwin mounts and filenames."
  :prefix "cygwin-"
  :group 'files)

(defconst cygwin-mount<=1.1.8-mount-regexp
  "^\\([a-z]:[^ \t\n]*\\) +\\([^ \t\n]+\\)")
(defconst cygwin-mount>=1.3.1-mount-regexp
  "^\\([a-z]:.*\\)[ \t]+on[ \t]+\\(.+\\) type \\(system\\|user\\)")
  
(defun cygwin-mount-get-mount-regexp ()
  "Returns a correct regexp for parsing the mount-output according to the
version of cygwin. Currently there is only a distiction between cygwin
versions <= 1.1.8 and >= 1.3.1."
  (let ((buf (get-buffer-create "*uname*")))
    (save-excursion
      (set-buffer buf)
      (erase-buffer)
      (call-process "uname" nil buf nil "-r")
      (goto-char (point-min))
      (prog1
          (if (looking-at "^1\\.3")
              cygwin-mount>=1.3.1-mount-regexp
            cygwin-mount<=1.1.8-mount-regexp)
        (kill-buffer buf)))))


(defcustom cygwin-mount-parsing-regexp (cygwin-mount-get-mount-regexp)
  "*Rexexp used to parse the output of the mount program. This
regexp is used to build the alist of `cygwin-mount-table' in
`cygwin-mount-build-table'. The regexp must define two subexpressions where
the first one must build the car of an element of `cygwin-mount-table' and the
second one must build the cdr. There are two predefined regexps, one for
cygwin <= 1.1.8 and one for cygwin >= 1.3.1. This option checks per default
which cygwin version is running and sets the correct regexp. But there is also
the possibility to define a custom regexp."
  :group 'cygwin-mount
  :type `(radio	(const :tag "Cygwin <= 1.1.8"
		       :value ,cygwin-mount<=1.1.8-mount-regexp)
		(const :tag "Cygwin >= 1.3.1"
		       :value ,cygwin-mount>=1.3.1-mount-regexp)
		(regexp :tag "Custom" :value "")))

(defcustom cygwin-mount-build-mount-table-asynch nil
  "*If not nil then `cygwin-mount-table' is build asynchron
at load-time of package `cygwin-mount.el'. If you change the value via
customize you must reload the package to take effect."
  :group 'cygwin-mount
  :type 'boolean)

(defconst cygwin-mount-buffername " *mount*")

(defun cygwin-mount-parse-mount ()
  "Parses the buffer `cygwin-mount-buffername' and return an alist with all
the mount-points. For the format of this alist see `cygwin-mount-table'.
Precondition of this function is current buffer must be the buffer named
`cygwin-mount-buffername'."
  (if (equal (current-buffer) (get-buffer cygwin-mount-buffername))
      (let ((case-fold-search t)
            mounts)
        ;; first pass tags each line with the length of the directory
        (goto-char (point-min))
        (while (search-forward-regexp cygwin-mount-parsing-regexp nil t)
          (let ((device (buffer-substring (match-beginning 1)
                                          (match-end 1)))
                (direct (file-name-as-directory (buffer-substring
                                                 (match-beginning 2)
                                                 (match-end 2)))))
            (end-of-line) (insert ( format "\t%d" (length direct )))))
    
        ;; now sort the lines numerically
        (sort-numeric-fields -1 (point-min) (point-max))
    
        ;; 2nd pass builds the mount list
        (goto-char (point-min))
        (while (search-forward-regexp cygwin-mount-parsing-regexp nil t)
          (let ((device (buffer-substring (match-beginning 1)
                                          (match-end 1)))
                (direct (file-name-as-directory (buffer-substring
                                                 (match-beginning 2)
                                                 (match-end 2)))))
            (setq mounts (cons (cons device direct) mounts))))
        mounts)))

(defun cygwin-mount-sentinel (proc msg)
  (if (or (eq (process-status proc) 'exit)
	  (eq (process-status proc) 'signal))
      (let ((buf (get-buffer-create cygwin-mount-buffername)))
	(save-excursion
	  (set-buffer buf)
          (setq cygwin-mount-table (cygwin-mount-parse-mount)))
	(kill-buffer buf)
	(message "Build of mount table completed"))))

(defconst cygwin-mount-program "mount.exe")

(defun cygwin-mount-build-table ()
  "Determine the cygwin mount points. If mount table is build synchron then
the the function returns an alist of the format of `cygwin-mount-table'. If
mount-table is build asynchron \(see `cygwin-mount-build-mount-table-asynch')
then this function returns nil and `cygwin-mount-table is asynchronly set by
`cygwin-mount-sentinel'."
  (if (and (eq system-type 'windows-nt)
           (executable-find cygwin-mount-program))
      (if cygwin-mount-build-mount-table-asynch
          ;; asynchron building
          (let ((proc (start-process "mount" cygwin-mount-buffername
                                     cygwin-mount-program)))
            (set-process-sentinel proc 'cygwin-mount-sentinel)
            (process-kill-without-query proc)
            ;; we must return nil so `cygwin-mount-table' has at least a valid
            ;; value until the asynch setting has been finished.
            nil)
        ;; synchron building
        (let ((buf (get-buffer-create cygwin-mount-buffername)))
          (save-excursion
            (set-buffer buf)
            (erase-buffer)
            (call-process cygwin-mount-program nil buf)
            (prog1
                (cygwin-mount-parse-mount)
              (kill-buffer buf)))))
    nil))


(defcustom cygwin-mount-table (cygwin-mount-build-table)
  "*Alist of cygwin mount points or nil if there are no mount points.
An element of the alist has the form
\(<mounted windows-device> . <cygwin-directory>), e.g.
\(\"D:\\\\programs\\\\cygwin\\bin\" . \"/usr/bin/\") or
\(\"D:/programs/cygwin\" . \"/\").

This variable is initialized with all the mount-points the mount-program
returns \(synchron or asynchron, see `cygwin-mount-build-mount-table-asynch'),
so normally you are not needed to modify this variable. But feel free..."
  :group 'cygwin-mount
  :type '(repeat (cons :tag "Insert a mount point"
                       (directory :tag "Mounted device")
                       (string :tag "Cygwin directory"))))



(defun cygwin-mount-name-hook-function (operation &rest args)
  (let ((fn (get operation 'cygwin-mount-name)))
    (if fn (apply fn operation args)
      (cygwin-mount-run-real-handler operation args))))

(defun cygwin-mount-map-drive-hook-function (operation &rest args)
  (let ((fn (get operation 'cygwin-mount-map-drive)))
    (if fn (apply fn operation args)
      (cygwin-mount-run-real-handler operation args))))

(defun cygwin-mount-run-real-handler (operation args)
  (let ((inhibit-file-name-handlers
         (cons 'cygwin-mount-name-hook-function
               (cons 'cygwin-mount-map-drive-hook-function
                     (and (eq inhibit-file-name-operation operation)
                          inhibit-file-name-handlers))))
        (inhibit-file-name-operation operation))
    (apply operation args)))


(defun cygwin-mount-name-expand (operation name &rest args)
  (cygwin-mount-run-real-handler
   operation
   (cons (cygwin-mount-substitute-longest-mount-name name) args)))

(defun cygwin-mount-substitute-longest-mount-name (name)
  "If NAME uses a mount directory, substitute the mount device and return the
resulting string. Otherwise, return NAME."
  (if (string-match "^//.+" name)
      ;; Added by Klaus: if name beginns with "//" then it can never contain a
      ;; cygwin mount point! Therefore we must not check for contained mount
      ;; points because if / is mounted then this will always match and we get
      ;; an incorrect substitution for network devices like //Host/path
      name
    (let ((mounts cygwin-mount-table)
          (len (length (file-name-as-directory name)))
          match)
      (while mounts
        (let ((mount (file-name-as-directory (cdar mounts))))
          (and (>= len (length mount))
               (string= mount
                        (file-name-as-directory
                         (substring (file-name-as-directory name)
                                    0 (length mount))))
               (or (null match)
                   (> (length (cdar mounts)) (length (cdr match))))
               (setq match (car mounts))))
        (setq mounts (cdr mounts)))
      (if match
          (concat (file-name-as-directory (car match))
                  (substring name (length (file-name-as-directory (cdr
                                                                   match)))))
        name))))

;; We cannot assume thate NAME matched cygwin-cygwin-style1-regexp,
;; cygwin-cygwin-style2-regexp nor cygwin-cygwin-style3-regexp,
;; because this function could be called with either argument to
;; `expand-file-name', but only one argument to `expand-file-name' may
;; have matched a regexp.
;; For example, `(expand-file-name ".." "/cygdrive/c/")' will trigger
;; `(cygwin-convert-file-name "..")' and
;; `(cygwin-convert-file-name "/cygdrive/c/")' to be called.
(defun cygwin-convert-file-name ( name )
  "Given file NAME, return equivalent one after converting cygwin's 
`//x/' to `x:/' and `/cygdrive/x/' to `x:/'."
  (cond ((string-match "^//[a-zA-Z]/" name)
         (concat (substring name 2 3) ":" (substring name 3)))
        ((string-match "^/cygdrive/[a-zA-Z]" name)
         (concat (substring name 10 11) ":" (substring name 11 nil)))
        (t name)))

(defun cygwin-mount-map-drive (operation name &rest args)
  "Maps cygwin-style names to the windows-style \"[A-Za-z]:/\" and calls
OPERATION with the mapped filename\(s). NAME must have the format looks like
\"^//[A-Za-z]/\" or \"/cygdrive/[A-Za-z]/\" here. Note that at least the first
element of ARGS could be a filename too \(then it must have the same syntax
like NAME!) which must be converted \(e.g. `expand-file-name' can be called
with two filenames)."
  (cygwin-mount-run-real-handler
   operation
   (cons (cygwin-convert-file-name name)
	 (if (stringp (car args))
 	     (cons (cygwin-convert-file-name (car args))
		   (cdr args))
	   args))))

;;; ange-ftp
(require 'ange-ftp)
;;; save the original function definition of ange-ftp-run-real-handler
(defconst cygwin-original-ange-ftp-handler
  (symbol-function 'ange-ftp-run-real-handler))

;;; This version of ange-ftp-run-real-handler also inhibits the
;;; cygwin file name expansion when we are doing ange-ftp expansion.
;;;
;;; This is a real hack.  If the real definition of this function
;;; changes, we have to modify this function
(defun cygwin-ange-ftp-run-real-handler (operation args)
  (let ((inhibit-file-name-handlers
         (cons 'ange-ftp-hook-function
               (cons 'ange-ftp-completion-hook-function
                     (cons 'cygwin-mount-name-hook-function
                           (cons 'cygwin-mount-map-drive-hook-function
                                 (and (eq inhibit-file-name-operation
                                          operation)
                                      inhibit-file-name-handlers))))))
        (inhibit-file-name-operation operation))
    (apply operation args)))

;; Added by Klaus
(defconst cygwin-cygwin-style1-regexp "^/[^:@]*$\\|^/|/[^/:]+\\(\\'\\|/\\)")
(defconst cygwin-cygwin-style2-regexp "^//[A-Za-z]/")
;; Support cygdrive style drive maps.
;; Note that we cannot have `/' at the end of the following to handle 
;; cases like `(expand-file-name "foo" "/cygdrive/c")'.
(defconst cygwin-cygwin-style3-regexp "^/cygdrive/[A-Za-z]")

;; Added by Klaus
(defun cygwin-mount-activate ()
  "Activates the cygwin-mount- and cygwin-style-handling"
  (interactive)
  (if (not (eq system-type 'windows-nt))
      (message "cygwin-mount is only available for (X)Emacs for NT!")
  ;; add the cygwin-filehandlers
    (or (assoc cygwin-cygwin-style1-regexp file-name-handler-alist)
        (setq file-name-handler-alist
              (cons `(,cygwin-cygwin-style1-regexp
                      . cygwin-mount-name-hook-function)
                    file-name-handler-alist)))

    (or (assoc cygwin-cygwin-style2-regexp file-name-handler-alist)
        (setq file-name-handler-alist
              (cons `(,cygwin-cygwin-style2-regexp
                      . cygwin-mount-map-drive-hook-function)
                    file-name-handler-alist)))
    (or (assoc cygwin-cygwin-style3-regexp file-name-handler-alist)
        (setq file-name-handler-alist
              (cons `(,cygwin-cygwin-style3-regexp
                      . cygwin-mount-map-drive-hook-function)
                    file-name-handler-alist)))

    ;; add cygwin-properties
    (put 'substitute-in-file-name 'cygwin-mount-name
         'cygwin-mount-name-expand)
    (put 'expand-file-name 'cygwin-mount-name 'cygwin-mount-name-expand)
    (put 'substitute-in-file-name
         'cygwin-mount-map-drive 'cygwin-mount-map-drive)
    (put 'expand-file-name 'cygwin-mount-map-drive
         'cygwin-mount-map-drive)
    ;; rebind ange-ftp-run-real-handler to our version
    (fset 'ange-ftp-run-real-handler 'cygwin-ange-ftp-run-real-handler)))

;; Added by Klaus
(defun cygwin-mount-deactivate ()
  "Deactivates the cygwin-mount- and cygwin-style-handling"
  (interactive)
  (if (not (eq system-type 'windows-nt))
      (message "cygwin-mount is only available for (X)Emacs for NT!")
    ;; remove the cygwin-filehandlers
    (setq file-name-handler-alist
          (delete (assoc cygwin-cygwin-style1-regexp file-name-handler-alist)
                  file-name-handler-alist))
    (setq file-name-handler-alist
          (delete (assoc cygwin-cygwin-style2-regexp file-name-handler-alist)
                  file-name-handler-alist))
    (setq file-name-handler-alist
          (delete (assoc cygwin-cygwin-style3-regexp file-name-handler-alist)
                  file-name-handler-alist))
    ;; remove the cygwin properties
    (put 'substitute-in-file-name 'cygwin-mount-name nil)
    (put 'expand-file-name 'cygwin-mount-name nil)
    (put 'substitute-in-file-name 'cygwin-mount-map-drive nil)
    (put 'expand-file-name 'cygwin-mount-map-drive nil)
    ;; rebind ange-ftp-run-real-handler to it´s original definition.
    (fset 'ange-ftp-run-real-handler cygwin-original-ange-ftp-handler)))

(provide 'cygwin-mount)

