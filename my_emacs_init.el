;; Backup folder and configuration
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "C:/emacs/backups/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups




(setq package-list '(helm
		     zenburn-theme
		     org
		     auctex
		     cdlatex
		     auto-complete
		     anzu
		     )
      )



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;==================================
;;Close Toolbar
(tool-bar-mode -1)
;;Close Menubar
(menu-bar-mode -1)
;;Close Scrollbar
(scroll-bar-mode -1)
;;Load zenburn-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/")
(load-theme 'zenburn t)
;;current line number enabled
(line-number-mode t)
;;display all line numbers
(linum-mode t)
;;show number of search results
(global-anzu-mode +1)
;;show battery remaining
(display-battery-mode +1)
;; show time
(display-time-mode +1)
 


;; helm package configuration

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)


(helm-mode 1)


;; auto-complete configuration								 
(require 'auto-complete)									  
(require 'auto-complete-config)								  
(ac-config-default)										  
												  ;
(require 'ac-math)										  ;;
(add-to-list 'ac-modes 'latex-mode) ; make auto-complete aware of 'latex-mode'		  ;;
												  ;;
(defun ac-latex-mode-setup () ; add ac-sources to default ac-sources				  ;;
  (setq ac-sources										  ;;
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)		  ;;
		ac-sources))									  ;;
  )												  ;;
(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)						  ;;
;; (global-auto-complete-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auctex customization ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;use cdLaTeX
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
