
; 最前面开始叠加
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest)) (cdr rest))))
  (iter initial sequence)
)

; 从最后面开始叠加过来
(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (fold-right op initial (cdr sequence)))))

(define (reverse1 sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))


(define (reverse2 sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define sequence (list 1 2 3 4 5 6 7 8))

(reverse1 sequence)
(reverse2 sequence)

(define (enumerate-interval min max)
  (if (> min max)
    nil
    (cons min (enumerate-interval (+ min 1) max))))

(enumerate-interval 1 10)

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
(define (flatmap proc sequence)
  (accumulate append nil (map proc sequence)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime? n)
  (= (small-divisor n) n))

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

(define (square x)
  (* x x ))

(define (divides? a b)
  (= (remainder a b) 0))
(define (prime-sum-pairs n)
  (map make-pair-sum
    (filter prime-sum? 
      (flatMap
        (lambda (i) 
          (map (lambda (j) (list i j))
               (enumerate-interval 1 (- i 1))))
               (enumerate-interval 1 n)))))

(prime-sum-pairs 3)
; (list (list 1 2 3) (list 2 3 5))

(define (permutations s)
  (if (null? s)
    (list nil)
    (flatMap (lambda (x) 
                (map (lambda (p) (cons x p)) 
                     (permutations (remove x s)))) 
              s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item))) sequence))

(permutations (list 1 2 3))