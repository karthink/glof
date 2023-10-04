;;; glof.el --- Generally Less Obtuse Fidgeting             -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Karthik Chikmagalur

;; Author: Karthik Chikmagalur <karthikchikmagalur@gmail.com>
;; Keywords: convenience, emulations

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:
(require 'seq)
(require 'which-key)

(defun glof-pin ()
  (when-let* ((keys (this-command-keys-vector))
              (prefix (seq-take keys (1- (length keys))))
              (orig-keymap (key-binding prefix 'accept-default))
              (keymap (copy-keymap orig-keymap))
              (exit-func (set-transient-map keymap t #'which-key-abort)))
    (define-key keymap [remap keyboard-quit]
      (lambda () (interactive) (funcall exit-func)))
    (which-key--create-buffer-and-show nil keymap)))

(define-minor-mode glof-mode
  "Enable glof-mode."
  :global t
  (if glof-mode
      (add-hook 'post-command-hook #'glof-pin)
    (remove-hook 'post-command-hook #'glof-pin)))

(provide 'glof)
;;; glof.el ends here
