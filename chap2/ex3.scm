(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (midpoint-segment segment)
  (let ((p1 (start-segment segment))
        (p2 (end-segment segment)))
    (make-point (/ (+ (x-point p1) (x-point p2)) 2)
          (/ (+ (y-point p1) (y-point p2)) 2)
    )))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
)

; 构建矩形, 任意一个对角线的两个点

(define (make-rectangle left-top-point right-bottom-point)
  (make-segment left-top-point right-bottom-point))

(define (left-top-point rectangle)
  (start-segment rectangle))

(define (right-bottom-point rectangle)
  (end-segment rectangle))

(define (one-line-length rectangle)
  (abs (- (x-point (left-top-point rectangle))
          (x-point (right-bottom-point rectangle))
  ))  
)

(define (another-line-length rectangle)
  (abs (- (y-point (left-top-point rectangle))
          (y-point (right-bottom-point rectangle))
  )) 
)

; 周长
(define (cal-perimeter rectangle)
  (* 2 (+ (one-line-length rectangle)
          (another-line-length rectangle))))

; 面积
(define (cal-area rectangle)
  (* (one-line-length rectangle)
     (another-line-length rectangle)))

(define r1 (make-rectangle (make-point 2 0) (make-point 0 2)))

(cal-perimeter r1)
(cal-area r2)