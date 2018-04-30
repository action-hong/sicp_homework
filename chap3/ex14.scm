(define (mytstery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x `())        
)

; 倒序? 

(define x (list `a `b `c `d))

(display (mytstery x))