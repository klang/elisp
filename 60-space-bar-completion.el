;; this enables the "space-bar" file name completion.
(when (boundp 'minibuffer-local-filename-completion-map)
      (define-key minibuffer-local-filename-completion-map " " 'minibuffer-complete-word)
      (define-key minibuffer-local-must-match-filename-map " " 'minibuffer-complete-word))
