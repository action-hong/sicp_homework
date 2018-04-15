(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))))
    
; map  
(define (map p sequence)
  (accumulate (lambda (x y) (append (list (p x)) y)) nil sequence))

(define (square x)
  (* x x))

(map square (list 1 2 3 4 5 6))

; append
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; length
(define (length sequence)
  (accumulate  (lambda (x y) (+ 1 y)) 0 sequence))

(length (list 1 2 3 4 5 6 76 8 ))