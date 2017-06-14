;; TODO:
;; The first time you load this, use-package does not exist.
;; Duplicate line functionality
;; Cut current line functionality regardless of cursor position
;; magit-ediff to resolve merge conflicts
;; ctrl+scroll should resize font
;; https://github.com/ScottyB/ac-js2 ??

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; packages
(use-package neotree :ensure t)
(use-package drag-stuff :ensure t)
(use-package yasnippet :ensure t)
(use-package js2-mode :ensure t)
(use-package elpy :ensure t)
(use-package monokai-theme :ensure t)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))
(use-package multiple-cursors :ensure t)
(use-package pabbrev :ensure t)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(use-package web-mode :ensure t)
(use-package json-mode :ensure t)
(use-package exec-path-from-shell :ensure t)
;(use-package simple-httpd :ensure t)
;(use-package skewer-mode :ensure t)
;(add-hook 'js2-mode-hook 'skewer-mode)
;(use-package auto-complete :ensure t)
;(ac-config-default)
;(use-package ac-js2 :ensure t)
;(add-hook 'js2-mode-hook 'ac-js2-mode)

;; Cua Mode - for ctrl+c/ctrl+v windows style.
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; NeoTree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Grab-stuff
(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

;; yasnippets and yasnippet-snippets
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"              ;; personal snippets
	"~/lib/yasnippet-snippets"         ;; the default collection
        ))
(yas-global-mode t)

;; Web Mode for HTML
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; JAVASCRIPT
;; js2-mode (javascript editing)
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . pabbrev-mode))


;; Do not word wrap by default
(setq-default truncate-lines 1)

;; Theme
(load-theme 'monokai t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions (move them)                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key Bindings                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Undo is Ctrl+Z
(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)
;; Search is Ctrl+F
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
;; multiple-cursors. Select like this with Alt+f3
(global-set-key (kbd "M-<f3>") 'mc/mark-all-like-this)
;; Duplicate line is C-d. By default C-d is delete char
(global-set-key (kbd "C-d") 'duplicate-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Arguable defaults                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto revert mode - Refreshes files and non files if they changed on disk
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Enable Predictive Abbreviation everywhere FIXME-This isnt working
(pabbrev-mode)

;; Search is case insensitive by default. Press M-c to toggle
(setq case-fold-search nil)
(setq-default indent-tabs-mode nil) ; do not mix tabs and spaces

;;
(setq x-stretch-cursor t) ;makes cursor lager when over tabs
(setq-default cursor-type 'bar)
;; Tab width is 6. - You can see they are tabs but not that
;; indented.
(setq-default tab-width 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(global-linum-mode t)
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(js2-bounce-indent-p t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Trying to get tabs to work ffs
;; https://stackoverflow.com/questions/344966/improved-tab-in-emacs
;(defvar just-tab-keymap (make-sparse-keymap) "Keymap for just-tab-mode")
;(define-minor-mode just-tab-mode
;  "Just want the TAB key to be a TAB"
;  :global t :lighter " TAB" :init-value 0 :keymap just-tab-keymap
;  (define-key just-tab-keymap (kbd "TAB") 'indent-for-tab-command))
