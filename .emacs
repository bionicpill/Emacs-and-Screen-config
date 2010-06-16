;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Set all tabs to use spaces only
(setq-default indent-tabs-mode nil)

;; Line numbering stuff
(require 'linum)
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; Startup stuff for screen etc...
;;(server-start)
(add-hook 'after-init-hook 'server-start)
(add-hook 'server-done-hook
          (lambda ()
            (shell-command
             "screen -r -X select `cat ~/tmp/emacsclient-caller`")))

;; My personal lisp files
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Terminal issues
(define-key function-key-map "\e[3~" [delete])
(defun fixup-ma-terminal ()
  (if (not (key-binding [delete]))
       (global-set-key [delete] #'delete-char)))
(add-hook 'term-setup-hook #'fixup-ma-terminal)

;; Whitespace
(require 'whitespace)

;; C mode settings
(defun custom-c-mode-hook ()
  ;; set the case label indent after a switch statement
  (c-set-offset 'case-label '+)
)
(add-hook 'c++-mode-hook 'custom-c-mode-hook)
(add-hook 'c-mode-hook 'custom-c-mode-hook)

;; Override C style settings for Java mode
(defun custom-java-mode-hook ()
  (setq c-basic-offset 2)
  (c-set-offset 'case-label '+))
(add-hook 'java-mode-hook 'custom-java-mode-hook)

;; Javascript Mode
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(setq espresso-indent-level 2)

;; SQL
(defun custom-sql-mode-hook ()
  (setq tab-width 4))
(add-hook 'sql-mode-hook 'custom-sql-mode-hook)

;; CSS
(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))
(defun custom-css-mode-hook ()
  (setq css-indent-offset 2))
(add-hook 'css-mode-hook 'custom-css-mode-hook)

;; SGML based languages
(autoload 'sgml-mode "sgml-mode" "Mode for editing SGML" t)
(add-to-list 'auto-mode-alist '("\\.ejs$" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . sgml-mode))

;; git
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/git")

;; Yaml
(require 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ruby
;; based on http://www.rubygarden.org/Ruby/page/show/InstallingEmacsExtensions
(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby")

 (autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
 ;; If you have Emacs 19.2x or older, use rubydb2x
 (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
 ;; uncomment the next line if you want syntax highlighting
 (add-hook 'ruby-mode-hook 'turn-on-font-lock)

;; Custom font faces
(custom-set-faces
 '(diff-added ((t (:foreground "lime green"))) 'now)
 '(diff-changed ((t (:foreground "orange"))) 'now)
 '(diff-context ((t (:foreground "Black"))) 'now)
 '(diff-file-header ((t (:foreground "magenta"))) 'now)
 ;; '(diff-function ((t (:foreground "Orange"))) 'now)
 '(diff-header ((t (:foreground "cyan"))) 'now)
 '(diff-hunk-header ((t (:foreground "orange"))) 'now)
 '(diff-index ((t (:foreground "Green"))) 'now)
 '(diff-nonexistent ((t (:foreground "DarkBlue"))) 'now)
 '(diff-removed ((t (:foreground "firebrick2"))) 'now)
)


