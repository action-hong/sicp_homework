(define (make-withdraw balance)
  (define (withdraw amount)
    (if (> balance amount)
      (begin (set! balance (- balance amount))
              balance)
      "insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount)))
  (define (dispatch m)
    (cond ((eq? m `withdraw) withdraw)
          ((eq? m `deposit) deposit)
          (else (error "unkown request -- MAKE-ACCOUNT" m))))
  dispatch   
)

; (define w1 (make-withdraw 100))
; (define w2 (make-withdraw 100))
; (w1 50)
; (w2 60)
; (w1 40)
; (w2 50)
; 不过js也可以
; const makeDraw = balance => {
;   return amount => {
;     if (balance > amount) {
;       balance -= amount
;       return balance
;     } else {
;       return 'insufficient funds'
;     }
;   }
; }

; const w1 = makeDraw(100)
; const w2 = makeDraw(100)

; console.log(w1(50));
; console.log(w1(40))
; console.log(w2(40))
; console.log(w2(30))


(define acc (make-withdraw 100))

((acc `withdraw) 50)
((acc `withdraw) 50)
((acc `deposit) 40)
((acc `withdraw) 50)

