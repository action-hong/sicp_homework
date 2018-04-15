; 递归map
(define (map func tree)
  (cond ((null? tree) nil)
         ((pair? tree) (cons (map (car tree) func) (map (cdr tree) func)))
         (else (func tree)))         
)

(define (square x)
  (* x x))

(define (square-tree tree)
  (map square tree))