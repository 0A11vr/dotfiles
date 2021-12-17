; Majority of this taken from emacs from scratch
; Font var
(defvar m/default-font-size 133)
(defvar m/default-variable-font-size 133)

; Deals with newline behavior: if -1 acts like I would expect. If on newline without intend is enter with c-j
(electric-indent-mode -1)

;(setq blink-cursor-mode nil)



(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; no visible scrollbaar
;(tool-bar-mode -1)          ; no toolbar
(tooltip-mode -1)           ; no tooltips
;(set-fringe-mode 10)        ;
(set-fringe-mode 0)
;(menu-bar-mode -1)         ; no menu

(setq x-super-keysym 'meta) ;; change meta from alt to super
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; escape exit prompts




(set-face-attribute 'default nil :font "Monospace" :height m/default-font-size)
;; variable width font
(set-face-attribute 'variable-pitch nil :font "Public Sans" :height m/default-font-size :weight 'light)

;; Initialize package sources
(defvar bootstrap-version)
(let ((bootstrap-file
               (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
            (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
          (with-current-buffer
                    (url-retrieve-synchronously
                               "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
                                        'silent 'inhibit-cookies)
                          (goto-char (point-max))
                                (eval-print-last-sexp)))
      (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
;(setq package-enable-at-startup nil)


(use-package diminish)
;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") 
  
(use-package monotropic-theme)
(load-theme 'monotropic t)

;; (straight-use-package '(nano-theme :type git :host github
;;                                    :repo "rougier/nano-theme"))
;; (load-theme 'nano-light t)

(straight-use-package '(nano-modeline :type git :host github
				      :repo "rougier/nano-modeline"))
(nano-modeline-mode 1)

;; (use-package doom-modeline
;;   :init (doom-modeline-mode 1)
;;   :custom ((doom-modeline-height 5)))


(global-visual-line-mode t) ;; line wrap
(column-number-mode)
(global-display-line-numbers-mode t)
;; (use-package visual-fill-column
  ;; :hook ('visual-line-mode . #'visual-fill-column-mode))

(use-package adaptive-wrap
  :hook ('visual-line-mode . #'adaptive-wrap-prefix-mode))


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
		circe-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package swiper)


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
	 ("C-M-a" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

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



;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))

; displays what the entered keycombo can do
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 3))
; displays extra info about whats in the list
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


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
  ;; trying to fix redo behavior with this
  (setq evil-undo-system 'undo-fu)
  ;; keeps all modes with box cursor
  (setq evil-operator-state-cursor 'box)
  (setq evil-emacs-state-cursor 'box)
  (setq evil-replace-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'box)
  (setq evil-motion-state-cursor 'box)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;;(evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;;(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-initial-state 'pdf-view-mode 'emacs)
  (add-hook 'pdf-view-mode-hook
  (lambda ()
    (set (make-local-variable 'evil-emacs-state-cursor) (list nil)))))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

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


;;; taken from SirPscl/emacs.d
;; when scrolling, keep the cursor in the same position
;; (setq scroll-preserve-screen-position 'keep)
;; Delete trailing whitespaces when saving
;(add-hook 'write-file-hooks 'delete-trailing-whitespace)



; I installed
;; (use-package password-store
;; ;  :pin melpa
;;   :config
;;   (setf epa-pinentry-mode 'loopback))
;; (use-package ivy-pass)
;; ;(use-package epa-file)
;; (use-package pinentry)

;;; ^^ worked
(use-package pinentry
  :config
  (setq epa-pinentry-mode 'loopback)
  (pinentry-start))


(use-package password-store)
(use-package ivy-pass)

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook
  (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (pdf-tools-install)
  ;(setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; stolen from SirPscl/emacs.d - zoom by 5%
  (setq pdf-view-resize-factor 1.05)
  ;; don't use swiper
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-command "pandoc"))




(use-package undo-fu
  :config
  (global-set-key (kbd "C-r") 'undo-fu-only-redo))

(load-file "~/.emacs.d/private.el")
;; taken from https://github.com/stsquad/my-emacs-stuff/blob/master/my-circe.el
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

(show-paren-mode t) ;; enable show paren mode
(setq show-paren-style 'expression) ;; highlight whole expression
 (use-package paren-face
  :hook (emacs-lisp-mode . paren-face-mode))


;;; taken from https://emacs.stackexchange.com/a/5885 ;;;
;;; Sets work-tree for bare repo dotfiles management with Magit
;; prepare the arguments
(setq dotfiles-git-dir (concat "--git-dir=" (expand-file-name "~/.cfg")))
(setq dotfiles-work-tree (concat "--work-tree=" (expand-file-name "~")))

;; function to start magit on dotfiles
(defun dotfiles-magit-status ()
  (interactive)
  (add-to-list 'magit-git-global-arguments dotfiles-git-dir)
  (add-to-list 'magit-git-global-arguments dotfiles-work-tree)
  (call-interactively 'magit-status))
(global-set-key (kbd "C-c C-d") 'dotfiles-magit-status)

;; wrapper to remove additional args before starting magit
(defun magit-status-with-removed-dotfiles-args ()
  (interactive)
  (setq magit-git-global-arguments (remove dotfiles-git-dir magit-git-global-arguments))
  (setq magit-git-global-arguments (remove dotfiles-work-tree magit-git-global-arguments))
  (call-interactively 'magit-status))
;; redirect global magit hotkey to our wrapper
(global-set-key (kbd "C-x g") 'magit-status-with-removed-dotfiles-args)
;; everything works without this?
;;(define-key magit-file-mode-map (kbd "C-x g") 'magit-status-with-removed-dotfiles-args)

;; mu4e stuff taken from https://github.com/daviwil/emacs-from-scratch/blob/629aec3dbdffe99e2c361ffd10bd6727555a3bd3/show-notes/Emacs-Mail-01.org

(use-package mu4e
  :straight
  (:local-repo
   "/usr/share/emacs/site-lisp/mu4e"
   :pre-build())
  :config
  (setq mu4e-root-maildir "~/.mail"
	mu4e-get-mail-command "mbsync -a"
	message-send-mail-function 'smtpmail-send-it
	mail-user-agent 'mu4e-user-agent
	mu4e-update-interval 1800 ;; every 60 min
	mu4e-change-filenames-when-moving t
	mu4e-use-fancy-chars t
	;; For wrapping nicer in other clients
	mu4e-compose-format-flowed t
	;; display attached images
	mu4e-view-show-images t
	mu4e-attachment-dir "~/Downloads"
	;; Use Ivy for mu4e completions (maildir folders, etc)
	mu4e-completing-read-function #'ivy-completing-read)
  (setq mu4e-contexts
	(list
	 (make-mu4e-context
	  :name "isu"
	  :match-func
	  (lambda (msg)
	    (when msg
	      (string-prefix-p "/isu" (mu4e-message-field msg :maildir))))
	  :vars '((user-mail-address . "mreed15@ilstu.edu")
		  (user-full-name    . "mreed15")
		  (smtpmail-smtp-server . "smtp.office365.com")
		  (smtpmail-smtp-service . 587)
		  (smtpmail-stream-type . starttls)
		  (mu4e-sent-folder . "/isu/Sent Items")
		  (mu4e-trash-folder . "/isu/Deleted Items")
		  (mu4e-drafts-folder . "/isu/Drafts")
		  (mu4e-refile-folder . "/isu/Archive")))
	 (make-mu4e-context
	  :name "x"
	  :match-func
	  (lambda (msg)
	    (when msg
	      (string-prefix-p "/x" (mu4e-message-field msg :maildir))))
	  :vars '((user-mail-address . "m@xreed.net")
		  (user-full-name . "x")
		  (smtpmail-smtp-server . "smtp.purelymail.com")
		  (smtpmail-smtp-service . 465)
		  (smtpmail-stream-type . ssl)
		  (mu4e-sent-folder . "/x/Sent")
		  (mu4e-trash-folder . "/x/Trash")
		  (mu4e-drafts-folder . "/x/Drafts")
		  (mu4e-refile-folder . "/x/Archive"))))))


	
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-mode-list
   '(2048-game ag alchemist anaconda-mode apropos arc-mode auto-package-update beginend bm bookmark
	       (buff-menu "buff-menu")
	       calc calendar cider cmake-mode comint company compile consult
	       (custom cus-edit)
	       cus-theme dashboard daemons deadgrep debbugs debug devdocs dictionary diff-hl diff-mode dired dired-sidebar disk-usage distel doc-view docker ebib edbi edebug ediff eglot explain-pause-mode elfeed elisp-mode elisp-refs elisp-slime-nav embark emms epa ert eshell eval-sexp-fu evil-mc eww fanyi finder flycheck flymake forge free-keys geiser ggtags git-timemachine gnus go-mode grep guix hackernews helm help helpful hg-histedit hungry-delete ibuffer image image-dired image+ imenu imenu-list
	       (indent "indent")
	       indium info ivy js2-mode leetcode lispy log-edit log-view lsp-ui-imenu lua-mode kotlin-mode macrostep man magit magit-todos markdown-mode monky mpdel mu4e mu4e-conversation neotree newsticker notmuch nov
	       (occur replace)
	       omnisharp org org-present osx-dictionary outline p4
	       (package-menu package)
	       pass popup proced
	       (process-menu simple)
	       prodigy profiler python quickrun racer racket-describe realgud reftex restclient rg ripgrep rjsx-mode robe rtags ruby-mode scheme scroll-lock selectrum sh-script simple slime sly speedbar tab-bar tablist tabulated-list tar-mode telega
	       (term term ansi-term multi-term)
	       tetris thread tide timer-list transmission trashed tuareg typescript-mode vc-annotate vc-dir vc-git vdiff vertico view vlf vterm w3m wdired wgrep which-key woman xref xwidget yaml-mode youtube-dl zmusic
	       (ztree ztree-diff)))
 '(smtpmail-smtp-server "smtp.office365.com")
 '(smtpmail-smtp-service 587))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
