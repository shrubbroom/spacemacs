;;; packages.el --- verilog layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: root <root@DESKTOP-R1A5OUE>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `verilog-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `verilog/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `verilog/pre-init-PACKAGE' and/or
;;   `verilog/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst verilog-packages
  '(
    flycheck
    company
    )
  )
(defun verilog/post-init-company()
  (require 'company-keywords)
  (require 'verilog-mode)
  (add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords))
  (add-hook 'verilog-mode-hook 'company-mode)
  )
(defun verilog/post-init-flycheck()
  (add-hook 'verilog-mode-hook 'flycheck-mode)
  (add-hook 'verilog-mode-hook (lambda ()
                                 (flycheck-pos-tip-mode 0)))
  (defun flycheck-display-error-only-in-minibuffer (errors)
    (when (and errors (flycheck-may-use-echo-area-p))
      (let ((messages (seq-map #'flycheck-error-format-message-and-id errors)))
        (message (string-join messages " | ")))))

  (setq flycheck-display-errors-function #'flycheck-display-error-only-in-minibuffer)
  )


;;; packages.el ends here
