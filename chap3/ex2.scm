(define (square x)
  (* x x))

(define (make-monitored f)
  (define (inner count)
    (define (dispatch m)
      (cond ((eq? m `how-many-call) count)
             ((eq? m `reset-count) (set! count 0))
             ; 注意这里只考虑输入函数只有一个参数的情况
             (else (begin (set! count (+ count 1))
                          (f m))))
    )
    dispatch)
  (inner 0))


(define s (make-monitored square))

(s 100)

(s `how-many-call)
;1
(s `how-many-call)
;2
(s `reset-count)
(s `how-many-call)
;1