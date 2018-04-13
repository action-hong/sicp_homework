; 这题目用到的思想之前在学廖雪峰的python还是js教程上有看到额

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define (foo x)
  (display "*"))

; (add-1 zero)
; (lambda (f) (lambda (x) (f x)))
((one foo) 1)

; (add-1 one)
; n = one
; (n f) => (one f) => (lambda (x) (f x))
; ((n f) x) => (f x)
; ; (lambda (f) (lambda (x) (f ((n f) x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (lambda (f) (lambda (x) (f (f (f x))))))

((three foo) 1)

(define (add a1 a2)
  (lambda (f) (lambda (x)
    ; a2    +   a1
    ; ((a1 f) x) 调用a1次, 作为返回值 给 (a2 f)做参数, 调用a2次
    ; 刚好 a1 + a2次
    ((a2 f) ((a1 f) x))
  ))
)

; *****
(((add two three) foo) 1)

(newline)

; ******
(((add two (add two two)) foo) 1)

(newline)

; ********
(((add (add three one) (add two two)) foo) 1)

(newline)