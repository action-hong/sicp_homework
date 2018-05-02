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
      (let ((record (assoc (car keys) table)))
        (cond ((null? record) #f)
              ((null? (cdr keys)) (cdr record))
              (else (lookup-inner (cdr keys) record))
              )))
    (define (insert! keys value)
      (insert-inner! keys value local-table))
    (define (insert-inner! keys value table)
      (let ((subtable (assoc (car key) table)))
        (if (null? (cdr keys))
          (set-cdr! subtable value)
          ())))
    ; (define (lookup key-1 key-2)
    ;   (let ((subtable (assoc key-1 (cdr local-table))))
    ;     (if subtable
    ;       (let ((record (assoc key-2 (cdr subtable))))
    ;         (if record
    ;           (cdr record)
    ;           #f))
    ;       #f)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record 
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1
                                (cons key-2 value))
                          (cdr local-table)))))
      `ok)
    (define (dispatch m)
      (cond ((eq? m `lookup-proc) lookup)
            ((eq? m `insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))
            ))
    dispatch))