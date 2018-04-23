(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get `deriv (operator exp)) (operands exp) var))
          
          
          ))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

; todo 
(define (put op type item)
  ())
(define (get op type)
  (#f))

(put `deriv `sum 
  (lambda (exp, var) 
    (make-sum (deriv (car exp) var) 
              (deriv (cadr exp) var))))

(put `deriv `product
  (lambda (exp var) 
    (make-sum (make-product (car exp) (deriv (cadr exp) var))
              (make-product (deriv (car exp) var) (cadr exp))
    )))

; (`pow base n)
; 进来这里已经去掉pow 编程 (base n)
(put `deriv `pow
  (lambda (exp var)
    (make-product (cadr exp) (make-pow (car exp) (- (cadr exp) 1)))))

