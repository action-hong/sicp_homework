(define (cont-frac n d k)
  (define (iter x res)
    (if (= x 0)
      res
      (iter (- x 1) (/ (n x) (+ (d x) res)))))
  (iter (- k 1) (/ (n k) (d k)))
)

(define (tan-cf x k)
  (cont-frac (lambda (i) 
                (if (= i 1)
                  x
                  (- (* x x))))
              (lambda (i) (- (* 2 i) 1))
              k          
  )
)

(tan-cf 1 10)

; tan(PI / 4) = 1.0
(tan-cf 0.7853981633974483 10)