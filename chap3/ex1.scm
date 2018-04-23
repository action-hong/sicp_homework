(define (make-accumulator initial)
  (lambda (num) 
    (begin (set! initial (+ initial num))
           initial)))
        
(define A (make-accumulator 5))
(A 10)
(A 10)