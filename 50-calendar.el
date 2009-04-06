;;; Setup calendar
(setq european-calendar-style t)        ; alternate calendar style
(setq calendar-week-start-day 1)        ; let weeks start on mondays
(setq mark-diary-entries-in-calendar t) ; markup dates with appt's
(setq mark-calendar-holidays t)         ; show holiday
(setq view-diary-entries-initially t)   ; also show diary entries
(add-hook 'mark-diary-entries-hook
	  'mark-included-diary-files)	; do
					; #include on diary files,
					; when they are marked
