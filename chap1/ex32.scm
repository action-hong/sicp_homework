; 递归
(define (accumulate1 combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate1 combiner null-value term (next a) next b)))
)

; 迭代
(define (accumulate2 combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner result (term a)))))
  (iter a null-value)
)

(define (sum1 term a next b)
  (define (combiner a b)
    (+ a b))
  (accumulate1 combiner 0 term a next b)
)

(define (sum2 term a next b)
  (define (combiner a b)
    (+ a b))
  (accumulate2 combiner 0 term a next b)
)

(define (product1 term a next b)
  (define (combiner a b)
    (* a b))
  (accumulate1 combiner 1 term a next b)
)



(define (integer n)
  n)

(define (next n)
  (+ n 1))

(sum1 integer 0 next 10)
(sum2 integer 0 next 10)

(product1 integer 1 next 10)