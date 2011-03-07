<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: php-mode-improved.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=php-mode-improved.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: php-mode-improved.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=php-mode-improved.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for php-mode-improved.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=php-mode-improved.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<br /><span class="specialdays">Swaziland, National Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22php-mode-improved.el%22">php-mode-improved.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="download/php-mode-improved.el">Download</a></p><pre class="code"><span class="linecomment">;;; php-mode.el --- major mode for editing PHP code</span>

<span class="linecomment">;; This is a version of the php-mode from http://php-mode.sourceforge.net that</span>
<span class="linecomment">;; fixes a few bugs which make using php-mode much more palatable, namely:</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; 1. New customisation options for some of the syntax highlighting</span>
<span class="linecomment">;;   features. I personally use the 'Gauchy' level of syntax</span>
<span class="linecomment">;;   highlighting -- I want variables and function calls fontified --</span>
<span class="linecomment">;;   but there were several very annoying "features" in this level of</span>
<span class="linecomment">;;   syntax highlighting, particularly the ones that warn you about</span>
<span class="linecomment">;;   perfectly valid code. I've added:</span>
<span class="linecomment">;; </span>
<span class="linecomment">;;   * `php-mode-dollar-property-warning', which, if non-nil, warns on</span>
<span class="linecomment">;;     $foo-&gt;$bar. (Default is nil.)</span>
<span class="linecomment">;;   * `php-mode-dot-property-warning', which, if non-nil, warns on</span>
<span class="linecomment">;;     $foo.bar. (Default is nil.)</span>
<span class="linecomment">;;   * `php-mode-warn-on-unmatches', which, if non-nil, warns on</span>
<span class="linecomment">;;     "everything else". (Default is nil.)</span>
<span class="linecomment">;;   * `php-mode-warn-if-mumamo-off', which, if nil, suppresses the</span>
<span class="linecomment">;;     once-per-file warning about indenting with mumamo-mode turned</span>
<span class="linecomment">;;     off. (Default is t)</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; 2. Bugfix in `php-show-arglist': this function no longer jumps to the</span>
<span class="linecomment">;;   function definition if that definition is in the current buffer.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; 3. Bugfix: 'class' keywords at the beginning of a line are now</span>
<span class="linecomment">;;   correctly fontified.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; This has been submitted to the php-mode maintainer, but I've not yet had a</span>
<span class="linecomment">;; response.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This was branched from the php-mode in nxhtml-mode, so if you have problems,</span>
<span class="linecomment">;; download the latest nxhtml-mode, and replace related/php-mode.el in the</span>
<span class="linecomment">;; nxhtml distribution with this file.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; -- David House, dmhouse@gmail.com</span>

<span class="linecomment">;; Copyright (C) 1999, 2000, 2001, 2003, 2004 Turadg Aleahmad</span>
<span class="linecomment">;;               2008 Aaron S. Hawley</span>

<span class="linecomment">;; Maintainer: Aaron S. Hawley &lt;ashawley at users.sourceforge.net&gt;</span>
<span class="linecomment">;; Author: Turadg Aleahmad, 1999-2004</span>
<span class="linecomment">;; Keywords: php languages oop</span>
<span class="linecomment">;; Created: 1999-05-17</span>
<span class="linecomment">;; Modified: 2008-01-25T22:25:26+0100 Fri</span>
<span class="linecomment">;; X-URL:   http://php-mode.sourceforge.net/</span>

(defconst php-mode-version-number "<span class="quote">1.4.1a-nxhtml</span>"
  "<span class="quote">PHP Mode version number.</span>")

<span class="linecomment">;;; License</span>

<span class="linecomment">;; This file is free software; you can redistribute it and/or</span>
<span class="linecomment">;; modify it under the terms of the GNU General Public License</span>
<span class="linecomment">;; as published by the Free Software Foundation; either version 3</span>
<span class="linecomment">;; of the License, or (at your option) any later version.</span>

<span class="linecomment">;; This file is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with this file; if not, write to the Free Software</span>
<span class="linecomment">;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA</span>
<span class="linecomment">;; 02110-1301, USA.</span>

<span class="linecomment">;;; Usage</span>

<span class="linecomment">;; Put this file in your Emacs lisp path (eg. site-lisp) and add to</span>
<span class="linecomment">;; your .emacs file:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   (require 'php-mode)</span>

<span class="linecomment">;; To use abbrev-mode, add lines like this:</span>
<span class="linecomment">;;   (add-hook 'php-mode-hook</span>
<span class="linecomment">;;     '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))</span>

<span class="linecomment">;; To make php-mode compatible with html-mode, see http://php-mode.sf.net</span>

<span class="linecomment">;; Many options available under Help:Customize</span>
<span class="linecomment">;; Options specific to php-mode are in</span>
<span class="linecomment">;;  Programming/Languages/Php</span>
<span class="linecomment">;; Since it inherits much functionality from c-mode, look there too</span>
<span class="linecomment">;;  Programming/Languages/C</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; PHP mode is a major mode for editing PHP 3 and 4 source code.  It's</span>
<span class="linecomment">;; an extension of C mode; thus it inherits all C mode's navigation</span>
<span class="linecomment">;; functionality.  But it colors according to the PHP grammar and indents</span>
<span class="linecomment">;; according to the PEAR coding guidelines.  It also includes a couple</span>
<span class="linecomment">;; handy IDE-type features such as documentation search and a source</span>
<span class="linecomment">;; and class browser.</span>


<span class="linecomment">;;; Contributors: (in chronological order)</span>

<span class="linecomment">;; Juanjo, Torsten Martinsen, Vinai Kopp, Sean Champ, Doug Marcey,</span>
<span class="linecomment">;; Kevin Blake, Rex McMaster, Mathias Meyer, Boris Folgmann, Roland</span>
<span class="linecomment">;; Rosenfeld, Fred Yankowski, Craig Andrews, John Keller, Ryan</span>
<span class="linecomment">;; Sammartino, ppercot, Valentin Funk, Stig Bakken, Gregory Stark,</span>
<span class="linecomment">;; Chris Morris, Nils Rennebarth, Gerrit Riessen, Eric Mc Sween,</span>
<span class="linecomment">;; Ville Skytta, Giacomo Tesio, Lennart Borgman, Stefan Monnier,</span>
<span class="linecomment">;; Aaron S. Hawley, Ian Eure, Bill Lovett, David House</span>

<span class="linecomment">;;; Changelog:</span>

<span class="linecomment">;; 1.4.1a-nxhtml</span>
<span class="linecomment">;;   Made underscore be part of identifiers.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 1.4.1-nxhtml</span>
<span class="linecomment">;;   Added php-mode-to-use.</span>

<span class="linecomment">;; 1.4.1</span>
<span class="linecomment">;;   Modified `php-check-html-for-indentation' to check for multiple</span>
<span class="linecomment">;;   mode support libraries. (Lennart Borgman)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 1.4</span>
<span class="linecomment">;;   Updated GNU GPL to version 3.  Ported to Emacs 22 (CC mode</span>
<span class="linecomment">;;   5.31). M-x php-mode-version shows version.  Provide end-of-defun</span>
<span class="linecomment">;;   beginning-of-defun functionality. Support add-log library.</span>
<span class="linecomment">;;   Fix __CLASS__ constant (Ian Eure).  Allow imenu to see visibility</span>
<span class="linecomment">;;   declarations -- "private", "public", "protected". (Bill Lovett)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 1.3</span>
<span class="linecomment">;;   Changed the definition of # using a tip from Stefan</span>
<span class="linecomment">;;   Monnier to correct highlighting and indentation. (Lennart Borgman)</span>
<span class="linecomment">;;   Changed the highlighting of the HTML part. (Lennart Borgman)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 1.2</span>
<span class="linecomment">;;   Implemented php-show-arglist, C-. (Engelke Eschner)</span>
<span class="linecomment">;;   Implemented php-complete-function, M-tab (Engelke Eschner)</span>
<span class="linecomment">;;   Re-enabled # comment detection in GNU Emacs (Urban Müller)</span>
<span class="linecomment">;;   Fixed some keybindings and default settings (Engelke Eschner)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 1.1</span>
<span class="linecomment">;;   Added PHP5 support (Giacomo Tesio)</span>
<span class="linecomment">;;     known problem: doesn't highlight after first 'implements'</span>
<span class="linecomment">;;   Better XEmacs compatibility (imenu, regexp, and comments!) (Ville Skytta)</span>
<span class="linecomment">;;   Improvement to php-conditional-key regexp (Eric Mc Sween)</span>

<span class="linecomment">;; 1.05</span>
<span class="linecomment">;;   Incorporated speedbar defs by Gerrit Riessen</span>
<span class="linecomment">;;   Add "foreach" to conditional introducing keywords (Nils Rennebarth)</span>
<span class="linecomment">;;   Cleared the Changelog</span>
<span class="linecomment">;;   Moved contribution credits into comments above</span>


<span class="linecomment">;;; Code:</span>

