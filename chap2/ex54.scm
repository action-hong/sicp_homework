
; let 定义临时变量 是否是pair, 不然太复杂了

(define (equal? seq1 seq2)
  (if (or (and (null? seq1) (not (null? seq2)))
           (and (null? seq2) (not (null? seq1))))
    #f
    (or (and (null? seq1) (null? seq2))
        (and (cond ((and (pair? (car seq1)) (pair? (car seq2))) (and (equal? (car seq1) (car seq2))) (equal? (cdr seq1) (cdr seq2)))
                    ((or (and (pair? (car seq1)) (not (pair? (car seq2))))
                         (and (pair? (car seq2)) (not (pair? (car seq2))))) #f)
                    (else (and (eq? (car seq1) (car seq2))
                                    (equal? (cdr seq1) (cdr seq2)))
                    )
             )))))

(define l (list 1 2 3 4 5 6))
(define s (list 1 2 3 4 5 6))
(define t (list 1 2 3 4 5 7))
(define p (list 1 2 3 4 5))
(equal? l s)
(equal? l t)
(equal? t p)

(define a1 (list 1 2 (list 3 4)))
(define b1 (list 1 2 (list 3 4)))

(equal? a1 b1)

(define a2 (list 1 2 3 4))
(equal? a1 a2)
(define l (list 1 2 3 4 5 6))
(define s (list 1 2 3 4 5 6))
(define t (list 1 2 3 4 5 7))
(define p (list 1 2 3 4 5))
(equal? l s)
(equal? l t)
(equal? t p)

(define a1 (list 1 2 (list 3 4)))
(define b1 (list 1 2 (list 3 4)))

(equal? a1 b1)

(define a2 (list 1 2 3 4))
(equal? a1 a2)
