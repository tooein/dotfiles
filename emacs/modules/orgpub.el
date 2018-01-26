;; From http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html

(provide 'orgpub)

; ----------
; Publish
; ----------

(require 'ox-publish)
(setq org-publish-project-alist
      '(

	("org-notes"
	 :base-directory "~/projects/notes/org"
	 :base-extension "org"
	 :publishing-directory "~/projects/notes/public"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
	 :auto-preamble t
	 )

	("org-static"
	 :base-directory "~/projects/notes/org"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|jpe"
	 :publishing-directory "~/projects/notes/public"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )

	("org" :components ("org-notes" "org-static"))

	))

; ----------
; Inline modeling
; ----------

(setq org-ditaa-jar-path "~/git/org-mode/contrib/scripts/ditaa.jar")
(setq org-plantuml-jar-path "~/java/plantuml.jar")

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

; ----------
; Sitemap
; ----------

:auto-sitemap t                ; Generate sitemap.org automagically...
:sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
:sitemap-title "Sitemap"         ; ... with title 'Sitemap'.

; ----------
; CSS
; ----------

(setq org-export-html-style-include-scripts nil
      org-export-html-style-include-default nil)
