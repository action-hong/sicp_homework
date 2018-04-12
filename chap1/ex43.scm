; (define (repeated f n)
;   (lambda (x) (if (= n 1)
;     (f x)
;     (f ((repeated f (- n 1)) x)))))

;                    n次 f
; 对函数重复执行n次  f(f(f(...f(x))))
(define (repeated f n)
  (lambda (x) (if (= n 1)
    (f x)
    ((compose f (repeated f (- n 1))) x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x)
  (* x x))

; 625
((repeated square 2) 5)

; 625 * 625
((repeated square 3) 5)