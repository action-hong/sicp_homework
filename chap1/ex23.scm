(define (small-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (next test-divisor)))
        ))
(define (next divisor)
  (if (= divisor 2)
    3
    (+ divisor 2)))

(define (divides? a b)
  (= (remainder a b) 0))

(define (square n)
  (* n n))

(define (prime? n)
  (= (small-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (
      and
      (report-prime (- (runtime) start-time))
      #f
    )
    #t
    ))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #f
  )

; 默认输入的都是奇数
(define (search-for-primes min max)
  (if (and (timed-prime-test min) (< (+ min 2) max))
    (search-for-primes (+ min 2) max)
  )
)