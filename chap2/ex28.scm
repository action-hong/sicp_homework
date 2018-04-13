; 输入一个树, 返回一个表
; 表中元素为所有树叶 从左到右


(define (fringe tree)
  (let ((left (if (null? tree)
                  nil
                  (car tree)))
        (right (if (null? tree)
                  nil
                  (cdr tree))))
    (cond ((null? tree) nil)
          ((pair? left) (append (fringe left) (fringe right)))
          (else (append (cons left nil) (fringe right)))
    ))
)

(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)

(fringe (list x x))