(define (is-in? items x)
  (if (null? items)
    #f
    (or (eq? x (car items)) (is-in? (cdr items) x))))

(define (join items x)
  (cons x items))

(define (count-pairs x)
  (define items `())
  (define (inner-cont x)
    (if (or (not (pair? x)) (is-in? items x))
      0
      (begin (set! items (join items x))
             (+ (inner-cont (car x))
                (inner-cont (cdr x))
                1)
      )))
  (inner-cont x)         
)

; 3
(define x (list `a `b `c))

; 3
(define tail (cons `a `b))
(define y (cons tail (cons `c tail)))

(count-pairs x)
(count-pairs y)

; 3
(define third (list `c))
(define second (cons third third))
(define z (cons second second))
(count-pairs z)

; 3
(define c (list `c))
(define b (cons `b c))
(define a (cons `a b))
(set-cdr! c a)
(count-pairs a)