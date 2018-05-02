(define (make-queue)
  (let ((front-prt `())
        (rear-prt `()))
    (define (set-front-prt! item)
      (set! front-prt item))
    (define (set-rear-prt! item)
      (set! rear-prt item))
    (define (dispatch m)
      (cond ((eq? m `front-prt) front-prt)
            ((eq? m `rear-prt) rear-prt)
            ((eq? m `set-front-prt!) set-front-prt!)
            ((eq? m `set-rear-prt!) set-rear-prt!)
            (else (error "invalid op" m))
            ))
    dispatch
  ))

(define (empty-queue? queue)
  (null? (queue `front-prt)))

(define (front-queue queue)
  (if (empty-queue? queue)
    (error "front called whith an empty queue" queue)
    (car (queue `front-prt))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item `())))
    (cond ((empty-queue? queue)
           ((queue `set-front-prt!) new-pair)
           ((queue `set-rear-prt!) new-pair)
           queue
           )
      (else 
        (set-cdr! (queue `rear-prt) new-pair)
        ((queue `set-rear-prt!) new-pair)
        queue
        ))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue) (error "DELETE! called with an empty queue" queue))
    (else
      ((queue `set-front-prt!) (cdr (queue `front-prt )))
      queue
      )))


(define q1 (make-queue))

(define (print-queue queue)
  (display (queue `front-prt)))

(print-queue (insert-queue! q1 `a))
(print-queue (insert-queue! q1 `b))
(print-queue (delete-queue! q1))
(print-queue (delete-queue! q1))