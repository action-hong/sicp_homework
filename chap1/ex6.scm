(define (square x)
  (* x x))

(define (good-enough guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
    (else else-clause)))

; 由于是应用序, 会先计算参数, 故下列式子会不断调用sqrt-iter, 直到报错
; (define (sqrt-iter guess x)
; (new-if (good-enough? guess x)
; guess
; (sqrt-iter (improve guess x) x)))