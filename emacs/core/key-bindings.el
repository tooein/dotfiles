(provide 'key-bindings)

(use-package fold-dwim
  :ensure t)

(global-set-key [f12] 'compile)

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key(kbd "C-c H") 'hs-hide-all)
(global-set-key(kbd "C-c h") 'hs-hide-block)
(global-set-key(kbd "C-c S") 'hs-show-all)
(global-set-key(kbd "C-c s") 'hs-show-block)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

(global-set-key [(hyper h)] 'help-command)

(setq normal-erase-is-backspace-mode t)
