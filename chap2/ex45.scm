(define (split big small n)
  (if (= n 0)
    (lambda (painter) painter)
    (lambda (painter) (let ((smaller (split big small (- n 1))))
      (big painter (small smaller smaller)))))
)

(define right-split (split beside below))
(define up-split (split below beside))