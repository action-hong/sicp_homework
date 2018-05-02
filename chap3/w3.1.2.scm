(define (rand)
  (let ((x random-init))
    (lambda () 
      (set! x (rand-update x))
      x)))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))


(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0) 
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else 
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0)
)

;-------------------------------------------------------------------
; 比较上面的方法由于没有随机数局部生成器, 每次都要自己去生成两个 随机数 x1 x2
; 如果是需要三个随机数, 又得重新修改代码
; 而上面的方法只需修改随机数局部生成器`
(define (estimate-pi-2 trials)
  (sqrt (/ 6 (random-gcd-test trials random-init))))

(define (random-gcd-test trials initial-x)
  (define (iter trials-remaining trials-passed x)
    (let ((x1 (rand-update x)))
      (let ((x2 (rand-update x1)))
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
              ((= (gcd x1 x2) 1)
               (iter (- trials-remaining 1)
                     (+ trials-passed 1)
                     x2))
              (else 
                (iter (- trials-remaining 1)
                      trials-passed
                      x2))
                     ))))
  (iter trials 0 initial-x)
;-------------------------------------------------------------------