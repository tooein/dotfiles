(provide 'colors)

;(set-face-background 'hl-line "#3e4446")
(set-face-background 'hl-line "#222")
(set-face-attribute 'region nil :background "#555")

;; for a construct that is peculiar, or that greatly changes the meaning of other text, like ‘;;;###autoload’ in Emacs Lisp and ‘#error’ in C.
(set-face-attribute 'font-lock-warning-face nil :foreground "#ff0000")

;;for the name of a function being defined or declared.
;(set-face-attribute 'font-lock-function-name-face nil :foreground "#bb0000")
(set-face-attribute 'font-lock-function-name-face nil :foreground "#db0000")

;;for the name of a variable being defined or declared.
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#00ff00")

;;for a keyword with special syntactic significance, like ‘for’ and ‘if’ in C.
;(set-face-attribute 'font-lock-keyword-face nil :foreground "#104ebb")
(set-face-attribute 'font-lock-keyword-face nil :foreground "#9933cc")

;;for comments.
(set-face-attribute 'font-lock-comment-face nil :foreground "#a9a9a9")

;;for comments delimiters, like ‘/*’ and ‘*/’ in C. On most terminals, this inherits from font-lock-comment-face.
font-lock-comment-delimiter-face

;;for the names of user-defined data types.
(set-face-attribute 'font-lock-type-face nil :foreground "#00ff00")

;;for the names of constants, like ‘NULL’ in C.
(set-face-attribute 'font-lock-constant-face nil :foreground "#00ff00")

;;for the names of built-in functions.
(set-face-attribute 'font-lock-builtin-face nil :foreground "#db0000")

;;for preprocessor commands. This inherits, by default, from font-lock-builtin-face.
font-lock-preprocessor-face

;;for string constants.
(set-face-attribute 'font-lock-string-face nil :foreground "#00ff00")

;;for documentation strings in the code. This inherits, by default, from font-lock-string-face.
font-lock-doc-face

;;for easily-overlooked negation characters. 
font-lock-negation-char-face
