(provide 'language)

;; Indentation
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; C-indentation
(setq-default c-basic-offset 4)
(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t)

(autoload 'go-mode "go-mode" "Golang editing mode." t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
