; a左 b右 组成新的图
(define (beside a b)
  ())

; a 放在b下
(define (below a b)
  ())

; a 垂直翻转
(define (flip-vert painter)
  ())
; 水平翻转
(define (flip-horiz painter)
  ())

; 组合操作

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

; 右边分割
(define (right-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (right-split painter (- n 1))))
      (beside painter (below smaller smaller)))))

; 向上和向右
(define (corner-split painter n)
  (if (= n 0)
    painter
    (let ((up (up-split painter (- n 1)))
          (right (right-split painter (- n 1))))
      ((let ((top-left (beside up up))
             (bottom-right (below right right))
             (corner (corner-split painter (- n 1))))
        (beside (below painter top-left)
                (below bottom-right corner)))))))

; ex
(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split painter (- n 1))))
      (below painter (beside smaller smaller)))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    ((let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half)))))

; 抽象, 组成后的图片看成四块图片, 这四块是分别用何种过程产生的
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom up))))

; 这样就清晰了了
; 该过程组成的图形中, 左上角为原图, 右上角为垂直翻转, 左下不变, 右下垂直翻转
(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))