(define (make-interval a b)
  (cons a b))

(define (upper-bound interval)
  (if (> (car interval) (cdr interval))
    (car interval)
    (cdr interval)))

(define (lower-bound interval)
  (if (< (car interval) (cdr interval))
    (car interval)
    (cdr interval)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y)))
        )
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; interval 有三种  upper < 0,   lower<0 and upper >0, lower > 0
; 因此相乘就有九种可能

