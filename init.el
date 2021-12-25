;;; init.el --- Emacs configuration file

;;; Commentary:
;; Emacs evaluates this at startup

;;; Code:

;;; All the custom-set-variables stuff goes in a separate file in emacs.d
;;; called custom.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Package Management (Melpa)
;; to update, M-x package-list-packages; U then x
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; (package-refresh-contents)

;; Install packages not already present 
(require 'use-package)

;; the splash screen doesn't add much value, so let's get rid of it
(setq inhibit-splash-screen t)

;; (load-theme 'solarized-dark)
(load-theme 'dracula)

;; General programming language stuff
;; Each level of indentation gets its own color
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Show line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; variables_like_this and VariablesLikeThis are understood to be made
;; up of the words "variables like this" and "Variables Like This"
(add-hook 'prog-mode-hook 'subword-mode)

;; Customize how major and minor modes are shown on the ModeLine
(use-package delight
  :ensure t)

;; On-the-fly linting
;; Turn on the Flycheck static analyzer globally
(use-package flycheck
  :ensure t
  :delight
  :config (global-flycheck-mode))
;; This causes Flycheck messages to be displayed as "pop-up tips"
(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))

;; This sets up some keybindings for stepping through Flycheck messages
(use-package hydra
  :defer 2
  :bind ("C-c f" . hydra-flycheck/body))
(defhydra hydra-flycheck (:color blue)
  "
  ^
  ^Errors^
  ^──────^
  _<_ previous
  _>_ next
  _l_ list
  _q_ quit
  ^^
  "
  ("q" nil)
  ("<" flycheck-previous-error :color pink)
  (">" flycheck-next-error :color pink)
  ("l" flycheck-list-errors))

;; Ivy mode enables Ivy-based completions everywhere
;; Counsel model replaces some built-in Emacs commands with their
;; Ivy-enhanced equivalents
;;(ivy-mode 1)
(counsel-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")

;; Enable Company completions globally
(add-hook 'after-init-hook 'global-company-mode)
;; General programming language stuff ends

;; LISP stuff
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")
;; LISP stuff ends

;; Scheme stuff
(setq scheme-program-name "/usr/local/bin/scheme")
(require 'xscheme)
;; Scheme stuff ends

;; Erlang stuff
(use-package ivy-erlang-complete
  :ensure t)

;; Note that this slows down startup significantly
 (use-package erlang
  :load-path ("/Users/victor/bin/erls/24.1.2/lib/tools-3.5.1/emacs")
  :hook (after-save . ivy-erlang-complete-reparse)
  :custom (ivy-erlang-complete-erlang-root "/Users/victor/bin/erls/24.1.2/")
  :config (ivy-erlang-complete-init)
  :mode (("\\.erl?$" . erlang-mode)
	 ("rebar\\.config$" . erlang-mode)
     ("relx\\.config$" . erlang-mode)
	 ("sys\\.config\\.src$" . erlang-mode)
	 ("sys\\.config$" . erlang-mode)
	 ("\\.config\\.src?$" . erlang-mode)
	 ("\\.config\\.script?$" . erlang-mode)
	 ("\\.hrl?$" . erlang-mode)
	 ("\\.app?$" . erlang-mode)
	 ("\\.app.src?$" . erlang-mode)
	 ("\\Emakefile" . erlang-mode)))
;; Erlang stuff ends

;; Haskell stuff
;; Tell Emacs where stack puts the binaries it builds
(let ((my-stack-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-stack-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-stack-path))

;;(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
;;  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
;;  (add-to-list 'exec-path my-cabal-path))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook #'hindent-mode)

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
;; Haskell stuff ends

(provide 'init)

;;; init.el ends here
