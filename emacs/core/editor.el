(provide 'editor)

(use-package smooth-scrolling
  :ensure t)

(use-package auto-complete
  :ensure t)

;; This removes auto-indentation when adding newline in fundemental-mode
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)

;; Shut up compile saves
(setq compilation-ask-about-save nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(global-auto-complete-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(xterm-mouse-mode t)
(setq scroll-margin 1
	  scroll-conservatively 0
	  scroll-up-aggressively 0.01
	  scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
			  scroll-down-aggressively 0.01)

;; TODO:
; Spellchecker
; Whitespace
; Skeletons
; Automatic org-mode detection on .md files
