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

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list nil)
      (filter
        (lambda (positions) (safe? k positions))
        (flatMap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size)
)


; 第k列 第 new-row 行 插入 
(define (adjoin-position new-row k queens)
  (cons (list k new-row) queens))

; 两个item在对角线上 or 在同一行, 此时即不对了
(define (corner-line? a b)
  (and (not (= (car a) (car b)))
       (or (= (cadr a) (cadr b))
           (= (abs (- (car a) (car b)))
              (abs (- (cadr a) (cadr b))))
       )))

; 检测新加入的第k列的女皇是否安全
(define (safe? k positions)
  ; 找出新加的第k列女皇
  (let ((k-queen (car (filter
                        (lambda (item) (= (car item) k))
                        positions))))
    (null? (filter
              (lambda (item) (corner-line? item k-queen))
              positions
              )))
)

; 长度
(define (length sequence)
  (if (null? sequence)
    0
    (+ 1 (cdr sequence))))

; 92
(length (queens 8))