(define (make-deque)
  (list `() `()))
(define (front-prt deque)
  (car deque))
(define (rear-prt deque)
  (cdr deque))
(define (set-front-prt! deque item)
  (set-car! deque item))
(define (set-rear-prt! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (front-prt deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" deque)
    (car (front-deque deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "REAR called with an empty deque" deque)
    (car (rear-deque deque))))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons item `())))
    (cond ((empty-deque? deque)
           (set-front-prt! deque new-pair)
           (set-rear-prt! deque new-pair)
           deque
           )
      (else
        (set-front-prt! deque (cons item (front-prt deque)))
        deque
        )))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item `())))
    (cond ((empty-deque? deque)
           (set-front-prt! deque new-pair)
           (set-rear-prt! deque new-pair)
           deque
           )
      (else
        (set-cdr! (rear-prt deque) new-pair)
        (set-rear-prt! deque new-pair)
        deque
        ))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque) (error "DELETE! called with an empty deque" deque))
    (else 
      (set-front-prt! deque (cdr front-prt deque))
      deque
      ))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque) (error "DELETE! called with an empty deque" deque))
    (else 
      
      )))

; TODO:
; 删除尾部如何在 O(1)时间完成?   记录最后一个的前一个嗯 ?