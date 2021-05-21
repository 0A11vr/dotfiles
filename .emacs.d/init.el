;; .emacs.d/init.el


;; ===================================

;; MELPA Package Support

;; ===================================

;; Enables basic packaging support

(require 'package)


;; Adds the Melpa archive to the list of available repositories

(add-to-list 'package-archives

             '("melpa" . "http://melpa.org/packages/") t)


;; Initializes the package infrastructure

(package-initialize)


;; If there are no archived package contents, refresh them

(when (not package-archive-contents)

  (package-refresh-contents))


;; Installs packages

;;

;; myPackages contains a list of package names

(defvar myPackages

  '(better-defaults                 ;; Set up some better Emacs defaults
    
   ;; material-theme                  ;; Theme
    py-autopep8                     ;; Run autopep8 on save
    )

  )


;; Scans the list in myPackages

;; If the package listed is not already installed, install it

(mapc #'(lambda (package)

          (unless (package-installed-p package)

            (package-install package)))

      myPackages)


;; ===================================

;; Basic Customization

;; ===================================


(setq inhibit-startup-message t)    ;; Hide the startup message

;;(load-theme 'material t)            ;; Load material theme

(global-linum-mode t)               ;; Enable line numbers globally

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
;;(setq backup-directory-alist '(("." . "~/emacs-backups")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))

(global-visual-line-mode t)

;; ====================================

;; Development Setup

;; ====================================

;; Enable elpy

(elpy-enable)


;; Enable Flycheck

(when (require 'flycheck nil t)

  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8

(require 'py-autopep8)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


(setq x-super-keysym 'meta) ;; change meta from alt to super

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4d2ff8f6a7797796a939d799631f29d711c6ffc5f2e7d39dd7dd4ac636d7f88f" default))
 '(package-selected-packages '(flycheck material-theme better-defaults elpy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Triplicate T4c" :foundry "Matt" :slant normal :weight normal :height 120 :width normal)))))
