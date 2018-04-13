(define (square x)
  (* x x))
(define (square-list items)
  (if (null? items)
    nil
    (cons (square (car items)) (square-list (cdr items)))))

(define (map func items)
  (if (null? items)
    nil
    (cons (func (car items)) (map func (cdr items)))))

(define (square-list-2 items)
  (map square items))

(define items (list 1 2 3 4 5 6 7 8 9 10))

(square-list items)
(square-list-2 items)
