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

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; pairs 是有序的 从小到大

; 1. 每次取最小的两个合并成新的
; 2. 将新的加到(删掉刚刚两个最小的)列表中
(define (successive-merge pairs)
  (if (= (length pairs) 1)
    (car pairs)
    (let ((c-tree (make-code-tree (car pairs) (cadr pairs))))
      (successive-merge (adjoin-set c-tree (cddr pairs)))))
)

(define pairs `((a 4) (b 3) (c 2) (d 2) (e 1) (f 2)))

(define myTree (generate-huffman-tree pairs))

(display myTree)
; 没毛病
;( ((leaf b 3) ((leaf e 1) (leaf f 2) (e f) 3) (b e f) 6) 
;  ((leaf a 4) ((leaf d 2) (leaf c 2) (d c) 4) (a d c) 8) (b e f a d c) 14)

(encode `(a) myTree)
(encode `(b) myTree)
(encode `(c) myTree)
(encode `(d) myTree)
(encode `(e) myTree)
(encode `(f) myTree)