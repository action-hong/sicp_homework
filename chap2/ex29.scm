(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))


; b  关键在于如何判定输入的是 活动体 还是 分支
; 左为数字即为分支
(define (is-branch branch)
  (number? (left-branch branch)))

(define (total-weight mobile)
  (if (is-branch mobile)
    (if (number? (branch-structure mobile))
      (branch-structure mobile)
      (total-weight (branch-structure mobile)))
    (+ (total-weight (left-branch mobile) (right-branch mobile)))))

; c

(define (is-balance mobile)
  (if (number? mobile)
    #t
    (balance (left-branch mobile) (right-branch mobile))))

(define (balance left right)
  (if (= (* (branch-length left) (total-weight left))
         (* (branch-length right) (total-weight right)))
    (and (is-balance (branch-structure left)) (is-balance (branch-structure right)))
    #f))

; d 修改下面两个方法

(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))