; 检查是否有坏, 只需两个游标, 一个一步走, 一个两步走
; 到头了没有相遇, 没有环
; 相遇了 有环

; one step
(define (next x)
  (if (pair? x)
    (cdr x)
    `()))

; two step
(define (next-next x)
  (if (and (pair? x) (pair? (cdr x)))
    (cddr x)
    `()))

(define (is-cycle x)
  (define (inner n nn)
    (if (or (null? n) (null? nn))
      #f
      (or (eq? n nn) (inner (next n) (next-next nn)))))
  (inner (next x) (next-next x))
)

(define x (list `a `b `c))

; 3
(define tail (cons `a `b))
(define y (cons tail (cons `c tail)))

(is-cycle x)
(is-cycle y)

; 3
(define third (list `c))
(define second (cons third third))
(define z (cons second second))
(is-cycle z)

; 3
(define c (list `c))
(define b (cons `b c))
(define a (cons `a b))
(set-cdr! c a)
(is-cycle a)