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
  ;; (load-theme 'almost-mono-black t)
  ;; (load-theme 'almost-mono-gray t)
  ;; (load-theme 'almost-mono-cream t)
;  (load-theme 'almost-mono-white t))
;(use-package xresources-theme
;  :config
;  (load-theme 'xresources t))

;(set-face-attribute 'region nil :background "#E0E0E0")

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
(global-visual-line-mode t) ;; line wrap
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
                eshell-mode-hook))
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

; I installed
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (pdf-tools-install))

(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status)))

(use-package diminish)

(use-package paren-face
  :hook (emacs-lisp-mode . paren-face-mode))

(use-package undo-fu
  :config
  (global-set-key (kbd "C-r") 'undo-fu-only-redo))

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
   '(evil brutal-theme xresources-theme almost-mono-themes monotropic-theme monotropic helpful ivy-rich diminish which-key rainbow-delimiters use-package pdf-tools magit counsel)))
