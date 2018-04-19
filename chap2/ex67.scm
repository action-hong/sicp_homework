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

(define items (list (list `A 4) (list `B 2) (list `C 1) (list `D 1)))

(display (make-leaf-set items))

(define sample-tree 
  (make-code-tree (make-leaf `a 4)
                  (make-code-tree 
                    (make-leaf `b 2)
                    (make-code-tree (make-leaf `c 1)
                                    (make-leaf `d 1))
                    )
  ))

(define sample-message `(0 1 1 0 0 1 0 1 0 1 1 1 0))

(display (decode sample-message sample-tree))



