(provide 'editor)

(use-package smooth-scrolling
  :ensure t)

(use-package auto-complete
  :ensure t)

;; This removes auto-indentation when adding newline in fundemental-mode
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; Type "y"/"n" instead of "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable cliboard
(setq x-select-enable-clipboard t)

;; Shut up compile saves
(setq compilation-ask-about-save nil)

;; Disable auto-save
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Always hs-minor
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; Auto-complete
(global-auto-complete-mode t)

;; Enable ido everywhere
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Mouse settings
(xterm-mouse-mode t)
(setq scroll-margin 1
	  scroll-conservatively 0
	  scroll-up-aggressively 0.01
	  scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
			  scroll-down-aggressively 0.01)
