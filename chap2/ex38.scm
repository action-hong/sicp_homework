
; 最前面开始叠加
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest)) (cdr rest))))
  (iter initial sequence)
)

; 从最后面开始叠加过来
(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (fold-right op initial (cdr sequence)))))

; 1 / 6
(fold-left / 1 (list 1 2 3))

; 1 / (2 / 3) = 1.5
(fold-right / 1 (list 1 2 3))

;(list (list (list (list 1) 2) 3) 4)
(fold-left list nil (list 1 2 3 4))

;(list 1 (list 2 (list 3 (list 4))))
(fold-right list nil (list 1 2 3 4))