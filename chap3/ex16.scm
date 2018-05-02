(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1
    )))

; 3
(define x (list `a `b `c))
(count-pairs x)

; 4
(define tail (cons `a `b))
(define y (cons tail (cons `c tail)))
(count-pairs y)

; 7
(define third (list `c))
(define second (cons third third))
(define z (cons second second))
(count-pairs z)

; 不返回的, 形成一个环
; 假设三个序列为 a b c
(define c (list `c))
(define b (cons `b c))
(define a (cons `a b))
(set-cdr! c a)
(count-pairs a)