(define (make-leaf symbol weight)
  (list `leaf symbol weight))

(define (leaf? object)
  (eq? `leaf (car object)))

(define (symbol-leaf x)
  (cadr x))
(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))
        ))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

(define (choose-branch bit branch)
    ;0 向左 1向右
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit --CHOOSE-BRANCH" bit))
        ))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      `()
      (let ((next-branch (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch) (decode-1 (cdr bits) current-branch))
          (decode-1 bits next-branch))))  
  )
  (decode-1 bits tree)
)

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))
    ))

(define (make-leaf-set pairs)
  (if (null? pairs)
    `()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)   ;symbol
                             (cadr pair))  ; frequency or weight
                  (make-leaf-set (cdr pairs))
      ))))

(define sample-tree 
  (make-code-tree (make-leaf `a 4)
                  (make-code-tree 
                    (make-leaf `b 2)
                    (make-code-tree (make-leaf `c 1)
                                    (make-leaf `d 1))
                    )
  ))

(define (encode message tree)
  (if (null? message)
    `()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

; 类似深度优先遍历
(define (encode-symbol symbol tree)
  (define (find-symbol code current-branch)
    (if (leaf? current-branch)
      (if (eq? (symbol-leaf current-branch) symbol)
        code
        #f)
      (let ((answer (find-symbol (append code (list 0)) (left-branch current-branch))))
        (if (pair? answer)
          answer
          (find-symbol (append code (list 1)) (right-branch current-branch)))))
      
  )
  (let ((res (find-symbol `() tree)))
    (if (pair? res)
    res
    (error "invalid symbol!" symbol)))
  
)

(define message `(a c a b b c a))

(display (encode message sample-tree))