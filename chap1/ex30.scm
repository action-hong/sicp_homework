(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (+ result (term a)))))  
  (iter a 0)
)

(define (integer n)
  n)

(define (next n)
  (+ n 1))

(sum integer 0 next 10)