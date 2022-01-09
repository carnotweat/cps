(defmacro cps-bind (vars expr &rest body)
  "Bind VARS in a continuation passed to EXPR with contents BODY.
So (cps-bind x (fun arg) body) expands to (fun arg (λ (x) body))"
  (declare (indent 2))
  (if (listp vars)
      `(,@expr (lambda ,vars ,@body))
    `(,@expr (lambda (,vars) ,@body))))

(defmacro cps-let (bindings &rest body)
  "Expand multiple BINDINGS and call BODY as a continuation.
Example: (cps-let ((x (fun1 arg1)) (y z (fun2 arg2))) body)
expands to: (fun1 arg1 (λ (x) (fun2 arg2 (λ (x y) body))))."
  (declare (indent 1))
  (pcase bindings
    (`((,vars ,expr)) `(cps-bind ,vars ,expr ,@body))
    (`((,vars ,expr) . ,rest) `(cps-bind ,vars ,expr (cps-let ,rest ,@body)))))
