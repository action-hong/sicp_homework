; 反转树


(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

; 左右翻转递归
(define (deep-reverse tree)
  (cond ((null? tree) nil)
        ((pair? (car tree)) (append (deep-reverse (cdr tree)) (cons (deep-reverse (car tree)) nil)))
        (else (append (deep-reverse (cdr tree)) (cons (car tree) nil)))
  )
)

(define x (list (list 1 2) (list 3 4)))

(deep-reverse x)
