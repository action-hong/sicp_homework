(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? next guess)
        next
        (try next))))
  (try first-guess))

(define val (log 1000))

; 计算 x^x = 1000  => x = log(1000) / log(x)
; 4.555532270803653
(fixed-point (lambda (x) (/ val (log x))) 1.0)