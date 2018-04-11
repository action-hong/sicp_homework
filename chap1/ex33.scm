(define (filter-accumulate combiner null-value filter term a next b)
  (cond ((> a b) null-value)
    ((filter a) (combiner (term a) (filter-accumulate combiner null-value filter term (next a) next b)))
    (else (filter-accumulate combiner null-value filter term (next a) next b))))

(define (small-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next divisor)
    (if (= divisor 2)
      3
      (+ divisor 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (next test-divisor)))
        ))

(define (divides? a b)
  (= (remainder a b) 0))

(define (square n)
  (* n n))

(define (prime? n)
  (= (small-divisor n) n))

(define (integer n)
  n)

(define (next n)
  (+ n 1))

  ; 所有素数的和
(define (prime-sum a b)
  (define (combiner a b)
    (+ a b))
  (filter-accumulate combiner 0 prime? integer a next b)
)

(prime-sum 2 10)

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; 小于n的所有与n互素的正整数之乘积
(define (magic-product n)
  (define (filter x)
    (= 1 (gcd x n)))
  (define (combiner a b)
    (* a b))
  (filter-accumulate combiner 1 filter integer 1 next (- n 1))
)

; 3 * 7 * 9
(magic-product 10)
(* 3 7 9)