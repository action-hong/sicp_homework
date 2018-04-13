(define (gcd n d)
  (if (= d 0)
    n
    (gcd d (remainder n d))))

; 两个数组合起来是正还是负
(define (isPositive n d)
  (if (> (* n d) 0)
    1
    -1))

; 用提供的序列对表达来实现  对有理数的抽象 
; 序列的第一个数做分子, 第二个做分母

; (define (make-rat n d)
;   (let ((g (gcd n d)))
;     (cons (/ n g) (/ d g))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)) 
)

; 有理数为正, 分子分母都为正
; 有里数为负, 分子为负
(define (make-rat n d)
  (let ((g (gcd n d))
        (positive (isPositive n d))
       )
    (cons (* positive (abs (/ n g))) 
          (abs (/ d g)))))

; (define one-half (make-rat 1 2))

; (print-rat one-half)

; (define one-third (make-rat 1 3))

; (print-rat one-third)

(define (print-a-rat n d)
  (print-rat (make-rat n d)))

(print-a-rat (- 3) (- 6))
(print-a-rat 3 6)
(print-a-rat 3 (- 6))
(print-a-rat (- 3) 6)