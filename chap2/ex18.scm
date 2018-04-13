
(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

; 翻转列表
; 递归  (reverse (cdr list)) + (car list)
(define (reverse list)
  (if (null? (cdr list))
    (cons (car list) nil)
    (append (reverse (cdr list)) (cons (car list) nil))))

(define l (list 1 2 3 4 5))
(define rl (reverse l))
