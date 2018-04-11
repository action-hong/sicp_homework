; recursive

(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3)))
       )))

;  iterative
(define (g n)
  (define (g-iter a b c count)
    (define res (+ (* 3 a) (* 2 b) c))
    (if (= count 0)
      res
      (g-iter b c res (- count 1))))
  (if (< n 3)
    n
    (g-iter 0 1 2 (- n 3))))