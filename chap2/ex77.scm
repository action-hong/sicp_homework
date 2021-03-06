; todo 
(define (put op type item)
  ())
(define (get op type)
  (#f))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (error "bad tagged datum -- type-tag" datum)))

(define (contents datum)
  (if (pair? datum)
    (cadr datum)
    (error "bad tagged datum -- contents" datum)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error "no method for these types -- apply-generic" (list op type-tags))))))

(define (add x y)
  (apply-generic `add x y))

(define (sub x y)
  (apply-generic `sub x y))

(define (mul x y)
  (apply-generic `mul x y))

(define (div x y)
  (apply-generic `div x y))

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag `scheme-number x))
  (put `add `(scheme-number scheme-number)
    (lambda (x y) (tag (+ x y))))
  (put `sub `(scheme-number scheme-number)
    (lambda (x y) (tag (- x y))))
  (put `mul `(scheme-number scheme-number)
    (lambda (x y) (tag (* x y))))
  (put `div `(scheme-number scheme-number)
    (lambda (x y) (tag (/ x y))))
  (put `make `scheme-number
    (lambda (x) (tag x)))
  `done)

(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (denom x) (numer y))
                 (* (denom y) (numer x)))
              (* (denom x) (denom y))
                 ))
  (define (sub-rat x y)
    (make-rat (- (* (denom y) (numer x))
                 (* (denom x) (numer y)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))
    ))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (numer y) (denom x))))
  (define (tag x)
    (attach-tag `rational x))
  (put `add `(rational rational)
    (lambda (x y) (tag (add-rat x y))))
  (put `sub `(rational rational)
    (lambda (x y) (tag (sub-rat x y))))
  (put `mul `(rational rational)
    (lambda (x y) (tag (mul-rat x y))))
  (put `div `(rational rational)
    (lambda (x y) (tag (div-rat x y))))
  (put `make `rational
    (lambda (n d) (tag (make-rat n d))))
  `done
  )

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                         (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                        (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
    (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
    (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
    (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
    (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
    (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
    (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (scheme-number->complex n)
  (make-from-real-imag (contents n) 0))

(define (put-coercion fromType toType proc)
  ())
(define (get-coercion fromType toType)
  ())

(put-coercion `scheme-number `complex scheme-number->complex)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if (proc)
        (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            ; 同类型不会去转换 直接报错
            (if (eq? type1 type1)
              (error "can not cast some type" (list type1 type2))
              (let ((t1->t2 (get-coercion type1 type2))
                  (t2->t1 (get-coercion type2 type1)))
              (cond (t1->t2 
                      (apply-generic op (t1->t2 a1) a2))
                    (t2->t1
                      (apply-generic op a1 (t2->t1 a2)))
                    (else 
                      (error "No method for these types" (list op type-tags)))))
            ; 类型转化寻找
            ))
          (error "no method for these types" (list op type-tags)))))))
