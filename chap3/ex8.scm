(define f (let ((init 0))
  (lambda (num)
    (if (= init 0)
      (begin (set! init 1) num)
      0)))) 

(+ (f 0) (f 1))
; (+ (f 1) (f 0))

; init 必须是在外面, 如何在 lambda里面 的话,
; 由于每次 调用 lambda  都会 建一个新的 scope, 那样每次调用的 init就都是0, 无法起到效果