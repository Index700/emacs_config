
;;-*- Emacs-Lisp -*-
;Package install from melpa

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(let ((default-directory  "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))



;;Config of load path
(setq load-path
    (append (list nil
            (expand-file-name "~/.emacs.d/site-lisp"))
	    load-path))


;;Start Buffer is Scrach Buffer 
(setq initial-buffer-choice t)

;; swap BS and DEL
(keyboard-translate ?\C-h ?\C-?)

;;Japanese language environment
(set-fontset-font t `japanese-jisx0208 (font-spec :family "IPAEXGothic"))

;; X11 specific
(when (eq window-system 'x)
  (scroll-bar-mode -1)
 (set-default-font "terminus-15")
  ;; face
  (dolist (elem '((bold "LightGoldenrod")
		  (underline "PaleGreen")
		  (mode-line "white" "dark blue" bold)
		  (mode-line-inactive "dark blue" "white")
		  (link "PaleGreen")
		  (link-visited "salmon")
		  (font-lock-builtin-face "aquamarine1")
		  (font-lock-keyword-face "aquamarine1" nil bold)
		  (font-lock-function-name-face "aquamarine1" nil bold)

		  (font-lock-constant-face "aquamarine2")
		  (font-lock-variable-name-face "aquamarine2")
		  (font-lock-type-face "LightCyan" nil bold)
		  (font-lock-preprocessor-face "LightCyan")

		  (font-lock-warning-face "orange")
		  (font-lock-negation-char-face "orange")
		  (font-lock-regexp-grouping-backslash "orange")
		  (font-lock-regexp-grouping-construct "orange")

		  (font-lock-comment-face "orange red")
		  (font-lock-comment-delimiter-face "orange red")
		  (font-lock-string-face "orange red")
		  (font-lock-doc-face "orange red")))
    (set-face-attribute (car elem) nil
			:foreground (nth 1 elem)
			:background (nth 2 elem)
			:weight (or (nth 3 elem) 'normal))))

;;mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;;trr
(add-to-list 'load-path "~/.emacs-trr")
(require 'trr)



;;show ( and )
(show-paren-mode 1)

;;yes/no y/nnnnn
(defalias 'yes-or-no-p 'y-or-n-p)

;;auto-complete mode "company"
(require 'python)
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2)	;デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
 (add-to-list 'company-backends 'company-jedi)
 (add-hook 'python-mode-hook 'my/python-mode-hook)

;;キーバインド変更
  ;;M-x describe-key-briefly でキーバインドの割り当てを確認
;;C-z Open shell
(define-key global-map (kbd "C-z") 'shell)
;;C-c コピー
;;(define-key global-map (kbd "C-c") 'kill-ring-save)


;;"ti" `(text-scale-increase :which-key "text scale increase")

;;Black background
(set-face-background 'default "black")

;; Stop beep  
(setq ring-bell-function 'ignore)

;;Show time on mode-line
(display-time)

;;Show line number
(global-linum-mode )

;;high lineを表示
;;(global-hi-line-mode t)

;;doc-anotation-mode
(setq doc-view-scale-internally nil)
(add-hook 'doc-view-mode-hook
  	  '(lambda ()
	     (local-set-key "c" 'doc-annotate-add-annotation)
	     (local-set-key [mouse-1] 'doc-annotate-add-annotation)))
(autoload 'doc-annotate-mode "doc-annotate")
(autoload 'doc-annotate-add-annotation "doc-annotate")
(add-to-list 'auto-mode-alist '("\\.ant$" . doc-annotate-mode))

(put 'set-goal-column 'disabled nil)

;;error view flylint-mode
(autoload 'flylint-mode "flylint" nil t)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (flylint-mode 1)))
(add-hook 'perl-mode-hook
	  '(lambda ()
	     (flylint-mode 1)))
(add-hook 'c-mode-hook
  	  '(lambda ()
	     (flylint-mode 1)))
(add-hook 'emacs-lisp-mode-hook
  	  '(lambda ()
	     (flylint-mode 1)))

;;pytrans config
(autoload 'pytrans-translate "pytrans" nil t)
(global-set-key "\C-cT" 'pytrans-translate)

(autoload 'rsync "rsync" nil t)
(global-set-key "\C-cR" 'rsync)
(global-set-key "\C-cP" 'insert-rsync-path)


;; (require 'tabbar)
;; ; turn on the tabbar
;; (tabbar-mode t)
;; ; define all tabs to be one of 3 possible groups: “Emacs Buffer”, “Dired”,

;;  )

::ここは変えない
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-firefox helm dash undo-tree trr tabbar-ruler smartparens rainbow-delimiters magit git-link company-jedi auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;自動で()をつける(package : smartparens)
(smartparens-global-mode)



;===============
; jedi (package.elの設定より下に書く)
;===============
;; (require 'auto-complete)
;; (require 'epc)
;; (require 'auto-complete-config)
;; (require 'python)


;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
;; (setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
;; (require 'jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

