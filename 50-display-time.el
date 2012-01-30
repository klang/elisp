;;; Display-time-format

(display-time); enable the showing of time and appointments
(setq display-time-24hr-format t); 24hr format string in mode-line
(setq display-time-day-and-date t); display both day and date in modeline

(if (include 'time-stamp)
    (if (not (memq 'time-stamp write-file-hooks))
	(setq write-file-hooks (cons 'time-stamp write-file-hooks))))
