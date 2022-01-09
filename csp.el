(blocking-call
  (lambda (ret)
     (dante-async-load-current-buffer
      nil
      (lambda
        (_load-messages)
        (dante-async-call
         (concat ":loc-at " symbol)
         (lambda (target)
         (let ((xref (dante--make-xref target "def")))
           (funcall ret (when xref (list xref))))))))))
