; g'(x) = (g(x+dx) - g(x)) / dx 
; 当x 非常小的时候
(define (deriv g)
  (lambda (x) 
    (/ (- (g (+ x dx)) (g x))
       dx
    )))

(define dx 0.00001)

(define (cube x)
  (* x x x))

((deriv cube) 5)
; 75

(define (newton-transform g)
  (lambda (x) 
    (- x (/ (g x) ((deriv g) x)))))

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

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

; 求解 y -> y^2 - x的零点
(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))


(define (square x)
  (* x x))
                
(sqrt 4)
(sqrt 5)

; g函数摸个变化下的不动点
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

; ----------------以上是书上里面的例子, 下面才是练习40------------------

(define (cubic a b c x)
    (lambda (x) (
      + (* x x x)
        (* a x x)
        (* b x)
        c
    ))
)

(newtons-method (cubic 1 2 3 4) 1)
((cubic 1 2 3 4) (- 1.2756822))