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

(define p1 (make-point 1 2))
(define p2 (make-point 2 4))

(print-point p1)
(print-point p2)

(define s (make-segment p1 p2))

(print-point (midpoint-segment s))