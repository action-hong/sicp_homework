(define x (cons (list 1 2) (list 3 4)))

(define (length items)
  (if (null? items)
    0
    (+ 1 (length (cdr items)))))

(length x)

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))
        )  
)

(count-leaves x)