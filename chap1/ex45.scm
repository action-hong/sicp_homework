(define (average a b)
  (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

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

(define (compose f g)
  (lambda (x) (f (g x))))


(define (repeated f n)
  (lambda (x) (if (= n 1)
    (f x)
    ((compose f (repeated f (- n 1))) x))))


; 求 f的不动点, 中间做n次平均阻尼
(define (fixed-point-n-damp f n)
  (fixed-point ((repeated average-damp n) f) 1.0)  
)

(define (pow base n)
  (if (= n 1)
    base
    (* base (pow base (- n 1)))))

; 求x的n次方根 等于 该函数返回的函数的不动点
(define (root-foo n x)
  (lambda (y) (/ x (pow y (- n 1)))))


; 求16的四次方根
(fixed-point-n-damp (root-foo 4 16) 2)

(fixed-point-n-damp (root-foo 5 16) 2)

(fixed-point-n-damp (root-foo 6 16) 2)

(fixed-point-n-damp (root-foo 7 16) 2)

; 八次方的话 要三次
(fixed-point-n-damp (root-foo 8 16) 3)

;...