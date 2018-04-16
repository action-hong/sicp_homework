(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (filter proc sequence)
  (cond ((null? sequence) nil)
    ((proc (car sequence)) (cons (car sequence) (filter proc (cdr sequence))))
    (else (filter proc (cdr sequence)))
    ))

; 类似rxjava里面的 flatMap                                
(define (flatMap proc sequence)
  (accumulate append nil (map proc sequence)))

(define (enumerate-interval min max)
  (if (> min max)
    nil
    (cons min (enumerate-interval (+ min 1) max))))

(define (unique-pairs n)
  (flatMap (lambda (i) (map (lambda (j) (list i j))
                            (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (make-prime-pair pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime? n)
  (= (small-divisor n) n))


(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (small-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next divisor)
    (if (= divisor 2)
      3
      (+ divisor 2)))
    (define (square x)
      (* x x ))
    (define (divides? a b)
      (= (remainder a b) 0))
    (cond ((> (square test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (next test-divisor)))
        ))




(define (prime-sum-pairs n)
  (map make-prime-pair
       (filter prime-sum?
              (unique-pairs n))))

(prime-sum-pairs 3)