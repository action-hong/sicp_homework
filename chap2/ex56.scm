(define (variable? x)
  (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (make-sum a1 a2)
  (list `+ a1 a2))
(define (make-product m1 m2)
  (list `* m1 m2))
(define (sum? x)
  (and (pair? x) (eq? (car x) `+)))
(define (addend x)
  (and (pair? x) (cadr x)))
(define (augend x)
  (and (pair? x) (caddr x)))
(define (product? x)
  (and (pair? x) (eq? (car x) `*)))
(define (multiplier x)
  (and (pair? x) (cadr x)))
(define (multiplicand x)
  (and (pair? x) (caddr x)))

(define (deriv exp var)
  (cond ((number? exp) 0)
         ((variable? exp)
          (if (same-variable? exp var) 1 0))
         ((sum? exp)
          (make-sum (deriv (addend exp) var)
                    (deriv (augend exp) var)))
         ((product? exp))
          (make-sum
            (make-product (multiplier exp)
                          (deriv (multiplicand exp) var)
            (make-product (multiplicand exp)
                          (deriv (multiplier exp) var))))
         (else
          (error "unknow expression type -- DERIV" exp))))

; 基于抽象数据表述
; 无论导数表达式如何表示, 只需实现正确的选择函数和构造函数, 即可工作

(deriv `(+ x 3) `x)

(deriv `(* x y) `x)

(deriv `(* (* x y) (+ x 3)) `x)
