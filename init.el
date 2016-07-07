;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Melpa repository
(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (misterioso)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Configuring company
;; Enable company globally for all mode
(global-company-mode)

;; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)

;; Reduce the number of characters before company kicks in
(setq company-minimum-prefix-length 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Active linum-mode for all buffers
(global-linum-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Configuring Haskell-Mode
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)));
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;;Activing auto-complete 
;(require 'auto-complete)
;(global-auto-complete-mode t)
;(eval-after-load 'auto-complete
;  '(add-to-list 'ac-modes 'haskell-interactive-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Configuring RUST-MODE

;; Set path to racer binary
(setq racer-cmd "~/.cargo/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "~/.rust/src/")

;; Load rust-mode when you open `.rs` files
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;turn eldoc on
(add-hook 'rust-mode-hook 'turn-on-eldoc-mode)

;; Setting up configurations when you load rust-mode
(add-hook 'rust-mode-hook

	  '(lambda ()
	     ;; Enable racer
	     (racer-activate)
  
	     ;; Hook in racer with eldoc to provide documentation
	     (racer-turn-on-eldoc)
	     
	     ;; Use flycheck-rust in rust-mode
	     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
	     
	     ;; Use company-racer in rust mode
	     (set (make-local-variable 'company-backends) '(company-racer))
	     
	     ;; Key binding to jump to method definition
	     (local-set-key (kbd "M-.") #'racer-find-definition)
     
	     ;; Key binding to auto complete and indent
	     (local-set-key (kbd "TAB") #'racer-complete-or-indent)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Mute Bell
(setq ring-bell-function 'ignore)