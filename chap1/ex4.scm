(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))

; 返回 a 与 b的绝对值的和