(define (square x)
  (* x x))

; 两次竞猜的变化
(define (good-enough guess lastGuess x)
  (< (/ (abs (- guess lastGuess)) guess) 0.01))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess lastGuess x)
  (if (good-enough guess lastGuess x)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (sqrt x)
  (sqrt-iter 1.0 0 x))