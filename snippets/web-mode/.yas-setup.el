(defun yas--web-mode-django-p ()
  "Predicate for checking whether the current buffer is a django template."
  (when (and (eq major-mode 'web-mode) (string= web-mode-engine "django"))
    'force-in-comment))
