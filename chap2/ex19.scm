(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (first-denomination list)
  (car list)
)

(define (except-first-denomination list)
  (cdr list)
)

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
         ((or (< amount 0) (null? coin-values)) 0)
         (else (+ (cc (- amount (first-denomination coin-values)) coin-values)
                  (cc amount (except-first-denomination coin-values))))))


(cc 100 us-coins)
(cc 100 (list 1 5 10 25 50))
; 排列顺序不会影响答案
; 看看 cc的内部实现即可
; 还真不懂要怎么说 表达能力太差吗