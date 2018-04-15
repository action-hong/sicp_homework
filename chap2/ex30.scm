(define (square x)
  (* x x))

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


; 递归
(define (square-tree tree)
  (cond ((null? tree) nil)
         ((pair? tree) (cons (square-tree (car tree)) (square-tree (cdr tree))))
         (else (square tree))         
))

; 递归map
(define (map tree func)
  (cond ((null? tree) nil)
         ((pair? tree) (cons (map (car tree) func) (map (cdr tree) func)))
         (else (func tree)))         
)


; 迭代
(define (square-tree-iter tree)
  (define (iter rest result)
    (cond ((null? rest) result)
           ((pair? rest) (iter (cdr rest) (cons (car rest) result)))
           (else (iter (square-tree-iter (cdr rest))  (cons (square rest) result)))
           ))
  (deep-reverse (iter tree nil))
)


(define l (list 1 (list 2 (list 3 4) 5)))

(square-tree l)
(map l square)
;(square-tree-iter l)