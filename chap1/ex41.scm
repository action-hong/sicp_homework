(define (double foo)
  (lambda (x) (foo (foo x)))  
)

(define (inc x)
  (+ x 1))

  ; 16 + 5
(((double (double double)) inc) 5)

(((double (double (double double))) inc) 5)

; 2
; (double foo) => lambda x => foo(foo(x))
; 4
; (double double) => lambda foo => double(double foo)
; 16                                              1             2 
; (double (double double)) => lambda foo => double(double double(double(foo)))
; 256
; ((double (double (double double))) => lambda foo => double(double(double(double(double(double double(double(foo)))))))