(define f
  (let ((a `()))
    (lambda (init)
      (if (null? a)
        (begin (set! a init) a)
        0))))

(+ (f 0) (f 1))