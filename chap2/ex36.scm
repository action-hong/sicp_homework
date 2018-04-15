(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))))

; 提出每个表的第一个数累加  append 每个表去掉第一个数后 的 accumulate-n
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map (lambda (x) (cdr x)) seqs))))) 

(accumulate-n + 0 (list 
  (list 1 2 3)
  (list 4 5 6)
  (list 7 8 9)
  (list 10 11 12)
  ))