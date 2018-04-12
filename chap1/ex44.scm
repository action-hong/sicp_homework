(define (compose f g)
  (lambda (x) (f (g x))))


(define (repeated f n)
  (lambda (x) (if (= n 1)
    (f x)
    ((compose f (repeated f (- n 1))) x))))

(define dx 0.000001)

(define (smooth f)
  (lambda (x) (/ (+ (f x)
                    (f (+ x dx))
                    (f (- x dx))) 
                 3)))

(define (repeated-smooth f n)
  ((repeated smooth n) f) 
)