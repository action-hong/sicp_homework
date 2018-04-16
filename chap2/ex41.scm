; 生成所有小于等于给定证书n的正的相异证书 i, j , k的有序三元组
; 使每个三元组的三个元之和等于给定的整数

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

(define (sort-seq n)
  (flatMap (lambda (pair) (map (lambda (k) (list (car pair) (cadr pair) k))
                               (enumerate-interval 1 (- (cadr pair) 1))))
           (flatMap (lambda (i) (map (lambda (j) (list i j))
                                     (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 n))
))

(define (make-ok-seq n s)
    (filter (lambda (seq) (= s (+ (car seq) (cadr seq) (caddr seq))))
      (sort-seq n)
    )
  )

(make-ok-seq 10 13)
