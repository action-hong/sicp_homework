; 使用迭代
; 按正常顺序遍历的话, 是从头开始迭代
; 但是cons的组合应该是从后面开始的

; 法1 翻转items 迭代
(define (map func items)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (cons (func (car rest)) result) (cdr rest))
    )
  )
  (iter nil (reverse items))
)

(define (reverse list)
  (if (null? list)
    nil
    (append (reverse (cdr list)) (cons (car list) nil))))

(define (square x)
  (* x x ))

(map square (list 1 2 3 4 5 6 7 8))