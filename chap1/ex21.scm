(define (small-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))
        ))

(define (divides? a b)
  (= (remainder a b) 0))

(define (square n)
  (* n n))

(small-divisor 199)
(small-divisor 1999)
(small-divisor 19999)
