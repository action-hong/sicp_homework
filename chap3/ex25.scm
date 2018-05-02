; 推广到 n维 表格的概念 一个值可以保存在任意个关键码下
; lookup 和 insert! 以一个关键码的表作为参数去访问

; 递归即可


(define (make-table same-key?)
  (let ((local-table (list `*table*)))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))
            ))
    (define (lookup keys)
      (lookup-inner keys local-table))
    (define (lookup-inner keys table)
      (let ((record (assoc (car keys) (cdr table))))
        (cond ((not record) #f)
              ((null? (cdr keys)) (cdr record))
              (else (lookup-inner (cdr keys) record))
              )))
    (define (insert! keys value)
      (insert-inner! keys value local-table))
    (define (insert-inner! keys value table)
      (let ((subtable (assoc (car keys) (cdr table))))
        (if (null? (cdr keys))
          (if subtable
            (set-cdr! subtable value)
            (set-cdr! table 
                      (cons (cons (car keys) value)
                            (cdr table))))
          (if subtable
            (insert-inner! (cdr keys) value subtable)
            (begin (set-cdr! table
                            (cons (list (car keys))
                                  (cdr table)))
                    (insert-inner! (cdr keys) value (cadr table))))))
      `ok)
    (define (dispatch m)
      (cond ((eq? m `lookup-proc) lookup)
            ((eq? m `insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))
            ))
    dispatch))

(define operation-table (make-table equal?))
(define get (operation-table `lookup-proc))
(define put (operation-table `insert-proc!))

(define keys `(a b c d))
(define keys2 `(a b c e))

(get keys)
(get keys2)


(put keys 2)
(put keys2 2)

(get keys)
(get keys2)