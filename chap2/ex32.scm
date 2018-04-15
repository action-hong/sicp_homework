(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (t) (append t (car s))) rest)))))

(subsets (list 1 2 3))

; 类似之前换零钱的思路
; 一个表的所有子集  =  该表去掉第一个元素的所有子集  +   (map (添加去掉的第一个元素) (该表去掉第一个元素的所有子集 ))  