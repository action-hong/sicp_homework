(define (iterative-imrove improve good-enough?)
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? next guess)
        next
        (try next))))
  (lambda (x) (try x))
)

(define tolerance 0.00001)

(define (sqrt x)
  (define (average a b)
    (/ (+ a b)  2))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (iterative-imrove improve good-enough?)
)

((sqrt 9) 1.0)
((sqrt 99) 1.0)
((sqrt 7) 1.0)


(define (fixed-point f)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (iterative-imrove f good-enough?)
)

((fixed-point cos) 1.0)