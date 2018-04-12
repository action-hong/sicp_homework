(define (f g)
  (g 2))

(define (square x)
  (* x x))

(f f)

; 报错, 执行到(g 2)时 即 (f 2) 第二个参数必须是proceduer 而不是2