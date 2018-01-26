(setq default-directory "~/.emacs.d/")

;; Load modules
(add-to-list 'load-path (expand-file-name "./modules/" default-directory))

(eval-when-compile (require 'use-package))

;; Add package archieves
(package-initialize)
(add-to-list
 'package-archives
 '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Only automatically refresh package contents the first time.
(when (not package-archive-contents) (package-refresh-contents))

;; Load custom functionalities
(add-to-list 'load-path (expand-file-name "./core/" default-directory))
(require 'key-bindings)
(require 'editor)
(require 'ui)

;; Load modes
(add-to-list 'load-path (expand-file-name "./modes/" default-directory))

;(add-hook 'org-mode-hook '(require 'orgpub))
(require 'org)
(require 'orgpub)
(setq org-wikinodes-scope 'directory)


(require 'language)
(require 'colors)

(require 'android-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-sdk-dir "/opt/android-sdk/")
 '(package-selected-packages
   (quote
	(## smooth-scrolling scala-mode langtool fold-dwim auto-complete android-mode))))

(add-to-list 'load-path ".modules")
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list ".modes")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -- latex stuff (move this)
(setq exec-path (append exec-path '("/usr/bin")))
(load "auctex.el" nil t t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 

(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)))

