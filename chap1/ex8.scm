(define (square x)
  (* x x))

; 两次竞猜的变化
(define (good-enough guess lastGuess x)
  (< (/ (abs (- guess lastGuess)) guess) 0.01))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (cube-iter guess lastGuess x)
  (if (good-enough guess lastGuess x)
      guess
      (cube-iter (improve guess x) guess x)))

(define (cube x)
  (cube-iter 1.0 0 x))