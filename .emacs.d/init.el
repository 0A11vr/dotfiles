; Majority of this taken from emacs from scratch
; Font var
(defvar efs/default-font-size 133)
(defvar efs/default-variable-font-size 133)

; Deals with newline behavior: if -1 acts like I would expect. If on newline without intend is enter with c-j
(electric-indent-mode -1)

;; Theme
;(load-theme 'modus-operandi)
(use-package monotropic-theme)
 (load-theme 'monotropic t)

;(use-package almost-mono-themes
; :config
; (load-theme 'almost-mono-white t))
;(set-face-attribute 'region nil :background "#E0E0E0")
;(use-package xresources-theme
;  :config
;  (load-theme 'xresources t))


;(use-package brutal-theme
;  :config
;  (load-theme 'brutal-light t))


(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; no visible scrollbar
;(tool-bar-mode -1)          ; no toolbar
(tooltip-mode -1)           ; no tooltips
;(set-fringe-mode 10)        ; 
(set-fringe-mode 0)
;(menu-bar-mode -1)         ; no menu

(setq x-super-keysym 'meta) ;; change meta from alt to super
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; escape exit prompts
;(global-visual-line-mode t) ;; line wrap
(column-number-mode)
(global-display-line-numbers-mode t)

;(load-theme 'modus-operandi)

(set-face-attribute 'default nil :font "Triplicate A Code" :height efs/default-font-size)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))


(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t) ;; turns ensure on for all package blocks

(use-package swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
		circe-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;(use-package rainbow-delimiters
;  :hook (prog-mode . rainbow-delimiters-mode))

; displays what the enter keycombo can do
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 3))
; displays extra info about whats in the list
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
	 ("C-M-a" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  ;; trying to fix redo behavoiro with this
  (setq evil-undo-system 'undo-fu)
  ;; keeps all modes with box cursor
  (setq evil-motion-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'box)
  (setq evil-replace-state-cursor 'box)
  (setq evil-emacs-state-cursor 'box)

  ;;;(setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;;(evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;;(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status)))

;; no dialog boxes
(setq use-dialog-box nil)


;; from munen/emacs.d
;; Garbage Collection
(setq gc-cons-threshold 20000000)
;; Do no create backup files
(setq make-backup-files nil)
;; Warn when opening big files
(setq large-file-warning-threshold 200000000)
;; Auto-save in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Always follow symlinks
(setq vc-follow-symlinks t)
;; Sentences have one space after a period
(setq sentence-end-double-space nil)
;; Confirm before closing Emacs
(setq confirm-kill-emacs 'y-or-n-p)
;; dired-mode
;; Ability to use `a` to visit a new directory insteat of RET, in same buffer
(put 'dired-find-alternate-file 'disabled nil)
;; Human readable units
(setq-default dired-listing-switches "-alh")
;; On `C`, recursively copy by default
(setq dired-recursive-copies 'always)
;; Ask `y/n` instead of `yes/no`
(fset 'yes-or-no-p 'y-or-n-p)
;; Auto revert files on change
(global-auto-revert-mode t)
;; Shortcut for changing font-size
(defun zoom-in ()
  (interactive)
  (let ((x (+ (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(defun zoom-out ()
  (interactive)
  (let ((x (- (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(define-key global-map (kbd "C-1") 'zoom-in)
(define-key global-map (kbd "C-0") 'zoom-out)
;; Display the current 
; disable system load
(setq display-time-default-load-average nil)
(setq display-time-24hr-format 1)
(display-time-mode t)

;; windmove with shift + arrowkeys

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Enables `undo` (and `redo`) changes in the window configuration with the key commands `C-c left` and `C-c right`.
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; PDF export
(defun md-compile ()
  "Compiles the currently loaded markdown file using pandoc into a PDF"
  (interactive)
  (save-buffer)
  (shell-command (concat "panrun " (buffer-file-name))))

(defun update-other-buffer ()
  (interactive)
  (other-window 1)
  (revert-buffer nil t)
  (other-window -1))

(defun md-compile-and-update-other-buffer ()
  "Has as a premise that it's run from a markdown-mode buffer and the
   other buffer already has the PDF open"
  (interactive)
  (md-compile)
  (update-other-buffer))


(eval-after-load 'markdown-mode
  '(define-key markdown-mode-map (kbd "C-c r") 'md-compile-and-update-other-buffer))


; I installed
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (pdf-tools-install))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


(use-package diminish)

(use-package undo-fu
  :config
  (global-set-key (kbd "C-r") 'undo-fu-only-redo))

(load-file "~/.emacs.d/private.el")
(use-package circe
  :config
  (setq circe-network-options
	`(("bitlbee"
	  :nick "m"
	  :nickserv-password ,bitlbee-password
	  :nickserv-mask "\\(bitlbee\\|root\\)!\\(bitlbee\\|root\\)@"
          :nickserv-identify-challenge "use the \x02identify\x02 command to identify yourself"
          :nickserv-identify-command "PRIVMSG &bitlbee :identify {password}"
          :nickserv-identify-confirmation "Password accepted, settings and accounts loaded"
;	  :lagmon-disabled t
	  :channels ("&bitlbee")
	  :host "localhost"
	  :service "6667")))

  :after circe
  :init (enable-circe-color-nicks))

(use-package paren-face
  :hook (emacs-lisp-mode . paren-face-mode))


;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit use-package pdf-tools counsel))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-mode circe-color-nicks circe evil-collection evil brutal-theme xresources-theme almost-mono-themes monotropic-theme monotropic helpful ivy-rich diminish which-key rainbow-delimiters use-package pdf-tools magit counsel)))
