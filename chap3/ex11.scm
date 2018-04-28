(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance
    )
  (define (dispatch m)
    (cond ((eq? m `withdraw) withdraw)
      ((eq? m `deposit) deposit)
      (else (error "unknown request -- MAKE-ACCOUNT" m))
      ))
  dispatch
)

(define acc (make-account 50))

((acc `deposit) 40)

((acc `withdraw) 60)

