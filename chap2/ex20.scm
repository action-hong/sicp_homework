(define (is-same-parity a b)
  (= (remainder a 2)
     (remainder b 2)))

(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

; --------为这么下列做法会报错---------------------------------
; 以为(some-parity x (cdr items)) 这不第二个参数传入
; 此时是讲该参数封装成一个长度为以的 list, 故(car items)时是返回一个list

; (define (same-parity x . items)
;   (if (is-same-parity x (car items))
;     (list)
;     (if (null? (cdr items))
;       (cons (car items) nil)
;       (append (cons (car items) nil) (same-parity x (cdr items)))))
; )

; (some-parity 1 2 3 4 5 6 7)
; -----------------------------------------------------------

(define (same-parity x . items)
  (define (same-parity-intern items)
    (if (null? items)
      nil
      (if (is-same-parity x (car items))
        (cons (car items) (same-parity-intern (cdr items)))
        (same-parity-intern (cdr items)))))
  (same-parity-intern items)
)

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

; 映射 如同 Array.property.map
(define (map fun items)
  (if (null? items)
    nil
    (cons (fun (car items)) (map fun (cdr items)))))

(map (lambda (x) (* x 10)) (list 1 2 3 4 5))

; 过滤函数
(define (filter fun items)
  (if (null? items)
    nil
    (if (fun (car items))
      (cons (car items) (filter fun (cdr items)))
      (filter fun (cdr items)))))

(define (same-parity-1 x . items)
  (filter (lambda (i) (is-same-parity x i))) items)