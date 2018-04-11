; 递归
(define (product1 term a next b)
  (if (> a)
    1
    (* (term a) (product1 term (next a) next b))))

; 迭代
(define (product2 term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a))))
  )
  (iter a 1)
)

(define (square x)
  (* x x))
; (2x * 4x) / (2x + 1)^2
(define (term x)
  (/ (* (* 2 x) (+ (* 2 x) 2))
     (square (+ (* 2 x) 1))
  ))

(define (next x)
  (+ x 1))

(* 4 (product2 term 1 next 100))