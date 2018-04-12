; 递归
(define (cont-frac n d k)
  (define (intern x)
    (if (= x k)
      (/ (n x) (d x))
      (/ (n x) (+ (d x) (intern (+ x 1))))))
  (intern 1)
)

; 迭代
(define (cont-frac2 n d k)
  (define (iter x res)
    (if (= x 0)
      res
      (iter (- x 1) (/ (n x) (+ (d x) res)))))
  (iter (- k 1) (/ (n k) (d k)))
)

(cont-frac (lambda (i) 1.0)
            (lambda (i) 1.0)
            10)
; 0.61797752

(cont-frac (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)
(cont-frac2 (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)
; 0.6180555

; 11即可精确到四位小数