(define (cont-frac n d k)
  (define (intern x)
    (if (= x k)
      (/ (n x) (d x))
      (/ (n x) (+ (d x) (intern (+ x 1))))))
  (intern 1)
)

; e - 2
(define (fun k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 
               (let ((t (- i 2)))
                 (if (= (remainder t 3) 0)
                   (* 2 (+ 1 (/ t 3)))
                   1))
             )
             k       
  ) 
)

; 0.7182817182817183
(fun 10)