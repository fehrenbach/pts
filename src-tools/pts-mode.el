;;; Programmatic font locking

(require 'cl)

(defmacro comment (&rest body) nil)

;; example stmt:
(comment assert (lambda (x) (inc x))(5) = 5 + 1 : inc function does stupid things)
;; and it's colouring
(defvar example nil)
(setq example
      '(((110 . 116) assert)
        ((118 . 124) lambda)
        ((126 . 127) (var-dec x1))
        ((135 . 138) (var-ref inc2))
        ((139 . 140) (var-ref x1))
        ((149 . 182) doc) ;; 149 is the colon
;;        ((151 . 182) . string)
        ))

(defun select-face (kind)
  (pcase (first kind)
    (`assert font-lock-builtin-face)
    (`string font-lock-string-face)
    (`doc font-lock-doc-face)
    (`(var-dec ,ref) font-lock-variable-name-face)))

(defun fontify-accordingly (list)
  (loop for ((min . max) . kind) in list
        for face = (select-face kind)
        initially (remove-text-properties (point-min) (point-max) '(font-lock-face))
        when face
        do (put-text-property min max 'font-lock-face face)))

(fontify-accordingly example)

;;(run-with-idle-timer 1 :repeat (lambda () (fontify-accordingly example)))

;;; PTS mode

(defvar pts-mode-hook nil)

(defvar pts-mode-map
  (let ((map (make-keymap))) ; or make-sparse-keymap
    ;; (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for PTS major mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lpts\\'" . pts-mode))

(defun pts-mode ()
  "Major mode for editing PTS files"
  (interactive)
  (kill-all-local-variables)
  (use-local-map pts-mode-map)
  (setq major-mode 'pts-mode)
  (setq mode-name "PTS")
  (run-hooks 'pts-mode-hook))

(provide 'pts-mode)
