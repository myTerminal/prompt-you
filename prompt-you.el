;;; prompt-you.el --- A simple library to prompt user to select from a list of options -*- lexical-binding: t; coding: utf-8; -*-

;; This file is not part of Emacs

;; Author: Mohammed Ismail Ansari <team.terminal@gmail.com>
;; Keywords: library
;; Maintainer: Mohammed Ismail Ansari <team.terminal@gmail.com>
;; Created: 2016/09/25
;; Package-Requires: ((emacs "24") (cl-lib "0.5"))
;; Description: A simple library to prompt user to select from a list of options
;; URL: http://ismail.teamfluxion.com
;; Compatibility: Emacs24


;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;; for more details.
;;

;;; Install:

;; Put this file on your Emacs-Lisp load path and add the following to your
;; ~/.emacs startup file
;;
;;     (require 'prompt-you)
;;
;; You can show a prompt with options as
;;
;;     (prompt-you-now
;;         "What would you like to do?"
;;         (list '("1" 
;;                 "Invert colors" 
;;                 (lambda ()
;;                     (invert-face 'default)))
;;               '("2" 
;;                 "Clean frame" 
;;                 (lambda ()
;;                     (menu-bar-mode -1)
;;                     (tool-bar-mode -1)
;;                     (scroll-bar-mode -1)))))
;;

;;; Commentary:

;;     You can use prompt-you to show a prompt to the user so that he/she
;;     can select one of the several options to execute associated scripts
;;
;;  Overview of features:
;;
;;     o   Show a prompt to the user to select one of a few options
;;

;;; Code:

(require 'cl-lib)

(defvar prompt-you--buffer-name
  " *prompt-you*")

;;;###autoload
(defun prompt-you-now (prompt-text options)
  (interactive)
  (let ((my-buffer (get-buffer-create prompt-you--buffer-name)))
    (set-window-buffer (get-buffer-window)
                       my-buffer)
    (other-window 1)
    (prompt-you--prepare-controls prompt-text
                                  options)))

(defun prompt-you--hide-menu ()
  (let ((my-window (get-buffer-window (get-buffer-create prompt-you--buffer-name))))
    (cond ((windowp my-window) (progn
                                 (kill-buffer (get-buffer-create prompt-you--buffer-name)))))))

(defun prompt-you--prepare-controls (prompt-text objects)
  (princ (cl-concatenate 'string
                         prompt-text
                         "\n\n")
         (get-buffer-create prompt-you--buffer-name))
  (mapc 'prompt-you--display-controls-bindings
        objects)
  (prompt-you-mode)
  (mapc 'prompt-you--apply-keyboard-bindings
        objects))

(defun prompt-you--apply-keyboard-bindings (object)
  (let ((option-text (nth 1 object))
        (func (nth 2 object)))
    (local-set-key (kbd (car object))
                   (lambda ()
                     (interactive)
                     (funcall func)
                     (prompt-you--hide-menu)
                     (message (concat "Completed: "
                                      option-text))))))

(defun prompt-you--display-controls-bindings (object)
  (princ (cl-concatenate 'string
                         "["
                         (nth 0 
                              object)
                         "] - "
                         (nth 1
                              object)
                         "\n")
         (get-buffer-create prompt-you--buffer-name)))

(define-derived-mode prompt-you-mode 
  special-mode 
  "prompt-you"
  :abbrev-table nil
  :syntax-table nil
  nil)

(provide 'prompt-you)

;;; prompt-you.el ends here
