(provide 'editor)

(use-package auto-complete
  :ensure t)

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
