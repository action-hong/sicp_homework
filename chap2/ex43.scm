(define (queens-42 board-size)
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

(define (queens-43 board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list nil)
      (filter
        (lambda (positions) (safe? k positions))
        (flatMap
          (lambda (new-row)
            (map (lambda (rest-of-queens)
                   (adjoin-position new-row k rest-of-queens))
                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size))))
  (queen-cols board-size)
)

; 该文件无法运行
; 因为缺乏一些计算的procedure实现

; 简单来说  42中 只需各运算 (queen-cols 1) (queen-cols 2) ... (queen-cols 8)一次
; 43 中 ((queen-cols 1) (queen-cols 2) ... (queen-cols 8)) 各运算八次

;显然 43肯定比较慢