(require 'speedbar)
(require 'font-lock)
(require 'cc-mode)
(require 'custom)
(require 'etags)
(eval-when-compile
  (require 'regexp-opt))
 
<span class="linecomment">;; Local variables</span>
(defgroup php nil
  "<span class="quote">Major mode `php-mode' for editing PHP code.</span>"
  :prefix "<span class="quote">php-</span>"
  :group 'languages)

(defcustom php-default-face 'default
  "<span class="quote">Default face in `php-mode' buffers.</span>"
  :type 'face
  :group 'php)

(defcustom php-speedbar-config t
  "<span class="quote">When set to true automatically configures Speedbar to observe PHP files.\
Ignores php-file patterns option; fixed to expression \"\\.\\(inc\\|php[s34]?\\)\"</span>"
  :type 'boolean
  :set (lambda (sym val)
         (set-default sym val)
         (if (and val (boundp 'speedbar))
             (speedbar-add-supported-extension
              "<span class="quote">\\.\\(inc\\|php[s34]?\\|phtml\\)</span>")))
  :group 'php)

(defcustom php-mode-speedbar-open nil
  "<span class="quote">Normally `php-mode' starts with the speedbar closed.\
Turning this on will open it whenever `php-mode' is loaded.</span>"
  :type 'boolean
  :set (lambda (sym val)
         (set-default sym val)
         (when val
             (speedbar 1)))
  :group 'php)

(defcustom php-manual-url "<span class="quote">http://www.php.net/manual/en/</span>"
  "<span class="quote">URL at which to find PHP manual.\
You can replace \"en\" with your ISO language code.</span>"
  :type 'string
  :group 'php)

(defcustom php-search-url "<span class="quote">http://www.php.net/</span>"
  "<span class="quote">URL at which to search for documentation on a word</span>"
  :type 'string
  :group 'php)

(defcustom php-completion-file "<span class="quote"></span>"
  "<span class="quote">Path to the file which contains the function names known to PHP</span>"
  :type 'string
  :group 'php)

(defcustom php-manual-path "<span class="quote"></span>"
  "<span class="quote">Path to the directory which contains the PHP manual</span>"
  :type 'string
  :group 'php)

<span class="linecomment">;;;###autoload</span>
(defcustom php-mode-to-use
  (progn
    (require 'mumamo nil t)
    (if (fboundp 'nxhtml-mumamo-turn-on)
        'nxhtml-mumamo-turn-on
      (if (fboundp 'html-mumamo-turn-on)
          'html-mumamo-turn-on
        'php-mode)))
  "<span class="quote">Major mode turn on function to use for php files.</span>"
  :type 'function
  :group 'php)

<span class="linecomment">;;;###autoload</span>
(defcustom php-file-patterns '("<span class="quote">\\.php[s34]?\\'</span>" "<span class="quote">\\.phtml\\'</span>" "<span class="quote">\\.inc\\'</span>")
  "<span class="quote">List of file patterns for which to automatically invoke `php-mode'.</span>"
  :type '(repeat (regexp :tag "<span class="quote">Pattern</span>"))
  :set-after '(php-mode-to-use)
  :set (lambda (sym val)
         (set-default sym val)
         (let ((php-file-patterns-temp val))
           (while php-file-patterns-temp
             (add-to-list 'auto-mode-alist
                          (cons (car php-file-patterns-temp) php-mode-to-use))
             (setq php-file-patterns-temp (cdr php-file-patterns-temp)))))
  :group 'php)

(defcustom php-mode-hook nil
  "<span class="quote">List of functions to be executed on entry to `php-mode'.</span>"
  :type 'hook
  :group 'php)

(defcustom php-mode-pear-hook nil
  "<span class="quote">Hook called when a PHP PEAR file is opened with `php-mode'.</span>"
  :type 'hook
  :group 'php)

(defcustom php-mode-force-pear nil
  "<span class="quote">Normally PEAR coding rules are enforced only when the filename contains \"PEAR\"\
Turning this on will force PEAR rules on all PHP files.</span>"
  :type 'boolean
  :group 'php)

(defcustom php-mode-dollar-property-warning nil
  "<span class="quote">If non-`nil', warn about expressions like $foo-&gt;$bar where you
might have meant $foo-&gt;bar. Defaults to `nil' since this is valid
code.</span>"
  :type 'boolean
  :group 'php)

(defcustom php-mode-dot-property-warning nil
  "<span class="quote">If non-`nil', wan about expressions like $foo.bar, which could
be a valid concatenation (if bar were a constant, or interpreted
as an unquoted string), but it's more likely you meant $foo-&gt;bar.</span>"
  :type 'boolean
  :group 'php)

(defcustom php-mode-warn-on-unmatched nil
  "<span class="quote">If non-`nil', use `font-lock-warning-face' on any expression
that isn't matched by the other font lock regular expressions.</span>"
  :type 'boolean
  :group 'php)

(defcustom php-warn-if-mumamo-off t
  "<span class="quote">Warn once per buffer if you try to indent a buffer without
mumamo-mode turned on. Detects if there are any HTML tags in the
buffer before warning, but this is not very smart; e.g. if you
have any tags inside a PHP string, it will be fooled.</span>"
  :type '(choice (const :tag "<span class="quote">Warn</span>" t) (const "<span class="quote">Don't warn</span>" nil))
  :group 'php)

 
(eval-when-compile
  (defconst php-mode-modified
    (save-excursion
      (and
       (re-search-backward "<span class="quote">^;; Modified: \\(.*\\)</span>" nil 'noerror)
       (match-string-no-properties 1)))
    "<span class="quote">PHP Mode version number.</span>"))

(defun php-mode-version ()
  "<span class="quote">Display string describing the version of PHP mode</span>"
  (interactive)
  (message "<span class="quote">PHP mode %s of %s</span>"
           php-mode-version-number php-mode-modified))

(defconst php-beginning-of-defun-regexp
  "<span class="quote">^\\s *function\\s +&?\\(\\(\\sw\\|\\s_\\)+\\)\\s *(</span>"
  "<span class="quote">Regular expression for a PHP function.</span>")

(defun php-beginning-of-defun (&optional arg)
  "<span class="quote">Move to the beginning of the ARGth PHP function from point.
Implements PHP version of `beginning-of-defun-function'.</span>"
  (interactive "<span class="quote">p</span>")
  (let ((arg (or arg 1)))
    (while (&gt; arg 0)
      (re-search-backward php-beginning-of-defun-regexp
                          nil 'noerror)
      (setq arg (1- arg)))
    (while (&lt; arg 0)
      (end-of-line 1)
      (let ((opoint (point)))
        (beginning-of-defun 1)
        (forward-list 2)
        (forward-line 1)
        (if (eq opoint (point))
            (re-search-forward php-beginning-of-defun-regexp
                               nil 'noerror))
	(setq arg (1+ arg))))))

(defun php-end-of-defun (&optional arg)
  "<span class="quote">Move the end of the ARGth PHP function from point.
Implements PHP befsion of `end-of-defun-function'

See `php-beginning-of-defun'.</span>"
  (interactive "<span class="quote">p</span>")
  (php-beginning-of-defun (- (or arg 1))))

 
(defvar php-completion-table nil
  "<span class="quote">Obarray of tag names defined in current tags table and functions know to PHP.</span>")

(defvar php-warned-bad-indent nil)
<span class="linecomment">;;(make-variable-buffer-local 'php-warned-bad-indent)</span>

<span class="linecomment">;; Do it but tell it is not good if html tags in buffer.</span>
(defun php-check-html-for-indentation ()
  (let ((html-tag-re "<span class="quote">&lt;/?\\sw+.*?&gt;</span>")
        (here (point)))
    (if (not (or (re-search-forward html-tag-re (+ (point) 1000) t)
                 (re-search-backward html-tag-re (- (point) 1000) t)))
        t
      (goto-char here)
      (setq php-warned-bad-indent t)
      <span class="linecomment">;;(setq php-warned-bad-indent nil)</span>
      (let* ((known-multi-libs '(("<span class="quote">mumamo</span>" mumamo (lambda () (nxhtml-mumamo)))
                                 ("<span class="quote">mmm-mode</span>" mmm-mode (lambda () (mmm-mode 1)))
                                 ("<span class="quote">multi-mode</span>" multi-mode (lambda () (multi-mode 1)))))
             (known-names (mapcar (lambda (lib) (car lib)) known-multi-libs))
             (available-multi-libs (delq nil
                                         (mapcar
                                          (lambda (lib)
                                            (when (locate-library (car lib)) lib))
                                          known-multi-libs)))
             (available-names (mapcar (lambda (lib) (car lib)) available-multi-libs))
             (base-msg
              (concat
               "<span class="quote">Indentation fails badly with mixed HTML/PHP in plaín\n</span>"
               "<span class="quote">`php-mode'.  To get indentation to work you must use an Emacs\n</span>"
               "<span class="quote">library that supports 'multiple major modes' in a buffer.  Parts\n</span>"
               "<span class="quote">of the buffer will then be in `php-mode' and parts in for example\n</span>"
               "<span class="quote">`html-mode'.  Known such libraries are:\n\t</span>"
               (mapconcat 'identity known-names "<span class="quote">, </span>")
               "<span class="quote">\n</span>"
               (if available-multi-libs
                   (concat
                    "<span class="quote">You have these available in your `load-path':\n\t</span>"
                    (mapconcat 'identity available-names "<span class="quote">, </span>")
                    "<span class="quote">\n\n</span>"
                    "<span class="quote">Do you want to turn any of those on? </span>")
                 "<span class="quote">You do not have any of those in your `load-path'.</span>")))
             (is-using-multi
              (catch 'is-using
                (dolist (lib available-multi-libs)
                  (when (and (boundp (cadr lib))
                             (symbol-value (cadr lib)))
                    (throw 'is-using t))))))
        (unless is-using-multi
          (if available-multi-libs
              (if (not (y-or-n-p base-msg))
                  (message "<span class="quote">Did not do indentation, but you can try again now if you want</span>")
                (let* ((name
                        (if (= 1 (length available-multi-libs))
                            (car available-names)
                          <span class="linecomment">;; Minibuffer window is more than one line, fix that first:</span>
                          (message "<span class="quote"></span>")
                          (completing-read "<span class="quote">Choose multiple major mode support library: </span>"
                                           available-names nil t
                                           (car available-names)
                                           '(available-names . 1)
                                           )))
                       (mode (when name
                               (caddr (assoc name available-multi-libs)))))
                  (when mode
                    <span class="linecomment">;; Minibuffer window is more than one line, fix that first:</span>
                    (message "<span class="quote"></span>")
                    (load name)
                    (funcall mode))))
            (lwarn 'php-indent :warning base-msg)))
        nil))))

(defun php-cautious-indent-region (start end &optional quiet)
  (if (or (not php-warn-if-mumamo-off)
          php-warned-bad-indent
          (php-check-html-for-indentation))
      (funcall 'c-indent-region start end quiet)))

(defun php-cautious-indent-line ()
  (if (or (not php-warn-if-mumamo-off)
          php-warned-bad-indent
          (php-check-html-for-indentation))
      (funcall 'c-indent-line)))

<span class="linecomment">;;;###autoload</span>
(define-derived-mode php-mode c-mode "<span class="quote">PHP</span>"
  "<span class="quote">Major mode for editing PHP code.\n\n\\{php-mode-map}</span>"
<span class="linecomment">;;   (c-add-language 'php-mode 'c-mode)</span>

<span class="linecomment">;;   (c-lang-defconst c-block-stmt-1-kwds</span>
<span class="linecomment">;;     php php-block-stmt-1-kwds)</span>
  (set (make-local-variable 'c-block-stmt-1-key) php-block-stmt-1-key)

<span class="linecomment">;;   (c-lang-defconst c-block-stmt-2-kwds</span>
<span class="linecomment">;;     php php-block-stmt-2-kwds)</span>
  (set (make-local-variable 'c-block-stmt-2-key) php-block-stmt-2-key)
  <span class="linecomment">;; Specify that cc-mode recognize Javadoc comment style</span>
  (set (make-local-variable 'c-doc-comment-style)
    '((php-mode . javadoc)))

<span class="linecomment">;;   (c-lang-defconst c-class-decl-kwds</span>
<span class="linecomment">;;     php php-class-decl-kwds)</span>
  (set (make-local-variable 'c-class-key) php-class-key)

  <span class="linecomment">;; this line makes $ into punctuation instead of a word constituent</span>
  <span class="linecomment">;; it used to be active, but it killed indenting of case lines that</span>
  <span class="linecomment">;; begin with '$' (many do).  If anyone has a solution to this</span>
  <span class="linecomment">;; problem, please let me know.  Of course, you're welcome to</span>
  <span class="linecomment">;; uncomment this line in your installation.</span>
<span class="linecomment">;  (modify-syntax-entry ?$ "." php-mode-syntax-table)</span>

  <span class="linecomment">;; The above causes XEmacs to handle shell-style comments correctly,</span>
  <span class="linecomment">;; but fails to work in GNU Emacs which fails to interpret \n as the</span>
  <span class="linecomment">;; end of the comment.</span>
  (if (featurep 'xemacs) (progn
                (modify-syntax-entry ?# "<span class="quote">&lt; b</span>" php-mode-syntax-table)
                (modify-syntax-entry ?\n "<span class="quote">&gt; b</span>" php-mode-syntax-table)))

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '((php-font-lock-keywords-1
           php-font-lock-keywords-2
               <span class="linecomment">;; Comment-out the next line if the font-coloring is too</span>
               <span class="linecomment">;; extreme/ugly for you.</span>
           php-font-lock-keywords-3)
          nil                               <span class="linecomment">; KEYWORDS-ONLY</span>
          nil                                 <span class="linecomment">; CASE-FOLD</span>
          nil                               <span class="linecomment">; SYNTAX-ALIST</span>
          nil))                             <span class="linecomment">; SYNTAX-BEGIN</span>
  (modify-syntax-entry ?# "<span class="quote">&lt; b</span>" php-mode-syntax-table)
  (modify-syntax-entry ?_ "<span class="quote">w</span>" php-mode-syntax-table)

  <span class="linecomment">;; Electric behaviour must be turned off, they do not work since</span>
  <span class="linecomment">;; they can not find the correct syntax in embedded PHP.</span>
  <span class="linecomment">;;</span>
  <span class="linecomment">;; Seems to work with narrowing so let it be on if the user prefers it.</span>
  <span class="linecomment">;;(setq c-electric-flag nil)</span>

  (setq font-lock-maximum-decoration t
        case-fold-search t              <span class="linecomment">; PHP vars are case-sensitive</span>
        imenu-generic-expression php-imenu-generic-expression)

  <span class="linecomment">;; Do not force newline at end of file.  Such newlines can cause</span>
  <span class="linecomment">;; trouble if the PHP file is included in another file before calls</span>
  <span class="linecomment">;; to header() or cookie().</span>
  (set (make-local-variable 'require-final-newline) nil)
  (set (make-local-variable 'next-line-add-newlines) nil)

  <span class="linecomment">;; PEAR coding standards</span>
  (add-hook 'php-mode-pear-hook
            (lambda ()
              (set (make-local-variable 'tab-width) 4)
              (set (make-local-variable 'c-basic-offset) 4)
              (set (make-local-variable 'indent-tabs-mode) nil)
              (c-set-offset 'block-open' - )
              (c-set-offset 'block-close' 0 )) nil t)

  (if (or php-mode-force-pear
          (and (stringp buffer-file-name)
               (string-match "<span class="quote">PEAR\\|pear</span>"
                             (buffer-file-name))
               (string-match "<span class="quote">\\.php$</span>" (buffer-file-name))))
      (run-hooks 'php-mode-pear-hook))

  (setq indent-line-function 'php-cautious-indent-line)
  (setq indent-region-function 'php-cautious-indent-region)
  (setq c-special-indent-hook nil)

  (set (make-local-variable 'syntax-begin-function)
       'c-beginning-of-syntax)
  (set (make-local-variable 'beginning-of-defun-function)
       'php-beginning-of-defun)
  (set (make-local-variable 'end-of-defun-function)
       'php-end-of-defun)
  (set (make-local-variable 'open-paren-in-column-0-is-defun-start)
       nil)
  (set (make-local-variable 'defun-prompt-regexp)
       "<span class="quote">^\\s *function\\s +&?\\(\\(\\sw\\|\\s_\\)+\\)\\s *</span>")
  (set (make-local-variable 'add-log-current-defun-header-regexp)
       php-beginning-of-defun-regexp)

  (run-hooks 'php-mode-hook))
 
<span class="linecomment">;; Make a menu keymap (with a prompt string)</span>
<span class="linecomment">;; and make it the menu bar item's definition.</span>
(define-key php-mode-map [menu-bar] (make-sparse-keymap))
(define-key php-mode-map [menu-bar php]
  (cons "<span class="quote">PHP</span>" (make-sparse-keymap "<span class="quote">PHP</span>")))

<span class="linecomment">;; Define specific subcommands in this menu.</span>
(define-key php-mode-map [menu-bar php complete-function]
  '("<span class="quote">Complete function name</span>" . php-complete-function))
(define-key php-mode-map
  [menu-bar php browse-manual]
  '("<span class="quote">Browse manual</span>" . php-browse-manual))
(define-key php-mode-map
  [menu-bar php search-documentation]
  '("<span class="quote">Search documentation</span>" . php-search-documentation))
 
<span class="linecomment">;; Define function name completion function</span>
(defun php-complete-function ()
  "<span class="quote">Perform function completion on the text around point.
Completes to the set of names listed in the current tags table
and the standard php functions.
The string to complete is chosen in the same way as the default
for \\[find-tag] (which see).</span>"
  (interactive)
  (let ((pattern (php-get-pattern))
        beg
        completion
        (php-functions (php-completion-table)))
    (if (not pattern) (message "<span class="quote">Nothing to complete</span>")
        (search-backward pattern)
        (setq beg (point))
        (forward-char (length pattern))
        (setq completion (try-completion pattern php-functions nil))
        (cond ((eq completion t))
              ((null completion)
               (message "<span class="quote">Can't find completion for \"%s\"</span>" pattern)
               (ding))
              ((not (string= pattern completion))
               (delete-region beg (point))
               (insert completion))
              (t
               (message "<span class="quote">Making completion list...</span>")
               (with-output-to-temp-buffer "<span class="quote">*Completions*</span>"
                 (display-completion-list
                  (all-completions pattern php-functions)))
               (message "<span class="quote">Making completion list...%s</span>" "<span class="quote">done</span>"))))))

<span class="linecomment">;; Build php-completion-table on demand.  The table includes the</span>
<span class="linecomment">;; PHP functions and the tags from the current tags-file-name</span>
(defun php-completion-table ()
  (or (and tags-file-name
           (save-excursion (tags-verify-table tags-file-name))
           php-completion-table)
      (let ((tags-table
             (if (and tags-file-name
                      (functionp 'etags-tags-completion-table))
                 (with-current-buffer (get-file-buffer tags-file-name)
                   (etags-tags-completion-table))
               nil))
            (php-table
             (cond ((and (not (string= "<span class="quote"></span>" php-completion-file))
                         (file-readable-p php-completion-file))
                    (php-build-table-from-file php-completion-file))
                   (php-manual-path
                    (php-build-table-from-path php-manual-path))
                   (t nil))))
        (unless (or php-table tags-table)
          (error
           (concat "<span class="quote">No TAGS file active nor are </span>"
                   "<span class="quote">`php-completion-file' or `php-manual-path' set</span>")))
        (when tags-table
          <span class="linecomment">;; Combine the tables.</span>
          (mapatoms (lambda (sym) (intern (symbol-name sym) php-table))
                    tags-table))
        (setq php-completion-table php-table))))

(defun php-build-table-from-file (filename)
  (let ((table (make-vector 1022 0))
        (buf (find-file-noselect filename)))
    (save-excursion
      (set-buffer buf)
      (goto-char (point-min))
      (while (re-search-forward
              "<span class="quote">^\\([-a-zA-Z0-9_.]+\\)\n</span>"
              nil t)
        (intern (buffer-substring (match-beginning 1) (match-end 1))
                table)))
    (kill-buffer buf)
    table))

(defun php-build-table-from-path (path)
  (let ((table (make-vector 1022 0))
        (files (directory-files
                path
                nil
                "<span class="quote">^function\\..+\\.html$</span>")))
    (mapc (lambda (file)
            (string-match "<span class="quote">\\.\\([-a-zA-Z_0-9]+\\)\\.html$</span>" file)
            (intern
             (replace-regexp-in-string
              "<span class="quote">-</span>" "<span class="quote">_</span>" (substring file (match-beginning 1) (match-end 1)) t)
             table))
          files)
    table))

<span class="linecomment">;; Find the pattern we want to complete</span>
<span class="linecomment">;; find-tag-default from GNU Emacs etags.el</span>
(defun php-get-pattern ()
  (save-excursion
    (while (looking-at "<span class="quote">\\sw\\|\\s_</span>")
      (forward-char 1))
    (if (or (re-search-backward "<span class="quote">\\sw\\|\\s_</span>"
                                (save-excursion (beginning-of-line) (point))
                                t)
            (re-search-forward "<span class="quote">\\(\\sw\\|\\s_\\)+</span>"
                               (save-excursion (end-of-line) (point))
                               t))
        (progn (goto-char (match-end 0))
               (buffer-substring-no-properties
                (point)
                (progn (forward-sexp -1)
                       (while (looking-at "<span class="quote">\\s'</span>")
                         (forward-char 1))
                       (point))))
      nil)))


(defun php-show-arglist ()
  (interactive)
  (let* ((tagname (php-get-pattern)) arglist)
    (save-excursion
      (set-buffer (find-tag-noselect tagname nil nil))
      (goto-char (point-min))
      (when (re-search-forward
             (format "<span class="quote">function[ \t]+%s[ \t]*(\\([^{]*\\))</span>" tagname)
             nil t)
        (setq arglist (buffer-substring-no-properties
                       (match-beginning 1) (match-end 1)))))
    (if arglist
        (message "<span class="quote">Arglist for %s: %s</span>" tagname arglist)
      (message "<span class="quote">Unknown function: %s</span>" tagname))))
 
<span class="linecomment">;; Define function documentation function</span>
(defun php-search-documentation ()
  "<span class="quote">Search PHP documentation for the word at the point.</span>"
  (interactive)
  (browse-url (concat php-search-url (current-word t))))

<span class="linecomment">;; Define function for browsing manual</span>
(defun php-browse-manual ()
  "<span class="quote">Bring up manual for PHP.</span>"
  (interactive)
  (browse-url php-manual-url))

<span class="linecomment">;; Define shortcut</span>
(define-key php-mode-map
  "<span class="quote">\C-c\C-f</span>"
  'php-search-documentation)

<span class="linecomment">;; Define shortcut</span>
(define-key php-mode-map
  [(meta tab)]
  'php-complete-function)

<span class="linecomment">;; Define shortcut</span>
(define-key php-mode-map
  "<span class="quote">\C-c\C-m</span>"
  'php-browse-manual)

<span class="linecomment">;; Define shortcut</span>
(define-key php-mode-map
  '[(control .)]
  'php-show-arglist)
 
(defconst php-constants
  (eval-when-compile
    (regexp-opt
     '(<span class="linecomment">;; core constants</span>
       "<span class="quote">__LINE__</span>" "<span class="quote">__FILE__</span>"
       "<span class="quote">__FUNCTION__</span>" "<span class="quote">__CLASS__</span>" "<span class="quote">__METHOD__</span>"
       "<span class="quote">PHP_OS</span>" "<span class="quote">PHP_VERSION</span>"
       "<span class="quote">TRUE</span>" "<span class="quote">FALSE</span>" "<span class="quote">NULL</span>"
       "<span class="quote">E_ERROR</span>" "<span class="quote">E_NOTICE</span>" "<span class="quote">E_PARSE</span>" "<span class="quote">E_WARNING</span>" "<span class="quote">E_ALL</span>" "<span class="quote">E_STRICT</span>"
       "<span class="quote">E_USER_ERROR</span>" "<span class="quote">E_USER_WARNING</span>" "<span class="quote">E_USER_NOTICE</span>"
       "<span class="quote">DEFAULT_INCLUDE_PATH</span>" "<span class="quote">PEAR_INSTALL_DIR</span>" "<span class="quote">PEAR_EXTENSION_DIR</span>"
       "<span class="quote">PHP_BINDIR</span>" "<span class="quote">PHP_LIBDIR</span>" "<span class="quote">PHP_DATADIR</span>" "<span class="quote">PHP_SYSCONFDIR</span>"
       "<span class="quote">PHP_LOCALSTATEDIR</span>" "<span class="quote">PHP_CONFIG_FILE_PATH</span>"
       "<span class="quote">PHP_EOL</span>"

       <span class="linecomment">;; from ext/standard:</span>
       "<span class="quote">EXTR_OVERWRITE</span>" "<span class="quote">EXTR_SKIP</span>" "<span class="quote">EXTR_PREFIX_SAME</span>"
       "<span class="quote">EXTR_PREFIX_ALL</span>" "<span class="quote">EXTR_PREFIX_INVALID</span>" "<span class="quote">SORT_ASC</span>" "<span class="quote">SORT_DESC</span>"
       "<span class="quote">SORT_REGULAR</span>" "<span class="quote">SORT_NUMERIC</span>" "<span class="quote">SORT_STRING</span>" "<span class="quote">ASSERT_ACTIVE</span>"
       "<span class="quote">ASSERT_CALLBACK</span>" "<span class="quote">ASSERT_BAIL</span>" "<span class="quote">ASSERT_WARNING</span>"
       "<span class="quote">ASSERT_QUIET_EVAL</span>" "<span class="quote">CONNECTION_ABORTED</span>" "<span class="quote">CONNECTION_NORMAL</span>"
       "<span class="quote">CONNECTION_TIMEOUT</span>" "<span class="quote">M_E</span>" "<span class="quote">M_LOG2E</span>" "<span class="quote">M_LOG10E</span>" "<span class="quote">M_LN2</span>"
       "<span class="quote">M_LN10</span>" "<span class="quote">M_PI</span>" "<span class="quote">M_PI_2</span>" "<span class="quote">M_PI_4</span>" "<span class="quote">M_1_PI</span>" "<span class="quote">M_2_PI</span>"
       "<span class="quote">M_2_SQRTPI</span>" "<span class="quote">M_SQRT2</span>" "<span class="quote">M_SQRT1_2</span>" "<span class="quote">CRYPT_SALT_LENGTH</span>"
       "<span class="quote">CRYPT_STD_DES</span>" "<span class="quote">CRYPT_EXT_DES</span>" "<span class="quote">CRYPT_MD5</span>" "<span class="quote">CRYPT_BLOWFISH</span>"
       "<span class="quote">DIRECTORY_SEPARATOR</span>" "<span class="quote">SEEK_SET</span>" "<span class="quote">SEEK_CUR</span>" "<span class="quote">SEEK_END</span>"
       "<span class="quote">LOCK_SH</span>" "<span class="quote">LOCK_EX</span>" "<span class="quote">LOCK_UN</span>" "<span class="quote">LOCK_NB</span>" "<span class="quote">HTML_SPECIALCHARS</span>"
       "<span class="quote">HTML_ENTITIES</span>" "<span class="quote">ENT_COMPAT</span>" "<span class="quote">ENT_QUOTES</span>" "<span class="quote">ENT_NOQUOTES</span>"
       "<span class="quote">INFO_GENERAL</span>" "<span class="quote">INFO_CREDITS</span>" "<span class="quote">INFO_CONFIGURATION</span>"
       "<span class="quote">INFO_ENVIRONMENT</span>" "<span class="quote">INFO_VARIABLES</span>" "<span class="quote">INFO_LICENSE</span>" "<span class="quote">INFO_ALL</span>"
       "<span class="quote">CREDITS_GROUP</span>" "<span class="quote">CREDITS_GENERAL</span>" "<span class="quote">CREDITS_SAPI</span>"
       "<span class="quote">CREDITS_MODULES</span>" "<span class="quote">CREDITS_DOCS</span>" "<span class="quote">CREDITS_FULLPAGE</span>"
       "<span class="quote">CREDITS_QA</span>" "<span class="quote">CREDITS_ALL</span>" "<span class="quote">PHP_OUTPUT_HANDLER_START</span>"
       "<span class="quote">PHP_OUTPUT_HANDLER_CONT</span>" "<span class="quote">PHP_OUTPUT_HANDLER_END</span>"
       "<span class="quote">STR_PAD_LEFT</span>" "<span class="quote">STR_PAD_RIGHT</span>" "<span class="quote">STR_PAD_BOTH</span>"
       "<span class="quote">PATHINFO_DIRNAME</span>" "<span class="quote">PATHINFO_BASENAME</span>" "<span class="quote">PATHINFO_EXTENSION</span>"
       "<span class="quote">CHAR_MAX</span>" "<span class="quote">LC_CTYPE</span>" "<span class="quote">LC_NUMERIC</span>" "<span class="quote">LC_TIME</span>" "<span class="quote">LC_COLLATE</span>"
       "<span class="quote">LC_MONETARY</span>" "<span class="quote">LC_ALL</span>" "<span class="quote">LC_MESSAGES</span>" "<span class="quote">LOG_EMERG</span>" "<span class="quote">LOG_ALERT</span>"
       "<span class="quote">LOG_CRIT</span>" "<span class="quote">LOG_ERR</span>" "<span class="quote">LOG_WARNING</span>" "<span class="quote">LOG_NOTICE</span>" "<span class="quote">LOG_INFO</span>"
       "<span class="quote">LOG_DEBUG</span>" "<span class="quote">LOG_KERN</span>" "<span class="quote">LOG_USER</span>" "<span class="quote">LOG_MAIL</span>" "<span class="quote">LOG_DAEMON</span>"
       "<span class="quote">LOG_AUTH</span>" "<span class="quote">LOG_SYSLOG</span>" "<span class="quote">LOG_LPR</span>" "<span class="quote">LOG_NEWS</span>" "<span class="quote">LOG_UUCP</span>"
       "<span class="quote">LOG_CRON</span>" "<span class="quote">LOG_AUTHPRIV</span>" "<span class="quote">LOG_LOCAL0</span>" "<span class="quote">LOG_LOCAL1</span>"
       "<span class="quote">LOG_LOCAL2</span>" "<span class="quote">LOG_LOCAL3</span>" "<span class="quote">LOG_LOCAL4</span>" "<span class="quote">LOG_LOCAL5</span>"
       "<span class="quote">LOG_LOCAL6</span>" "<span class="quote">LOG_LOCAL7</span>" "<span class="quote">LOG_PID</span>" "<span class="quote">LOG_CONS</span>" "<span class="quote">LOG_ODELAY</span>"
       "<span class="quote">LOG_NDELAY</span>" "<span class="quote">LOG_NOWAIT</span>" "<span class="quote">LOG_PERROR</span>"

       <span class="linecomment">;; Disabled by default because they slow buffer loading</span>
       <span class="linecomment">;; If you have use for them, uncomment the strings</span>
       <span class="linecomment">;; that you want colored.</span>
       <span class="linecomment">;; To compile, you may have to increase 'max-specpdl-size'</span>

       <span class="linecomment">;; from other bundled extensions:</span>
<span class="linecomment">;        "CAL_EASTER_TO_xxx" "VT_NULL" "VT_EMPTY" "VT_UI1" "VT_I2"</span>
<span class="linecomment">;        "VT_I4" "VT_R4" "VT_R8" "VT_BOOL" "VT_ERROR" "VT_CY" "VT_DATE"</span>
<span class="linecomment">;        "VT_BSTR" "VT_DECIMAL" "VT_UNKNOWN" "VT_DISPATCH" "VT_VARIANT"</span>
<span class="linecomment">;        "VT_I1" "VT_UI2" "VT_UI4" "VT_INT" "VT_UINT" "VT_ARRAY"</span>
<span class="linecomment">;        "VT_BYREF" "CP_ACP" "CP_MACCP" "CP_OEMCP" "CP_SYMBOL"</span>
<span class="linecomment">;        "CP_THREAD_ACP" "CP_UTF7" "CP_UTF8" "CPDF_PM_NONE"</span>
<span class="linecomment">;        "CPDF_PM_OUTLINES" "CPDF_PM_THUMBS" "CPDF_PM_FULLSCREEN"</span>
<span class="linecomment">;        "CPDF_PL_SINGLE" "CPDF_PL_1COLUMN" "CPDF_PL_2LCOLUMN"</span>
<span class="linecomment">;        "CPDF_PL_2RCOLUMN" "CURLOPT_PORT" "CURLOPT_FILE"</span>
<span class="linecomment">;        "CURLOPT_INFILE" "CURLOPT_INFILESIZE" "CURLOPT_URL"</span>
<span class="linecomment">;        "CURLOPT_PROXY" "CURLOPT_VERBOSE" "CURLOPT_HEADER"</span>
<span class="linecomment">;        "CURLOPT_HTTPHEADER" "CURLOPT_NOPROGRESS" "CURLOPT_NOBODY"</span>
<span class="linecomment">;        "CURLOPT_FAILONERROR" "CURLOPT_UPLOAD" "CURLOPT_POST"</span>
<span class="linecomment">;        "CURLOPT_FTPLISTONLY" "CURLOPT_FTPAPPEND" "CURLOPT_NETRC"</span>
<span class="linecomment">;        "CURLOPT_FOLLOWLOCATION" "CURLOPT_FTPASCII" "CURLOPT_PUT"</span>
<span class="linecomment">;        "CURLOPT_MUTE" "CURLOPT_USERPWD" "CURLOPT_PROXYUSERPWD"</span>
<span class="linecomment">;        "CURLOPT_RANGE" "CURLOPT_TIMEOUT" "CURLOPT_POSTFIELDS"</span>
<span class="linecomment">;        "CURLOPT_REFERER" "CURLOPT_USERAGENT" "CURLOPT_FTPPORT"</span>
<span class="linecomment">;        "CURLOPT_LOW_SPEED_LIMIT" "CURLOPT_LOW_SPEED_TIME"</span>
<span class="linecomment">;        "CURLOPT_RESUME_FROM" "CURLOPT_COOKIE" "CURLOPT_SSLCERT"</span>
<span class="linecomment">;        "CURLOPT_SSLCERTPASSWD" "CURLOPT_WRITEHEADER"</span>
<span class="linecomment">;        "CURLOPT_COOKIEFILE" "CURLOPT_SSLVERSION"</span>
<span class="linecomment">;        "CURLOPT_TIMECONDITION" "CURLOPT_TIMEVALUE"</span>
<span class="linecomment">;        "CURLOPT_CUSTOMREQUEST" "CURLOPT_STDERR" "CURLOPT_TRANSFERTEXT"</span>
<span class="linecomment">;        "CURLOPT_RETURNTRANSFER" "CURLOPT_QUOTE" "CURLOPT_POSTQUOTE"</span>
<span class="linecomment">;        "CURLOPT_INTERFACE" "CURLOPT_KRB4LEVEL"</span>
<span class="linecomment">;        "CURLOPT_HTTPPROXYTUNNEL" "CURLOPT_FILETIME"</span>
<span class="linecomment">;        "CURLOPT_WRITEFUNCTION" "CURLOPT_READFUNCTION"</span>
<span class="linecomment">;        "CURLOPT_PASSWDFUNCTION" "CURLOPT_HEADERFUNCTION"</span>
<span class="linecomment">;        "CURLOPT_MAXREDIRS" "CURLOPT_MAXCONNECTS" "CURLOPT_CLOSEPOLICY"</span>
<span class="linecomment">;        "CURLOPT_FRESH_CONNECT" "CURLOPT_FORBID_REUSE"</span>
<span class="linecomment">;        "CURLOPT_RANDOM_FILE" "CURLOPT_EGDSOCKET"</span>
<span class="linecomment">;        "CURLOPT_CONNECTTIMEOUT" "CURLOPT_SSL_VERIFYPEER"</span>
<span class="linecomment">;        "CURLOPT_CAINFO" "CURLOPT_BINARYTRANSER"</span>
<span class="linecomment">;        "CURLCLOSEPOLICY_LEAST_RECENTLY_USED" "CURLCLOSEPOLICY_OLDEST"</span>
<span class="linecomment">;        "CURLINFO_EFFECTIVE_URL" "CURLINFO_HTTP_CODE"</span>
<span class="linecomment">;        "CURLINFO_HEADER_SIZE" "CURLINFO_REQUEST_SIZE"</span>
<span class="linecomment">;        "CURLINFO_TOTAL_TIME" "CURLINFO_NAMELOOKUP_TIME"</span>
<span class="linecomment">;        "CURLINFO_CONNECT_TIME" "CURLINFO_PRETRANSFER_TIME"</span>
<span class="linecomment">;        "CURLINFO_SIZE_UPLOAD" "CURLINFO_SIZE_DOWNLOAD"</span>
<span class="linecomment">;        "CURLINFO_SPEED_DOWNLOAD" "CURLINFO_SPEED_UPLOAD"</span>
<span class="linecomment">;        "CURLINFO_FILETIME" "CURLE_OK" "CURLE_UNSUPPORTED_PROTOCOL"</span>
<span class="linecomment">;        "CURLE_FAILED_INIT" "CURLE_URL_MALFORMAT"</span>
<span class="linecomment">;        "CURLE_URL_MALFORMAT_USER" "CURLE_COULDNT_RESOLVE_PROXY"</span>
<span class="linecomment">;        "CURLE_COULDNT_RESOLVE_HOST" "CURLE_COULDNT_CONNECT"</span>
<span class="linecomment">;        "CURLE_FTP_WEIRD_SERVER_REPLY" "CURLE_FTP_ACCESS_DENIED"</span>
<span class="linecomment">;        "CURLE_FTP_USER_PASSWORD_INCORRECT"</span>
<span class="linecomment">;        "CURLE_FTP_WEIRD_PASS_REPLY" "CURLE_FTP_WEIRD_USER_REPLY"</span>
<span class="linecomment">;        "CURLE_FTP_WEIRD_PASV_REPLY" "CURLE_FTP_WEIRD_227_FORMAT"</span>
<span class="linecomment">;        "CURLE_FTP_CANT_GET_HOST" "CURLE_FTP_CANT_RECONNECT"</span>
<span class="linecomment">;        "CURLE_FTP_COULDNT_SET_BINARY" "CURLE_PARTIAL_FILE"</span>
<span class="linecomment">;        "CURLE_FTP_COULDNT_RETR_FILE" "CURLE_FTP_WRITE_ERROR"</span>
<span class="linecomment">;        "CURLE_FTP_QUOTE_ERROR" "CURLE_HTTP_NOT_FOUND"</span>
<span class="linecomment">;        "CURLE_WRITE_ERROR" "CURLE_MALFORMAT_USER"</span>
<span class="linecomment">;        "CURLE_FTP_COULDNT_STOR_FILE" "CURLE_READ_ERROR"</span>
<span class="linecomment">;        "CURLE_OUT_OF_MEMORY" "CURLE_OPERATION_TIMEOUTED"</span>
<span class="linecomment">;        "CURLE_FTP_COULDNT_SET_ASCII" "CURLE_FTP_PORT_FAILED"</span>
<span class="linecomment">;        "CURLE_FTP_COULDNT_USE_REST" "CURLE_FTP_COULDNT_GET_SIZE"</span>
<span class="linecomment">;        "CURLE_HTTP_RANGE_ERROR" "CURLE_HTTP_POST_ERROR"</span>
<span class="linecomment">;        "CURLE_SSL_CONNECT_ERROR" "CURLE_FTP_BAD_DOWNLOAD_RESUME"</span>
<span class="linecomment">;        "CURLE_FILE_COULDNT_READ_FILE" "CURLE_LDAP_CANNOT_BIND"</span>
<span class="linecomment">;        "CURLE_LDAP_SEARCH_FAILED" "CURLE_LIBRARY_NOT_FOUND"</span>
<span class="linecomment">;        "CURLE_FUNCTION_NOT_FOUND" "CURLE_ABORTED_BY_CALLBACK"</span>
<span class="linecomment">;        "CURLE_BAD_FUNCTION_ARGUMENT" "CURLE_BAD_CALLING_ORDER"</span>
<span class="linecomment">;        "CURLE_HTTP_PORT_FAILED" "CURLE_BAD_PASSWORD_ENTERED"</span>
<span class="linecomment">;        "CURLE_TOO_MANY_REDIRECTS" "CURLE_UNKOWN_TELNET_OPTION"</span>
<span class="linecomment">;        "CURLE_TELNET_OPTION_SYNTAX" "CURLE_ALREADY_COMPLETE"</span>
<span class="linecomment">;        "DBX_MYSQL" "DBX_ODBC" "DBX_PGSQL" "DBX_MSSQL" "DBX_PERSISTENT"</span>
<span class="linecomment">;        "DBX_RESULT_INFO" "DBX_RESULT_INDEX" "DBX_RESULT_ASSOC"</span>
<span class="linecomment">;        "DBX_CMP_TEXT" "DBX_CMP_NUMBER" "XML_ELEMENT_NODE"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_NODE" "XML_TEXT_NODE" "XML_CDATA_SECTION_NODE"</span>
<span class="linecomment">;        "XML_ENTITY_REF_NODE" "XML_ENTITY_NODE" "XML_PI_NODE"</span>
<span class="linecomment">;        "XML_COMMENT_NODE" "XML_DOCUMENT_NODE" "XML_DOCUMENT_TYPE_NODE"</span>
<span class="linecomment">;        "XML_DOCUMENT_FRAG_NODE" "XML_NOTATION_NODE"</span>
<span class="linecomment">;        "XML_HTML_DOCUMENT_NODE" "XML_DTD_NODE" "XML_ELEMENT_DECL_NODE"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_DECL_NODE" "XML_ENTITY_DECL_NODE"</span>
<span class="linecomment">;        "XML_NAMESPACE_DECL_NODE" "XML_GLOBAL_NAMESPACE"</span>
<span class="linecomment">;        "XML_LOCAL_NAMESPACE" "XML_ATTRIBUTE_CDATA" "XML_ATTRIBUTE_ID"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_IDREF" "XML_ATTRIBUTE_IDREFS"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_ENTITY" "XML_ATTRIBUTE_NMTOKEN"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_NMTOKENS" "XML_ATTRIBUTE_ENUMERATION"</span>
<span class="linecomment">;        "XML_ATTRIBUTE_NOTATION" "XPATH_UNDEFINED" "XPATH_NODESET"</span>
<span class="linecomment">;        "XPATH_BOOLEAN" "XPATH_NUMBER" "XPATH_STRING" "XPATH_POINT"</span>
<span class="linecomment">;        "XPATH_RANGE" "XPATH_LOCATIONSET" "XPATH_USERS" "FBSQL_ASSOC"</span>
<span class="linecomment">;        "FBSQL_NUM" "FBSQL_BOTH" "FDFValue" "FDFStatus" "FDFFile"</span>
<span class="linecomment">;        "FDFID" "FDFFf" "FDFSetFf" "FDFClearFf" "FDFFlags" "FDFSetF"</span>
<span class="linecomment">;        "FDFClrF" "FDFAP" "FDFAS" "FDFAction" "FDFAA" "FDFAPRef"</span>
<span class="linecomment">;        "FDFIF" "FDFEnter" "FDFExit" "FDFDown" "FDFUp" "FDFFormat"</span>
<span class="linecomment">;        "FDFValidate" "FDFKeystroke" "FDFCalculate"</span>
<span class="linecomment">;        "FRIBIDI_CHARSET_UTF8" "FRIBIDI_CHARSET_8859_6"</span>
<span class="linecomment">;        "FRIBIDI_CHARSET_8859_8" "FRIBIDI_CHARSET_CP1255"</span>
<span class="linecomment">;        "FRIBIDI_CHARSET_CP1256" "FRIBIDI_CHARSET_ISIRI_3342"</span>
<span class="linecomment">;        "FTP_ASCII" "FTP_BINARY" "FTP_IMAGE" "FTP_TEXT" "IMG_GIF"</span>
<span class="linecomment">;        "IMG_JPG" "IMG_JPEG" "IMG_PNG" "IMG_WBMP" "IMG_COLOR_TILED"</span>
<span class="linecomment">;        "IMG_COLOR_STYLED" "IMG_COLOR_BRUSHED"</span>
<span class="linecomment">;        "IMG_COLOR_STYLEDBRUSHED" "IMG_COLOR_TRANSPARENT"</span>
<span class="linecomment">;        "IMG_ARC_ROUNDED" "IMG_ARC_PIE" "IMG_ARC_CHORD"</span>
<span class="linecomment">;        "IMG_ARC_NOFILL" "IMG_ARC_EDGED" "GMP_ROUND_ZERO"</span>
<span class="linecomment">;        "GMP_ROUND_PLUSINF" "GMP_ROUND_MINUSINF" "HW_ATTR_LANG"</span>
<span class="linecomment">;        "HW_ATTR_NR" "HW_ATTR_NONE" "IIS_READ" "IIS_WRITE"</span>
<span class="linecomment">;        "IIS_EXECUTE" "IIS_SCRIPT" "IIS_ANONYMOUS" "IIS_BASIC"</span>
<span class="linecomment">;        "IIS_NTLM" "NIL" "OP_DEBUG" "OP_READONLY" "OP_ANONYMOUS"</span>
<span class="linecomment">;        "OP_SHORTCACHE" "OP_SILENT" "OP_PROTOTYPE" "OP_HALFOPEN"</span>
<span class="linecomment">;        "OP_EXPUNGE" "OP_SECURE" "CL_EXPUNGE" "FT_UID" "FT_PEEK"</span>
<span class="linecomment">;        "FT_NOT" "FT_INTERNAL" "FT_PREFETCHTEXT" "ST_UID" "ST_SILENT"</span>
<span class="linecomment">;        "ST_SET" "CP_UID" "CP_MOVE" "SE_UID" "SE_FREE" "SE_NOPREFETCH"</span>
<span class="linecomment">;        "SO_FREE" "SO_NOSERVER" "SA_MESSAGES" "SA_RECENT" "SA_UNSEEN"</span>
<span class="linecomment">;        "SA_UIDNEXT" "SA_UIDVALIDITY" "SA_ALL" "LATT_NOINFERIORS"</span>
<span class="linecomment">;        "LATT_NOSELECT" "LATT_MARKED" "LATT_UNMARKED" "SORTDATE"</span>
<span class="linecomment">;        "SORTARRIVAL" "SORTFROM" "SORTSUBJECT" "SORTTO" "SORTCC"</span>
<span class="linecomment">;        "SORTSIZE" "TYPETEXT" "TYPEMULTIPART" "TYPEMESSAGE"</span>
<span class="linecomment">;        "TYPEAPPLICATION" "TYPEAUDIO" "TYPEIMAGE" "TYPEVIDEO"</span>
<span class="linecomment">;        "TYPEOTHER" "ENC7BIT" "ENC8BIT" "ENCBINARY" "ENCBASE64"</span>
<span class="linecomment">;        "ENCQUOTEDPRINTABLE" "ENCOTHER" "INGRES_ASSOC" "INGRES_NUM"</span>
<span class="linecomment">;        "INGRES_BOTH" "IBASE_DEFAULT" "IBASE_TEXT" "IBASE_UNIXTIME"</span>
<span class="linecomment">;        "IBASE_READ" "IBASE_COMMITTED" "IBASE_CONSISTENCY"</span>
<span class="linecomment">;        "IBASE_NOWAIT" "IBASE_TIMESTAMP" "IBASE_DATE" "IBASE_TIME"</span>
<span class="linecomment">;        "LDAP_DEREF_NEVER" "LDAP_DEREF_SEARCHING" "LDAP_DEREF_FINDING"</span>
<span class="linecomment">;        "LDAP_DEREF_ALWAYS" "LDAP_OPT_DEREF" "LDAP_OPT_SIZELIMIT"</span>
<span class="linecomment">;        "LDAP_OPT_TIMELIMIT" "LDAP_OPT_PROTOCOL_VERSION"</span>
<span class="linecomment">;        "LDAP_OPT_ERROR_NUMBER" "LDAP_OPT_REFERRALS" "LDAP_OPT_RESTART"</span>
<span class="linecomment">;        "LDAP_OPT_HOST_NAME" "LDAP_OPT_ERROR_STRING"</span>
<span class="linecomment">;        "LDAP_OPT_MATCHED_DN" "LDAP_OPT_SERVER_CONTROLS"</span>
<span class="linecomment">;        "LDAP_OPT_CLIENT_CONTROLS" "GSLC_SSL_NO_AUTH"</span>
<span class="linecomment">;        "GSLC_SSL_ONEWAY_AUTH" "GSLC_SSL_TWOWAY_AUTH" "MCAL_SUNDAY"</span>
<span class="linecomment">;        "MCAL_MONDAY" "MCAL_TUESDAY" "MCAL_WEDNESDAY" "MCAL_THURSDAY"</span>
<span class="linecomment">;        "MCAL_FRIDAY" "MCAL_SATURDAY" "MCAL_JANUARY" "MCAL_FEBRUARY"</span>
<span class="linecomment">;        "MCAL_MARCH" "MCAL_APRIL" "MCAL_MAY" "MCAL_JUNE" "MCAL_JULY"</span>
<span class="linecomment">;        "MCAL_AUGUST" "MCAL_SEPTEMBER" "MCAL_OCTOBER" "MCAL_NOVEMBER"</span>
<span class="linecomment">;        "MCAL_RECUR_NONE" "MCAL_RECUR_DAILY" "MCAL_RECUR_WEEKLY"</span>
<span class="linecomment">;        "MCAL_RECUR_MONTHLY_MDAY" "MCAL_RECUR_MONTHLY_WDAY"</span>
<span class="linecomment">;        "MCAL_RECUR_YEARLY" "MCAL_M_SUNDAY" "MCAL_M_MONDAY"</span>
<span class="linecomment">;        "MCAL_M_TUESDAY" "MCAL_M_WEDNESDAY" "MCAL_M_THURSDAY"</span>
<span class="linecomment">;        "MCAL_M_FRIDAY" "MCAL_M_SATURDAY" "MCAL_M_WEEKDAYS"</span>
<span class="linecomment">;        "MCAL_M_WEEKEND" "MCAL_M_ALLDAYS" "MCRYPT_" "MCRYPT_"</span>
<span class="linecomment">;        "MCRYPT_ENCRYPT" "MCRYPT_DECRYPT" "MCRYPT_DEV_RANDOM"</span>
<span class="linecomment">;        "MCRYPT_DEV_URANDOM" "MCRYPT_RAND" "SWFBUTTON_HIT"</span>
<span class="linecomment">;        "SWFBUTTON_DOWN" "SWFBUTTON_OVER" "SWFBUTTON_UP"</span>
<span class="linecomment">;        "SWFBUTTON_MOUSEUPOUTSIDE" "SWFBUTTON_DRAGOVER"</span>
<span class="linecomment">;        "SWFBUTTON_DRAGOUT" "SWFBUTTON_MOUSEUP" "SWFBUTTON_MOUSEDOWN"</span>
<span class="linecomment">;        "SWFBUTTON_MOUSEOUT" "SWFBUTTON_MOUSEOVER"</span>
<span class="linecomment">;        "SWFFILL_RADIAL_GRADIENT" "SWFFILL_LINEAR_GRADIENT"</span>
<span class="linecomment">;        "SWFFILL_TILED_BITMAP" "SWFFILL_CLIPPED_BITMAP"</span>
<span class="linecomment">;        "SWFTEXTFIELD_HASLENGTH" "SWFTEXTFIELD_NOEDIT"</span>
<span class="linecomment">;        "SWFTEXTFIELD_PASSWORD" "SWFTEXTFIELD_MULTILINE"</span>
<span class="linecomment">;        "SWFTEXTFIELD_WORDWRAP" "SWFTEXTFIELD_DRAWBOX"</span>
<span class="linecomment">;        "SWFTEXTFIELD_NOSELECT" "SWFTEXTFIELD_HTML"</span>
<span class="linecomment">;        "SWFTEXTFIELD_ALIGN_LEFT" "SWFTEXTFIELD_ALIGN_RIGHT"</span>
<span class="linecomment">;        "SWFTEXTFIELD_ALIGN_CENTER" "SWFTEXTFIELD_ALIGN_JUSTIFY"</span>
<span class="linecomment">;        "UDM_FIELD_URLID" "UDM_FIELD_URL" "UDM_FIELD_CONTENT"</span>
<span class="linecomment">;        "UDM_FIELD_TITLE" "UDM_FIELD_KEYWORDS" "UDM_FIELD_DESC"</span>
<span class="linecomment">;        "UDM_FIELD_DESCRIPTION" "UDM_FIELD_TEXT" "UDM_FIELD_SIZE"</span>
<span class="linecomment">;        "UDM_FIELD_RATING" "UDM_FIELD_SCORE" "UDM_FIELD_MODIFIED"</span>
<span class="linecomment">;        "UDM_FIELD_ORDER" "UDM_FIELD_CRC" "UDM_FIELD_CATEGORY"</span>
<span class="linecomment">;        "UDM_PARAM_PAGE_SIZE" "UDM_PARAM_PAGE_NUM"</span>
<span class="linecomment">;        "UDM_PARAM_SEARCH_MODE" "UDM_PARAM_CACHE_MODE"</span>
<span class="linecomment">;        "UDM_PARAM_TRACK_MODE" "UDM_PARAM_PHRASE_MODE"</span>
<span class="linecomment">;        "UDM_PARAM_CHARSET" "UDM_PARAM_STOPTABLE"</span>
<span class="linecomment">;        "UDM_PARAM_STOP_TABLE" "UDM_PARAM_STOPFILE"</span>
<span class="linecomment">;        "UDM_PARAM_STOP_FILE" "UDM_PARAM_WEIGHT_FACTOR"</span>
<span class="linecomment">;        "UDM_PARAM_WORD_MATCH" "UDM_PARAM_MAX_WORD_LEN"</span>
<span class="linecomment">;        "UDM_PARAM_MAX_WORDLEN" "UDM_PARAM_MIN_WORD_LEN"</span>
<span class="linecomment">;        "UDM_PARAM_MIN_WORDLEN" "UDM_PARAM_ISPELL_PREFIXES"</span>
<span class="linecomment">;        "UDM_PARAM_ISPELL_PREFIX" "UDM_PARAM_PREFIXES"</span>
<span class="linecomment">;        "UDM_PARAM_PREFIX" "UDM_PARAM_CROSS_WORDS"</span>
<span class="linecomment">;        "UDM_PARAM_CROSSWORDS" "UDM_LIMIT_CAT" "UDM_LIMIT_URL"</span>
<span class="linecomment">;        "UDM_LIMIT_TAG" "UDM_LIMIT_LANG" "UDM_LIMIT_DATE"</span>
<span class="linecomment">;        "UDM_PARAM_FOUND" "UDM_PARAM_NUM_ROWS" "UDM_PARAM_WORDINFO"</span>
<span class="linecomment">;        "UDM_PARAM_WORD_INFO" "UDM_PARAM_SEARCHTIME"</span>
<span class="linecomment">;        "UDM_PARAM_SEARCH_TIME" "UDM_PARAM_FIRST_DOC"</span>
<span class="linecomment">;        "UDM_PARAM_LAST_DOC" "UDM_MODE_ALL" "UDM_MODE_ANY"</span>
<span class="linecomment">;        "UDM_MODE_BOOL" "UDM_MODE_PHRASE" "UDM_CACHE_ENABLED"</span>
<span class="linecomment">;        "UDM_CACHE_DISABLED" "UDM_TRACK_ENABLED" "UDM_TRACK_DISABLED"</span>
<span class="linecomment">;        "UDM_PHRASE_ENABLED" "UDM_PHRASE_DISABLED"</span>
<span class="linecomment">;        "UDM_CROSS_WORDS_ENABLED" "UDM_CROSSWORDS_ENABLED"</span>
<span class="linecomment">;        "UDM_CROSS_WORDS_DISABLED" "UDM_CROSSWORDS_DISABLED"</span>
<span class="linecomment">;        "UDM_PREFIXES_ENABLED" "UDM_PREFIX_ENABLED"</span>
<span class="linecomment">;        "UDM_ISPELL_PREFIXES_ENABLED" "UDM_ISPELL_PREFIX_ENABLED"</span>
<span class="linecomment">;        "UDM_PREFIXES_DISABLED" "UDM_PREFIX_DISABLED"</span>
<span class="linecomment">;        "UDM_ISPELL_PREFIXES_DISABLED" "UDM_ISPELL_PREFIX_DISABLED"</span>
<span class="linecomment">;        "UDM_ISPELL_TYPE_AFFIX" "UDM_ISPELL_TYPE_SPELL"</span>
<span class="linecomment">;        "UDM_ISPELL_TYPE_DB" "UDM_ISPELL_TYPE_SERVER" "UDM_MATCH_WORD"</span>
<span class="linecomment">;        "UDM_MATCH_BEGIN" "UDM_MATCH_SUBSTR" "UDM_MATCH_END"</span>
<span class="linecomment">;        "MSQL_ASSOC" "MSQL_NUM" "MSQL_BOTH" "MYSQL_ASSOC" "MYSQL_NUM"</span>
<span class="linecomment">;        "MYSQL_BOTH" "MYSQL_USE_RESULT" "MYSQL_STORE_RESULT"</span>
<span class="linecomment">;        "OCI_DEFAULT" "OCI_DESCRIBE_ONLY" "OCI_COMMIT_ON_SUCCESS"</span>
<span class="linecomment">;        "OCI_EXACT_FETCH" "SQLT_BFILEE" "SQLT_CFILEE" "SQLT_CLOB"</span>
<span class="linecomment">;        "SQLT_BLOB" "SQLT_RDD" "OCI_B_SQLT_NTY" "OCI_SYSDATE"</span>
<span class="linecomment">;        "OCI_B_BFILE" "OCI_B_CFILEE" "OCI_B_CLOB" "OCI_B_BLOB"</span>
<span class="linecomment">;        "OCI_B_ROWID" "OCI_B_CURSOR" "OCI_B_BIN" "OCI_ASSOC" "OCI_NUM"</span>
<span class="linecomment">;        "OCI_BOTH" "OCI_RETURN_NULLS" "OCI_RETURN_LOBS"</span>
<span class="linecomment">;        "OCI_DTYPE_FILE" "OCI_DTYPE_LOB" "OCI_DTYPE_ROWID" "OCI_D_FILE"</span>
<span class="linecomment">;        "OCI_D_LOB" "OCI_D_ROWID" "ODBC_TYPE" "ODBC_BINMODE_PASSTHRU"</span>
<span class="linecomment">;        "ODBC_BINMODE_RETURN" "ODBC_BINMODE_CONVERT" "SQL_ODBC_CURSORS"</span>
<span class="linecomment">;        "SQL_CUR_USE_DRIVER" "SQL_CUR_USE_IF_NEEDED" "SQL_CUR_USE_ODBC"</span>
<span class="linecomment">;        "SQL_CONCURRENCY" "SQL_CONCUR_READ_ONLY" "SQL_CONCUR_LOCK"</span>
<span class="linecomment">;        "SQL_CONCUR_ROWVER" "SQL_CONCUR_VALUES" "SQL_CURSOR_TYPE"</span>
<span class="linecomment">;        "SQL_CURSOR_FORWARD_ONLY" "SQL_CURSOR_KEYSET_DRIVEN"</span>
<span class="linecomment">;        "SQL_CURSOR_DYNAMIC" "SQL_CURSOR_STATIC" "SQL_KEYSET_SIZE"</span>
<span class="linecomment">;        "SQL_CHAR" "SQL_VARCHAR" "SQL_LONGVARCHAR" "SQL_DECIMAL"</span>
<span class="linecomment">;        "SQL_NUMERIC" "SQL_BIT" "SQL_TINYINT" "SQL_SMALLINT"</span>
<span class="linecomment">;        "SQL_INTEGER" "SQL_BIGINT" "SQL_REAL" "SQL_FLOAT" "SQL_DOUBLE"</span>
<span class="linecomment">;        "SQL_BINARY" "SQL_VARBINARY" "SQL_LONGVARBINARY" "SQL_DATE"</span>
<span class="linecomment">;        "SQL_TIME" "SQL_TIMESTAMP" "SQL_TYPE_DATE" "SQL_TYPE_TIME"</span>
<span class="linecomment">;        "SQL_TYPE_TIMESTAMP" "SQL_BEST_ROWID" "SQL_ROWVER"</span>
<span class="linecomment">;        "SQL_SCOPE_CURROW" "SQL_SCOPE_TRANSACTION" "SQL_SCOPE_SESSION"</span>
<span class="linecomment">;        "SQL_NO_NULLS" "SQL_NULLABLE" "SQL_INDEX_UNIQUE"</span>
<span class="linecomment">;        "SQL_INDEX_ALL" "SQL_ENSURE" "SQL_QUICK"</span>
<span class="linecomment">;        "X509_PURPOSE_SSL_CLIENT" "X509_PURPOSE_SSL_SERVER"</span>
<span class="linecomment">;        "X509_PURPOSE_NS_SSL_SERVER" "X509_PURPOSE_SMIME_SIGN"</span>
<span class="linecomment">;        "X509_PURPOSE_SMIME_ENCRYPT" "X509_PURPOSE_CRL_SIGN"</span>
<span class="linecomment">;        "X509_PURPOSE_ANY" "PKCS7_DETACHED" "PKCS7_TEXT"</span>
<span class="linecomment">;        "PKCS7_NOINTERN" "PKCS7_NOVERIFY" "PKCS7_NOCHAIN"</span>
<span class="linecomment">;        "PKCS7_NOCERTS" "PKCS7_NOATTR" "PKCS7_BINARY" "PKCS7_NOSIGS"</span>
<span class="linecomment">;        "OPENSSL_PKCS1_PADDING" "OPENSSL_SSLV23_PADDING"</span>
<span class="linecomment">;        "OPENSSL_NO_PADDING" "OPENSSL_PKCS1_OAEP_PADDING"</span>
<span class="linecomment">;        "ORA_BIND_INOUT" "ORA_BIND_IN" "ORA_BIND_OUT"</span>
<span class="linecomment">;        "ORA_FETCHINTO_ASSOC" "ORA_FETCHINTO_NULLS"</span>
<span class="linecomment">;        "PREG_PATTERN_ORDER" "PREG_SET_ORDER" "PREG_SPLIT_NO_EMPTY"</span>
<span class="linecomment">;        "PREG_SPLIT_DELIM_CAPTURE"</span>
<span class="linecomment">;        "PGSQL_ASSOC" "PGSQL_NUM" "PGSQL_BOTH"</span>
<span class="linecomment">;        "PRINTER_COPIES" "PRINTER_MODE" "PRINTER_TITLE"</span>
<span class="linecomment">;        "PRINTER_DEVICENAME" "PRINTER_DRIVERVERSION"</span>
<span class="linecomment">;        "PRINTER_RESOLUTION_Y" "PRINTER_RESOLUTION_X" "PRINTER_SCALE"</span>
<span class="linecomment">;        "PRINTER_BACKGROUND_COLOR" "PRINTER_PAPER_LENGTH"</span>
<span class="linecomment">;        "PRINTER_PAPER_WIDTH" "PRINTER_PAPER_FORMAT"</span>
<span class="linecomment">;        "PRINTER_FORMAT_CUSTOM" "PRINTER_FORMAT_LETTER"</span>
<span class="linecomment">;        "PRINTER_FORMAT_LEGAL" "PRINTER_FORMAT_A3" "PRINTER_FORMAT_A4"</span>
<span class="linecomment">;        "PRINTER_FORMAT_A5" "PRINTER_FORMAT_B4" "PRINTER_FORMAT_B5"</span>
<span class="linecomment">;        "PRINTER_FORMAT_FOLIO" "PRINTER_ORIENTATION"</span>
<span class="linecomment">;        "PRINTER_ORIENTATION_PORTRAIT" "PRINTER_ORIENTATION_LANDSCAPE"</span>
<span class="linecomment">;        "PRINTER_TEXT_COLOR" "PRINTER_TEXT_ALIGN" "PRINTER_TA_BASELINE"</span>
<span class="linecomment">;        "PRINTER_TA_BOTTOM" "PRINTER_TA_TOP" "PRINTER_TA_CENTER"</span>
<span class="linecomment">;        "PRINTER_TA_LEFT" "PRINTER_TA_RIGHT" "PRINTER_PEN_SOLID"</span>
<span class="linecomment">;        "PRINTER_PEN_DASH" "PRINTER_PEN_DOT" "PRINTER_PEN_DASHDOT"</span>
<span class="linecomment">;        "PRINTER_PEN_DASHDOTDOT" "PRINTER_PEN_INVISIBLE"</span>
<span class="linecomment">;        "PRINTER_BRUSH_SOLID" "PRINTER_BRUSH_CUSTOM"</span>
<span class="linecomment">;        "PRINTER_BRUSH_DIAGONAL" "PRINTER_BRUSH_CROSS"</span>
<span class="linecomment">;        "PRINTER_BRUSH_DIAGCROSS" "PRINTER_BRUSH_FDIAGONAL"</span>
<span class="linecomment">;        "PRINTER_BRUSH_HORIZONTAL" "PRINTER_BRUSH_VERTICAL"</span>
<span class="linecomment">;        "PRINTER_FW_THIN" "PRINTER_FW_ULTRALIGHT" "PRINTER_FW_LIGHT"</span>
<span class="linecomment">;        "PRINTER_FW_NORMAL" "PRINTER_FW_MEDIUM" "PRINTER_FW_BOLD"</span>
<span class="linecomment">;        "PRINTER_FW_ULTRABOLD" "PRINTER_FW_HEAVY" "PRINTER_ENUM_LOCAL"</span>
<span class="linecomment">;        "PRINTER_ENUM_NAME" "PRINTER_ENUM_SHARED"</span>
<span class="linecomment">;        "PRINTER_ENUM_DEFAULT" "PRINTER_ENUM_CONNECTIONS"</span>
<span class="linecomment">;        "PRINTER_ENUM_NETWORK" "PRINTER_ENUM_REMOTE" "PSPELL_FAST"</span>
<span class="linecomment">;        "PSPELL_NORMAL" "PSPELL_BAD_SPELLERS" "PSPELL_RUN_TOGETHER"</span>
<span class="linecomment">;        "SID" "SID" "AF_UNIX" "AF_INET" "SOCK_STREAM" "SOCK_DGRAM"</span>
<span class="linecomment">;        "SOCK_RAW" "SOCK_SEQPACKET" "SOCK_RDM" "MSG_OOB" "MSG_WAITALL"</span>
<span class="linecomment">;        "MSG_PEEK" "MSG_DONTROUTE" "SO_DEBUG" "SO_REUSEADDR"</span>
<span class="linecomment">;        "SO_KEEPALIVE" "SO_DONTROUTE" "SO_LINGER" "SO_BROADCAST"</span>
<span class="linecomment">;        "SO_OOBINLINE" "SO_SNDBUF" "SO_RCVBUF" "SO_SNDLOWAT"</span>
<span class="linecomment">;        "SO_RCVLOWAT" "SO_SNDTIMEO" "SO_RCVTIMEO" "SO_TYPE" "SO_ERROR"</span>
<span class="linecomment">;        "SOL_SOCKET" "PHP_NORMAL_READ" "PHP_BINARY_READ"</span>
<span class="linecomment">;        "PHP_SYSTEM_READ" "SOL_TCP" "SOL_UDP" "MOD_COLOR" "MOD_MATRIX"</span>
<span class="linecomment">;        "TYPE_PUSHBUTTON" "TYPE_MENUBUTTON" "BSHitTest" "BSDown"</span>
<span class="linecomment">;        "BSOver" "BSUp" "OverDowntoIdle" "IdletoOverDown"</span>
<span class="linecomment">;        "OutDowntoIdle" "OutDowntoOverDown" "OverDowntoOutDown"</span>
<span class="linecomment">;        "OverUptoOverDown" "OverUptoIdle" "IdletoOverUp" "ButtonEnter"</span>
<span class="linecomment">;        "ButtonExit" "MenuEnter" "MenuExit" "XML_ERROR_NONE"</span>
<span class="linecomment">;        "XML_ERROR_NO_MEMORY" "XML_ERROR_SYNTAX"</span>
<span class="linecomment">;        "XML_ERROR_NO_ELEMENTS" "XML_ERROR_INVALID_TOKEN"</span>
<span class="linecomment">;        "XML_ERROR_UNCLOSED_TOKEN" "XML_ERROR_PARTIAL_CHAR"</span>
<span class="linecomment">;        "XML_ERROR_TAG_MISMATCH" "XML_ERROR_DUPLICATE_ATTRIBUTE"</span>
<span class="linecomment">;        "XML_ERROR_JUNK_AFTER_DOC_ELEMENT" "XML_ERROR_PARAM_ENTITY_REF"</span>
<span class="linecomment">;        "XML_ERROR_UNDEFINED_ENTITY" "XML_ERROR_RECURSIVE_ENTITY_REF"</span>
<span class="linecomment">;        "XML_ERROR_ASYNC_ENTITY" "XML_ERROR_BAD_CHAR_REF"</span>
<span class="linecomment">;        "XML_ERROR_BINARY_ENTITY_REF"</span>
<span class="linecomment">;        "XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF"</span>
<span class="linecomment">;        "XML_ERROR_MISPLACED_XML_PI" "XML_ERROR_UNKNOWN_ENCODING"</span>
<span class="linecomment">;        "XML_ERROR_INCORRECT_ENCODING"</span>
<span class="linecomment">;        "XML_ERROR_UNCLOSED_CDATA_SECTION"</span>
<span class="linecomment">;        "XML_ERROR_EXTERNAL_ENTITY_HANDLING" "XML_OPTION_CASE_FOLDING"</span>
<span class="linecomment">;        "XML_OPTION_TARGET_ENCODING" "XML_OPTION_SKIP_TAGSTART"</span>
<span class="linecomment">;        "XML_OPTION_SKIP_WHITE" "YPERR_BADARGS" "YPERR_BADDB"</span>
<span class="linecomment">;        "YPERR_BUSY" "YPERR_DOMAIN" "YPERR_KEY" "YPERR_MAP"</span>
<span class="linecomment">;        "YPERR_NODOM" "YPERR_NOMORE" "YPERR_PMAP" "YPERR_RESRC"</span>
<span class="linecomment">;        "YPERR_RPC" "YPERR_YPBIND" "YPERR_YPERR" "YPERR_YPSERV"</span>
<span class="linecomment">;        "YPERR_VERS" "FORCE_GZIP" "FORCE_DEFLATE"</span>

       <span class="linecomment">;; PEAR constants</span>
<span class="linecomment">;        "PEAR_ERROR_RETURN" "PEAR_ERROR_PRINT" "PEAR_ERROR_TRIGGER"</span>
<span class="linecomment">;        "PEAR_ERROR_DIE" "PEAR_ERROR_CALLBACK" "OS_WINDOWS" "OS_UNIX"</span>
<span class="linecomment">;        "PEAR_OS" "DB_OK" "DB_ERROR" "DB_ERROR_SYNTAX"</span>
<span class="linecomment">;        "DB_ERROR_CONSTRAINT" "DB_ERROR_NOT_FOUND"</span>
<span class="linecomment">;        "DB_ERROR_ALREADY_EXISTS" "DB_ERROR_UNSUPPORTED"</span>
<span class="linecomment">;        "DB_ERROR_MISMATCH" "DB_ERROR_INVALID" "DB_ERROR_NOT_CAPABLE"</span>
<span class="linecomment">;        "DB_ERROR_TRUNCATED" "DB_ERROR_INVALID_NUMBER"</span>
<span class="linecomment">;        "DB_ERROR_INVALID_DATE" "DB_ERROR_DIVZERO"</span>
<span class="linecomment">;        "DB_ERROR_NODBSELECTED" "DB_ERROR_CANNOT_CREATE"</span>
<span class="linecomment">;        "DB_ERROR_CANNOT_DELETE" "DB_ERROR_CANNOT_DROP"</span>
<span class="linecomment">;        "DB_ERROR_NOSUCHTABLE" "DB_ERROR_NOSUCHFIELD"</span>
<span class="linecomment">;        "DB_ERROR_NEED_MORE_DATA" "DB_ERROR_NOT_LOCKED"</span>
<span class="linecomment">;        "DB_ERROR_VALUE_COUNT_ON_ROW" "DB_ERROR_INVALID_DSN"</span>
<span class="linecomment">;        "DB_ERROR_CONNECT_FAILED" "DB_WARNING" "DB_WARNING_READ_ONLY"</span>
<span class="linecomment">;        "DB_PARAM_SCALAR" "DB_PARAM_OPAQUE" "DB_BINMODE_PASSTHRU"</span>
<span class="linecomment">;        "DB_BINMODE_RETURN" "DB_BINMODE_CONVERT" "DB_FETCHMODE_DEFAULT"</span>
<span class="linecomment">;        "DB_FETCHMODE_ORDERED" "DB_FETCHMODE_ASSOC"</span>
<span class="linecomment">;        "DB_FETCHMODE_FLIPPED" "DB_GETMODE_ORDERED" "DB_GETMODE_ASSOC"</span>
<span class="linecomment">;        "DB_GETMODE_FLIPPED" "DB_TABLEINFO_ORDER"</span>
<span class="linecomment">;        "DB_TABLEINFO_ORDERTABLE" "DB_TABLEINFO_FULL"</span>

       )))
  "<span class="quote">PHP constants.</span>")

(defconst php-keywords
  (eval-when-compile
    (regexp-opt
     <span class="linecomment">;; "class", "new" and "extends" get special treatment</span>
     <span class="linecomment">;; "case" and  "default" get special treatment elsewhere</span>
     '("<span class="quote">and</span>" "<span class="quote">as</span>" "<span class="quote">break</span>" "<span class="quote">continue</span>" "<span class="quote">declare</span>" "<span class="quote">do</span>" "<span class="quote">echo</span>" "<span class="quote">else</span>" "<span class="quote">elseif</span>"
       "<span class="quote">endfor</span>" "<span class="quote">endforeach</span>" "<span class="quote">endif</span>" "<span class="quote">endswitch</span>" "<span class="quote">endwhile</span>" "<span class="quote">exit</span>"
       "<span class="quote">extends</span>" "<span class="quote">for</span>" "<span class="quote">foreach</span>" "<span class="quote">global</span>" "<span class="quote">if</span>" "<span class="quote">include</span>" "<span class="quote">include_once</span>"
       "<span class="quote">next</span>" "<span class="quote">or</span>" "<span class="quote">require</span>" "<span class="quote">require_once</span>" "<span class="quote">return</span>" "<span class="quote">static</span>" "<span class="quote">switch</span>"
       "<span class="quote">then</span>" "<span class="quote">var</span>" "<span class="quote">while</span>" "<span class="quote">xor</span>" "<span class="quote">private</span>" "<span class="quote">throw</span>" "<span class="quote">catch</span>" "<span class="quote">try</span>"
       "<span class="quote">instanceof</span>" "<span class="quote">catch all</span>" "<span class="quote">finally</span>")))
  "<span class="quote">PHP keywords.</span>")

(defconst php-identifier
  (eval-when-compile
    '"<span class="quote">[a-zA-Z\_\x7f-\xff][a-zA-Z0-9\_\x7f-\xff]*</span>")
  "<span class="quote">Characters in a PHP identifier.</span>")

(defconst php-types
  (eval-when-compile
    (regexp-opt '("<span class="quote">array</span>" "<span class="quote">bool</span>" "<span class="quote">boolean</span>" "<span class="quote">char</span>" "<span class="quote">const</span>" "<span class="quote">double</span>" "<span class="quote">float</span>"
                  "<span class="quote">int</span>" "<span class="quote">integer</span>" "<span class="quote">long</span>" "<span class="quote">mixed</span>" "<span class="quote">object</span>" "<span class="quote">real</span>"
                  "<span class="quote">string</span>")))
  "<span class="quote">PHP types.</span>")

(defconst php-superglobals
  (eval-when-compile
    (regexp-opt '("<span class="quote">_GET</span>" "<span class="quote">_POST</span>" "<span class="quote">_COOKIE</span>" "<span class="quote">_SESSION</span>" "<span class="quote">_ENV</span>" "<span class="quote">GLOBALS</span>"
                  "<span class="quote">_SERVER</span>" "<span class="quote">_FILES</span>" "<span class="quote">_REQUEST</span>")))
  "<span class="quote">PHP superglobal variables.</span>")

<span class="linecomment">;; Set up font locking</span>
(defconst php-font-lock-keywords-1
  (list
   <span class="linecomment">;; Fontify constants</span>
   (cons
    (concat "<span class="quote">\\&lt;\\(</span>" php-constants "<span class="quote">\\)\\&gt;</span>")
    'font-lock-constant-face)

   <span class="linecomment">;; Fontify keywords</span>
   (cons
    (concat "<span class="quote">\\&lt;\\(</span>" php-keywords "<span class="quote">\\)\\&gt;</span>")
    'font-lock-keyword-face)

   <span class="linecomment">;; Fontify keywords and targets, and case default tags.</span>
   (list "<span class="quote">\\&lt;\\(break\\|case\\|continue\\)\\&gt;[ \t]*\\(-?\\(?:\\sw\\|\\s_\\)+\\)?</span>"
         '(1 font-lock-keyword-face) '(2 font-lock-constant-face t t))
   <span class="linecomment">;; This must come after the one for keywords and targets.</span>
   '("<span class="quote">:</span>" ("<span class="quote">^[ \t]*\\(\\(?:\\sw\\|\\s_\\)+\\)[ \t]*:[ \t]*$</span>"
          (beginning-of-line) (end-of-line)
          (1 font-lock-constant-face)))

   <span class="linecomment">;; treat 'print' as keyword only when not used like a function name</span>
   '("<span class="quote">\\&lt;print\\s-*(</span>" . php-default-face)
   '("<span class="quote">\\&lt;print\\&gt;</span>" . font-lock-keyword-face)

   <span class="linecomment">;; Fontify PHP tag</span>
   '("<span class="quote">&lt;\\?\\(php\\)?</span>" . font-lock-constant-face)
   '("<span class="quote">\\?&gt;</span>" . font-lock-constant-face)

   <span class="linecomment">;; Fontify ASP-style tag</span>
   '("<span class="quote">&lt;\\%\\(=\\)?</span>" . font-lock-constant-face)
   '("<span class="quote">\\%&gt;</span>" . font-lock-constant-face)

   )
  "<span class="quote">Subdued level highlighting for PHP mode.</span>")

(defconst php-font-lock-keywords-2
  (append
   php-font-lock-keywords-1
   (list

    <span class="linecomment">;; class declaration</span>
    '("<span class="quote">[^_]*\\&lt;\\(class\\|interface\\)[ \t]*\\(\\(?:\\sw\\|\\s_\\)+\\)?</span>"
      (1 font-lock-keyword-face) (2 font-lock-type-face nil t))
    <span class="linecomment">;; handle several words specially, to include following word,</span>
    <span class="linecomment">;; thereby excluding it from unknown-symbol checks later</span>
    <span class="linecomment">;; FIX to handle implementing multiple</span>
    <span class="linecomment">;; currently breaks on "class Foo implements Bar, Baz"</span>
    '("<span class="quote">\\&lt;\\(new\\|extends\\|implements\\)\\s-+\\$?\\(\\(?:\\sw\\|\\s_\\)+\\)</span>"
      (1 font-lock-keyword-face) (2 font-lock-type-face))

    <span class="linecomment">;; function declaration</span>
    '("<span class="quote">\\&lt;\\(function\\)\\s-+&?\\(\\(?:\\sw\\|\\s_\\)+\\)\\s-*(</span>"
      (1 font-lock-keyword-face)
      (2 font-lock-function-name-face nil t))

    <span class="linecomment">;; class hierarchy</span>
    '("<span class="quote">\\(self\\|parent\\)\\W</span>" (1 font-lock-constant-face nil nil))

    <span class="linecomment">;; method and variable features</span>
    '("<span class="quote">\\&lt;\\(private\\|protected\\|public\\)\\s-+\\$?\\(?:\\sw\\|\\s_\\)+</span>"
      (1 font-lock-keyword-face))

    <span class="linecomment">;; method features</span>
    '("<span class="quote">^[ \t]*\\(abstract\\|static\\|final\\)\\s-+\\$?\\(?:\\sw\\|\\s_\\)+</span>"
      (1 font-lock-keyword-face))

    <span class="linecomment">;; variable features</span>
    '("<span class="quote">^[ \t]*\\(static\\|const\\)\\s-+\\$?\\(?:\\sw\\|\\s_\\)+</span>"
      (1 font-lock-keyword-face))
    ))
  "<span class="quote">Medium level highlighting for PHP mode.</span>")

(defconst php-font-lock-keywords-3
  (append
   php-font-lock-keywords-2
   `(
     <span class="linecomment">;; &lt;word&gt; or &lt;/word&gt; for HTML</span>
     <span class="linecomment">;;'("&lt;/?\\sw+[^&gt; ]*&gt;" . font-lock-constant-face)</span>
     <span class="linecomment">;;'("&lt;/?\\sw+[^&gt;]*" . font-lock-constant-face)</span>
     <span class="linecomment">;;'("&lt;!DOCTYPE" . font-lock-constant-face)</span>
     ("<span class="quote">&lt;/?[a-z!:]+</span>" . font-lock-constant-face)

     <span class="linecomment">;; HTML &gt;</span>
     ("<span class="quote">&lt;[^&gt;]*\\(&gt;\\)</span>" (1 font-lock-constant-face))

     <span class="linecomment">;; HTML tags</span>
     ("<span class="quote">\\(&lt;[a-z]+\\)[[:space:]]+\\([a-z:]+=\\)[^&gt;]*?</span>" (1 font-lock-constant-face) (2 font-lock-constant-face) )
     ("<span class="quote">\"[[:space:]]+\\([a-z:]+=\\)</span>" (1 font-lock-constant-face))

     <span class="linecomment">;; HTML entities</span>
     <span class="linecomment">;;'("&\\w+;" . font-lock-variable-name-face)</span>

     <span class="linecomment">;; warn about '$' immediately after -&gt;</span>
     ,@(if php-mode-dollar-property-warning
           '("<span class="quote">\\$\\(?:\\sw\\|\\s_\\)+-&gt;\\s-*\\(\\$\\)\\(\\(?:\\sw\\|\\s_\\)+\\)</span>"
             (1 font-lock-warning-face) (2 php-default-face)))

     <span class="linecomment">;; warn about $word.word -- it could be a valid concatenation,</span>
     <span class="linecomment">;; but without any spaces we'll assume $word-&gt;word was meant.</span>
     ,@(if php-mode-dot-property-warning
           '("<span class="quote">\\$\\(?:\\sw\\|\\s_\\)+\\(\\.\\)\\sw</span>" 1 font-lock-warning-face))

     <span class="linecomment">;; Warn about ==&gt; instead of =&gt;</span>
     ("<span class="quote">==+&gt;</span>" . font-lock-warning-face)

     <span class="linecomment">;; exclude casts from bare-word treatment (may contain spaces)</span>
     (,(concat "<span class="quote">(\\s-*\\(</span>" php-types "<span class="quote">\\)\\s-*)</span>") 1 font-lock-type-face)

     <span class="linecomment">;; PHP5: function declarations may contain classes as parameters type</span>
     (,(concat
        "<span class="quote">[(,]\\s-*\\(\\(?:\\sw\\|\\s_\\)+\\)\\s-+&?\\$\\(?:\\sw\\|\\s_\\)+\\&gt;</span>")
      1 font-lock-type-face)

     <span class="linecomment">;; Fontify variables and function calls</span>
     ("<span class="quote">\\$\\(this\\|that\\)\\W</span>" (1 font-lock-constant-face nil nil))
     (,(concat "<span class="quote">\\$\\(</span>" php-superglobals "<span class="quote">\\)\\W</span>")
      (1 font-lock-constant-face nil nil)) <span class="linecomment">; $_GET & co</span>
     ("<span class="quote">\\$\\(\\(?:\\sw\\|\\s_\\)+\\)</span>" (1 font-lock-variable-name-face)) <span class="linecomment">; $variable</span>
     ("<span class="quote">-&gt;\\(\\(?:\\sw\\|\\s_\\)+\\)</span>" (1 font-lock-variable-name-face t t)) <span class="linecomment">; -&gt;variable</span>
     ("<span class="quote">-&gt;\\(\\(?:\\sw\\|\\s_\\)+\\)\\s-*(</span>" . (1 php-default-face t t)) <span class="linecomment">; -&gt;function_call</span>
     ("<span class="quote">\\(\\(?:\\sw\\|\\s_\\)+\\)::\\(?:\\sw\\|\\s_\\)+\\s-*(?</span>" . (1 font-lock-type-face)) <span class="linecomment">; class::member</span>
     ("<span class="quote">::\\(\\(?:\\sw\\|\\s_\\)+\\&gt;[^(]\\)</span>" . (1 php-default-face)) <span class="linecomment">; class::constant</span>
     ("<span class="quote">\\&lt;\\(?:\\sw\\|\\s_\\)+\\s-*[[(]</span>" . php-default-face) <span class="linecomment">; word( or word[</span>
     ("<span class="quote">\\&lt;[0-9]+</span>" . php-default-face)   <span class="linecomment">; number (also matches word)</span>

     <span class="linecomment">;; Warn on any words not already fontified</span>
     ,@(if php-mode-warn-on-unmatched
           '("<span class="quote">\\&lt;\\(?:\\sw\\|\\s_\\)+\\&gt;</span>" . font-lock-warning-face))

     )
   )
  "<span class="quote">Gauchy level highlighting for PHP mode.</span>")

<span class="linecomment">;; Define the imenu-generic-expression for PHP mode.</span>
<span class="linecomment">;; To use, execute M-x imenu, then click on Functions or Classes,</span>
<span class="linecomment">;; then select given function/class name to go to its definition.</span>
<span class="linecomment">;; [Contributed by Gerrit Riessen]</span>
(defvar php-imenu-generic-expression
 '(
   ("<span class="quote">All Functions</span>"
    "<span class="quote">^\\s-*function\\s-+\\([[:alnum:]_]+\\)\\s-*(</span>" 1)
   ("<span class="quote">Classes</span>"
    "<span class="quote">^\\s-*class\\s-+\\([[:alnum:]_]+\\)\\s-*</span>" 1)
   ("<span class="quote">Public Methods</span>"
    "<span class="quote">^\\s-*public function\\s-+\\([[:alnum:]_]+\\)\\s-*(</span>" 1)
   ("<span class="quote">Protected Methods</span>"
    "<span class="quote">^\\s-*protected function\\s-+\\([[:alnum:]_]+\\)\\s-*(</span>" 1)
   ("<span class="quote">Private Methods</span>"
    "<span class="quote">^\\s-*private function\\s-+\\([[:alnum:]_]+\\)\\s-*(</span>" 1)
   )
 "<span class="quote">Imenu generic expression for PHP Mode. See `imenu-generic-expression'.</span>"
 )

(defconst php-block-stmt-1-kwds '("<span class="quote">do</span>" "<span class="quote">else</span>" "<span class="quote">finally</span>" "<span class="quote">try</span>"))
(defconst php-block-stmt-2-kwds
  '("<span class="quote">for</span>" "<span class="quote">if</span>" "<span class="quote">while</span>" "<span class="quote">switch</span>" "<span class="quote">foreach</span>" "<span class="quote">elseif</span>"  "<span class="quote">catch all</span>"))

(defconst php-block-stmt-1-key
  (regexp-opt php-block-stmt-1-kwds))
(defconst php-block-stmt-2-key
  (regexp-opt php-block-stmt-2-kwds))

(defconst php-class-decl-kwds '("<span class="quote">class</span>" "<span class="quote">interface</span>"))

(defconst php-class-key
  (concat
   "<span class="quote">\\(</span>" (regexp-opt php-class-decl-kwds) "<span class="quote">\\)\\s +</span>"
   c-symbol-key                                 <span class="linecomment">;; Class name.</span>
   "<span class="quote">\\(\\s *extends\\s *</span>" c-symbol-key "<span class="quote">\\)?</span>"   <span class="linecomment">;; Name of superclass.</span>
   "<span class="quote">\\(\\s *implements *[^{]+{\\)?</span>")) <span class="linecomment">;; List of any adopted protocols.</span>

<span class="linecomment">;; Create "php-default-face" symbol for GNU Emacs so that both XEmacs</span>
<span class="linecomment">;; and GNU emacs can refer to the default face.</span>
(unless (boundp 'php-default-face)
   (defvar php-default-face 'php-default-face))

<span class="linecomment">;; Create faces for XEmacs</span>
(when (featurep 'xemacs)
  (unless (boundp 'font-lock-keyword-face)
    (copy-face 'bold 'font-lock-keyword-face))
  (unless (boundp 'font-lock-constant-face)
    (copy-face 'font-lock-keyword-face 'font-lock-constant-face)))

(provide 'php-mode)

<span class="linecomment">;;; php-mode.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=php-mode-improved.el;missing=de_en_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=php-mode-improved.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=php-mode-improved.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=php-mode-improved.el">Administration</a></span><span class="time"><br /> Last edited 2008-09-01 21:44 UTC by <a class="author" title="from host86-132-139-157.range86-132.btcentralplus.com" href="http://www.emacswiki.org/emacs/DavidHouse">DavidHouse</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=php-mode-improved.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
