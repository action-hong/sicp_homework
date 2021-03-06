(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (variable? x)
  (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list `+ a1 a2))
        ))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list `* m1 m2))
        ))
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
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) `**)))
(define (base x)
  (and (pair? x) (cadr x)))
(define (exponent x)
  (and (pair? x) (caddr x)))
(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list `** base exponent)))
)

(define (deriv exp var)
  (cond ((number? exp) 0)
         ((variable? exp)
          (if (same-variable? exp var) 1 0))
         ((sum? exp)
          (make-sum (deriv (addend exp) var)
                    (deriv (augend exp) var)))
         ((product? exp)
          (make-sum
            (make-product (multiplier exp)
                          (deriv (multiplicand exp) var))
            (make-product (multiplicand exp)
                          (deriv (multiplier exp) var))))
         ((exponentiation? exp)
          (make-product (exponent exp)
                        (make-exponentiation (base exp)
                                             (- (exponent exp) 1))))
         (else
          (error "unknow expression type -- DERIV" exp))))

; 基于抽象数据表述
; 无论导数表达式如何表示, 只需实现正确的选择函数和构造函数, 即可工作

(deriv `(+ x 3) `x)

(deriv `(* x y) `x)

(deriv `(* (* x y) (+ x 3)) `x)
