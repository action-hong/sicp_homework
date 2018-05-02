(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
      (cond 
        ((= trials-remaining 0) (/ trials-passed trials))
        ((experiment) (iter (- trials-remaining 1) (+ trials-passed 1))) 
        (else (iter (- trials-remaining 1) trials-passed))
      )
    )
    (iter trials 0.0)
  )
  (define (estimate-integral-1)
    (P (random-in-range x1 x2) (random-in-range y1 y2))
  )
  (monte-carlo trials estimate-integral-1)
)
  
  (define (pp x y)
    (or (< (+ (square (- x 5)) (square (- y 7))) 9) (= (+ (square (- x 5)) (square (- y 7))) 9))
  )
  
  (define (estimate-pi P x1 x2 y1 y2 trials)
    (/ (* (abs (* (- x2 x1) (- y2 y1))) (estimate-integral P x1 x2 y1 y2 trials)) 9)
  )
  
  (estimate-pi pp 2.0 8.0 4.0 10.0 100000)

  ; 看了网上别人的答案 原来是直接用 2 8 4 10这个矩形呀 擦