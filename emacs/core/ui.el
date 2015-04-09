(provide 'ui)

(use-package linum
  :ensure t)

(menu-bar-mode -1)
(if window-system
    (tool-bar-mode -1))
(tooltip-mode -1)

(global-hl-line-mode 1)

;; Highlight FIXME, TODO and BUG
(add-hook  'prog-mode-hook
		   (lambda ()
			 (font-lock-add-keywords nil
									 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; Linums
(global-linum-mode)
(defvar my-linum-format-string "%2d")
(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)
(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
							 (count-lines (point-min) (point-max))))))
		 (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))
(defvar my-linum-current-line-number 0)

;; Font
(set-face-attribute 'default nil :family "Consolata" :height 105)

;; Show column number
(setq column-number-mode t)

;; Turn off welcome screen
(setq inhibit-startup-message t)

;; Turn on parentheses highlighting
(show-paren-mode)

;; Turn on highlight changes
(highlight-changes-mode t)
