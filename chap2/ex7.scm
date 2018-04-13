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