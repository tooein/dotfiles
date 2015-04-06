(provide 'editor)

(use-package auto-complete
  :ensure t)

(setq whitespace-mode '(face trailing tab-mark))
;;(setq-default show-trailing-whitespace t)

;; Press f11 for full screen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
										   nil
										 'fullboth)))
(global-set-key [f11] 'toggle-fullscreen)

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

(global-set-key [f12] 'compile)
