(provide 'key-bindings)

(use-package fold-dwim
  :ensure t)

(global-set-key [f12] 'compile)

;; Sizing windows
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;; Show/hide blocks
(global-set-key(kbd "C-c H") 'hs-hide-all)
(global-set-key(kbd "C-c h") 'hs-hide-block)
(global-set-key(kbd "C-c S") 'hs-show-all)
(global-set-key(kbd "C-c s") 'hs-show-block)

;; Region commenting
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
