(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; gcd(206 40)
; gcd(40 6)
; gcd(6 4)
; gcd(4 2)
; gcd(2 0)