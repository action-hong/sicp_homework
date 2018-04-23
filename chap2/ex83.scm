(define (scheme-number->rat x)
  (make-rational (contents x) 1))

; 实部可用分数表示???不
(define (rat->complex x)
  (make-complex-from-real-imag ()))

(put `raise `scheme-number (lambda (x) #f))