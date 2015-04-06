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

(require 'language)
