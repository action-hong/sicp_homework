
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

(define (reverse1 sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))


(define (reverse2 sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define sequence (list 1 2 3 4 5 6 7 8))

(reverse1 sequence)
(reverse2 sequence)