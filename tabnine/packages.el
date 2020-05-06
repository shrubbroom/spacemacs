;;; packages.el --- tabnine layer packages file for Spacemacs.
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
;; added to `tabnine-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `tabnine/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `tabnine/pre-init-PACKAGE' and/or
;;   `tabnine/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst tabnine-packages
  '(company-tabnine)
       )

;;; initialize company-tabnine
(defun tabnine/init-company-tabnine()
  (use-package company-tabnine
    :ensure t
    :defer t
    :init
    :config
    )
  )

;;; add compant-tabnine the the backend of company
(defun tabnine/post-init-company-tabnine()
  (with-eval-after-load 'company
    (add-to-list 'company-backends #'company-tabnine)
    (setq company-show-numbers t)
    )
  (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
    (let ((company-message-func (ad-get-arg 0)))
      (when (and company-message-func
                 (stringp (funcall company-message-func)))
        (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
          ad-do-it))))
  )


;;; packages.el ends here
