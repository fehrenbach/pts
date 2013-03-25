(defvar pts-mode-hook nil)

(defvar pts-mode-map
  (let ((map (make-keymap))) ; or make-sparse-keymap
    ;; (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for PTS major mode")


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lpts\\'" . pts-mode))

(defconst pts-mode-font-lock-keywords
  `(
    (,(regexp-opt '("lambda" "Pi" "if0" "then" "else" "assert" "module")) . font-lock-builtin-face)
    (,(regexp-opt '("Int")) . font-lock-type-face)))

(defvar pts-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\; ".1")
    (modify-syntax-entry ?\n ".2")
    (modify-syntax-entry ?> ".3" st)
    (modify-syntax-entry ?\  ".4b" st)
    st)
  "Syntax table for PTS major mode")

(defun pts-mode ()
  "Major mode for editing PTS files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table pts-mode-syntax-table)
  (use-local-map pts-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(pts-mode-font-lock-keywords))
  (setq major-mode 'pts-mode)
  (setq mode-name "PTS")
  (run-hooks 'pts-mode-hook))

(provide 'pts-mode)
