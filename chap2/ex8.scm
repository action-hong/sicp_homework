(define (make-interval a b)
  (cons a b))

(define (upper-bound interval)
  (if (> (car interval) (cdr interval))
    (car interval)
    (cdr interval)))

(define (lower-bound interval)
  (if (< (car interval) (cdr interval))
    (car interval)
    (cdr interval)))

; 两个区间的差计算

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

          