(define (min a b)
  (if (> a b)
    b
    a))

(define (three-min a b c)
  (- (+ a b c)
     (if (> a b)
      (min b c)
      (min a c))))
