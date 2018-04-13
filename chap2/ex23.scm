(define (for-each proc items)
  (if (null? items)
    #f
    (proc (car items))
    (for-each proc (cdr items))
))

; if 后不能跟多条语句好蛋疼呀

(for-each (lambda (x) (newline) (display x)) (list 1 2 3))

; 并不能成功  擦擦擦擦擦
