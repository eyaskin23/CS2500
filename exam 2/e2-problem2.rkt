;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname e2-problem2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the following (familiar) data definition...


(define-struct leaf [val])
(define-struct node [left right])

; A [BinTree-of X] is one of:
; - (make-leaf X)
; - (make-node [BinTree-of X] [BinTree-of X])
; Interpretation: a binary tree that holds values at the leaves


; TODO 1/1: Finish designing same-tree? that takes two binary trees of numbers
;           and determines if they are the same, both in terms of their
;           structure and the values at their leaves.
;
;           You have been supplied a signature, purpose, and sufficient tests
;           for this function. You are responsible for writing well-designed
;           code to solve this problem based on the template for this data.
;           You may simplify your resulting code but are not required to do so.


; same-tree? : [BinTree-of Number] [BinTree-of Number] -> Boolean
; determines if the supplied binary trees of numbers have the same
; structure and contents

(check-expect (same-tree? (make-leaf 5)
                          (make-leaf 5)) #t)

(check-expect (same-tree? (make-leaf 5)
                          (make-leaf 4)) #f)

(check-expect (same-tree? (make-leaf 5)
                          (make-node (make-leaf 1)
                                     (make-leaf 2))) #f)

(check-expect (same-tree? (make-node (make-leaf 2)
                                     (make-leaf 3))
                          (make-leaf 7)) #f)

(check-expect (same-tree? (make-node (make-leaf 1)
                                     (make-leaf 2))
                          (make-node (make-leaf 1)
                                     (make-leaf 2))) #t) 

(check-expect (same-tree? (make-node (make-leaf 2)
                                     (make-leaf 1))
                          (make-node (make-leaf 1)
                                     (make-leaf 2))) #f)

(check-expect (same-tree? (make-node (make-leaf 1)
                                     (make-node (make-leaf 2)
                                                (make-leaf 3)))
                          (make-node (make-node (make-leaf 1)
                                                (make-leaf 2))
                                     (make-leaf 3))) #f) 

(check-expect (same-tree? (make-node (make-leaf 1)
                                     (make-node (make-leaf 2)
                                                (make-leaf 3)))
                          (make-node (make-leaf 1)
                                     (make-node (make-leaf 2)
                                                (make-leaf 3)))) #t)

(define (leaf-temp l)
  (...
   (leaf-val l) ...))

(define (node-temp n)
  (...
   (node-left n) ...
   (node-right n) ...))
                   
(define (same-tree? bi1 bi2)
  (cond
    [(and (leaf? bi1) (leaf? bi2))
     (if (= (leaf-val bi1) (leaf-val bi2))
         #t
         #f)] 
    [(and (node? bi1) (leaf? bi2)) #f]
    [(and (leaf? bi1) (node? bi2)) #f]
    [(and (node? bi1) (node? bi2))
     (if (and (= (leaf-val (node-right bi1)) (leaf-val (node-right bi2)))
                 (= (leaf-val (node-left bi1)) (leaf-val (node-left bi2))))
                 #t
                 #f)]))






     
     
     
          
            
    


