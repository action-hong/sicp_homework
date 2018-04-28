(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1
    )))

(define x (list `a `b `c))

(define t (list `b `c))

(define y (cons (cons `a t) t))

(count-pairs x)
(count-pairs y)