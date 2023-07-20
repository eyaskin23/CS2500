;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |designing binary-tree data|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; albus is the child of harry and ginny
; harry is the child of lily and james
; ginny is the child of molly and author
; either known or unknown identity/ancestry

(define-struct person [name parent1 parent2])

; A Person is one of:
; - #false
; - (make-person String Person Person)
; Interpretation: a person's name and biological
; parents; or #false if not known

(define PERSON-0 #false)
(define PERSON-LILY
  (make-person "lily" PERSON-0 PERSON-0))
(define PERSON-JAMES
  (make-person "james" PERSON-0 PERSON-0))
(define PERSON-ARTHUR
  (make-person "arthur" PERSON-0 PERSON-0))
(define PERSON-MOLLY
  (make-person "molly" PERSON-0 PERSON-0))

(define PERSON-HARRY
  (make-person "harry" PERSON-LILY PERSON-JAMES))

(define PERSON-GINNY
  (make-person "ginny" PERSON-MOLLY PERSON-ARTHUR))

(define PERSON-ALBUS
  (make-person "albus" PERSON-HARRY PERSON-GINNY))

(define (person-temp p)
  (...
   (cond
     [(boolean? p) ...]
     [(person p) ...
      (person-name p)
      (person-temp (person-parent1 p)) ...
      (person-temp (person-parent2 p)) ...])))

; Design the function tree-size that takes in a person
; and returns the numnber of named people in the tree.

; tree-size : Person -> Nat
; number of named people in the tree

(check-expect
 (tree-size PERSON-0)
 0)

(check-expect
 (tree-size PERSON-LILY)
 1)

(check-expect
 (tree-size PERSON-HARRY)
 3)

(check-expect
 (tree-size PERSON-ALBUS)
 7)

(define (tree-size p)
  (cond
    [(boolean? p) 0]
    [(person? p)
     (+ 1
        (tree-size (person-parent1 p))
        (tree-size (person-parent2 p)))]))

; Design the function tree-depth that takes in a Person
; and returns the deepest "path" in the tree.

; tree-depth : Person -> Nat
; depth of the deepest path in the tree

(check-expect
 (tree-depth PERSON-0)
 0)

(check-expect
 (tree-depth PERSON-JAMES)
 1)

(check-expect
 (tree-depth PERSON-GINNY)
 2)

(check-expect
 (tree-depth PERSON-ALBUS)
 3)

(define (tree-depth p)
  (cond
    [(boolean? p) 0]
    [(person? p)
     (add1
     (max
      (tree-depth (person-parent1 p))
      (tree-depth (person-parent2 p))))]))





        
     
   
              
     
