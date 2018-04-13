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

(define (make-center-percent c w)
  (let ((t (* c w 0.01)))
    (make-interval (- c t)
                   (+ c t)))
)

(define (center i)
  (/ (+ (lower-bound i)
        (upper-bound i))
        2))

(define (width i)
  (/ (- (upper-bound i)
        (lower-bound i))
        2))

(define (percent i)
  (* (/ (width i) (center i))
     100)
)

(define t (make-center-percent 10 5))

(percent t)
(width t)
(center t)