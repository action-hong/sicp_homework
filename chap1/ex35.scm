(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
             (search f a b))
           ((and (negative? b-value) (positive? a-value))
             (search f b a))
           (else (error "values are not of opposite sign" a b))
             ))) 


(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value) (search f neg-point midpoint))
          ((negative? test-value) (search f midpoint pos-point))
          (else midpoint)
          )))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (negative? x)
  (< x 0))

(define (positive? x)
  (> x 0))

(define (average a b)
  (/ (+ a b) 2))

(define (f x)
  (- (* x x) 2))

  ; sinx = 0
(half-interval-method sin 2.0 4.0)

; x^3 - 2x - 3 = 0
(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                      1.0
                      2.0)


; fixed point
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? next guess)
        next
        (try next))))
  (try first-guess))

(fixed-point cos 1.0)

; 使用不动点的原理来计算平方根
; y -> x / y   猜测值 用 (1/2) * (y + x / y)
; y = x / y   ->   y = (1/2) * (y + x / y)
; 如果仍然使用上述方法中的猜测值 则是 x/y  这样就会陷入死循环 不断在两个值之间猜测
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

(sqrt 9)
(sqrt 16)
(sqrt 2)
(sqrt 25)
(sqrt 5)

; 黄金分割率

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)