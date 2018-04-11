; 杨辉三角

(define (pascal n)
  ; 显示第line行第index个
  (define (num index line)
    (if (or (= index 1) (= index line) (= line 1))
      1
      (+ (num (- index 1) (- line 1)) 
         (num index (- line 1)))))
  ; 展示每一行
  (define (pascal-line currentLine totalLine)
    (define (display-line-internal index line)
      (display (num index line))
      (cond ((< index line) (display-line-internal (+ index 1) line)))
    )
    (display-line-internal 1 currentLine)
    (display "\n")
    (cond ((< currentLine totalLine) (pascal-line (+ currentLine 1) totalLine)))
  )
  (pascal-line 1 n)
)

(pascal 5)

(pascal 7)

; 上述函数中获取某行某个数是使用递归的

; 可否使用迭代?