(define (make-queue)
  (cons `() `()))

(define (front-prt queue)
  (car queue))
(define (rear-prt queue)
  (cdr queue))
(define (set-front-prt! queue item)
  (set-car! queue item))
(define (set-rear-prt! queue item)
  (set-cdr! queue item))

(define (empty-queue? queue)
  (null? (front-prt queue)))

(define (front-queue queue)
  (if (empty-queue? queue)
    (error "front called whith an empty queue" queue)
    (car (front-prt queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item `())))
    (cond ((empty-queue? queue)
           (set-front-prt! queue new-pair)
           (set-rear-prt! queue new-pair)
           queue
           )
      (else 
        (set-cdr! (rear-prt queue) new-pair)
        (set-rear-prt! queue new-pair)
        queue
        ))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue) (error "DELETE! called with an empty queue" queue))
    (else
      (set-front-prt! queue (cdr (front-prt queue)))
      queue
      )))


(define q1 (make-queue))

(define (print-queue queue)
  (display (front-prt queue)))

(print-queue (insert-queue! q1 `a))
(print-queue (insert-queue! q1 `b))
(print-queue (delete-queue! q1))
(print-queue (delete-queue! q1))
