(define (expt b n)
  (define (even n)
    (= (remainder n 2) 0))

  (define (fast-expt a b n)
    (cond ((= n 0) a)
          ((even n) (fast-expt a (* b b) (/ n 2)))
          (else (fast-expt (* a b) b (- n 1)))
    )
  )

  (fast-expt 1 b n)
)

(cond ((= 1 2) 1)
  (else 2))

(expt 2 10)