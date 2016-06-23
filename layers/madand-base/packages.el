;;; packages.el --- madand-base layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Andriy Kmit' <dev@madand.net>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; Base layer with general configuration.

;;; Code:

(defconst madand-base-packages
  '(
    ace-jump-helm-line
    (browse-url :location built-in)
    editorconfig
    evil-evilified-state
    helm
    (info :location built-in)
    simple-mpc
    yasnippet
    ))

(defun madand-base/post-init-ace-jump-helm-line ()
  (setq ace-jump-helm-line-style 'pre)

  (with-eval-after-load 'helm
    (define-key helm-map (kbd "C-a") #'ace-jump-helm-line-and-select)))

(defun madand-base/init-browse-url ()
  (setq browse-url-browser-function #'madand/browse-url-palemoon))

(defun madand-base/init-editorconfig ()
  (use-package editorconfig
    :defer t
    :init
    (add-hook 'prog-mode-hook #'editorconfig-mode)))

(defun madand-base/post-init-evil-evilified-state ()
  (define-key evil-evilified-state-map-original (kbd "Q") 'spacemacs/kill-this-buffer))

(defun madand-base/post-init-helm ()
  (with-eval-after-load 'helm
    (define-key helm-map (kbd "C-h") 'delete-backward-char)
    (define-key helm-map (kbd "C-u") #'helm-find-files-up-one-level)))

(defun madand-base/init-info ()
  (with-eval-after-load 'info
    (define-key Info-mode-map (kbd "s") 'avy-goto-word-1)
    (define-key Info-mode-map (kbd "S") 'avy-goto-char-timer)
    (define-key Info-mode-map (kbd "S-SPC") 'Info-scroll-up)))

(defun madand-base/init-simple-mpc ()
  (use-package simple-mpc
    :commands simple-mpc-view-current-playlist
    :diminish simple-mpc-current-playlist-mode
    :init
    (spacemacs/set-leader-keys "am" #'simple-mpc-view-current-playlist)
    :config
    (progn
      (setq simple-mpc-mpd-playlist-directory "~/.config/mpd/playlists/"
            simple-mpc-playlist-auto-refresh 2)
      (evilified-state-evilify-map simple-mpc-mode-map
        :mode simple-mpc-mode
        :bindings (kbd "C-m") (kbd "<return>")))))

(defun madand-base/post-init-yasnippet ()
  (with-eval-after-load 'yasnippet
    ;; Expand snippets with SPC.
    (evil-define-key 'hybrid yas-minor-mode-map (kbd "SPC") 'yas-expand)
    ;; Snippet fields navigation.
    (define-key yas-keymap (kbd "M-h") 'yas-skip-and-clear-or-delete-char)
    (define-key yas-keymap (kbd "M-t") 'yas-prev-field)
    (define-key yas-keymap (kbd "M-n") 'yas-next-field)
    ;; Spacemacs disables smartparens during the yasnippet expansion, but
    ;; auto-pairing is useful in certain snippets. As a workaround, we
    ;; temporarily enable `electric-pair-mode'.
    (add-hook 'yas-before-expand-snippet-hook 'electric-pair-mode)
    (add-hook 'yas-after-exit-snippet-hook (lambda () (electric-pair-mode -1)))))

;;; packages.el ends here
