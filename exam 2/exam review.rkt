;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |exam review|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Multiple Inputs

; Consider the following data definition:

; A BasePair is one of:
; - "A"
; - "C"
; - "T"
; - "G"
; Interpretation: a single base pair in DNA

; A Sequence is a [List-of Base Pair]
; Interpretation: A Sequence of DNA

; Exercise:
; Design the number num-matches that accepts two sequences and returns
; the number of places where they contain the same base pair.

; num-matches : Sequence Sequence -> Nat
; returns the number of places where the sequence matches

(check-expect (num-matches (explode "ATGACT") (explode "A")) 1)
(check-expect (num-matches (explode "ATGACT") (explode "TGCATT")) 2)
(check-expect (num-matches (explode "TGCC") (explode "TGCATT")) 3)
(check-expect (num-matches (explode "AATGACTA") (explode "ATGCATTA")) 4)

(define (num-matches seq1 seq2)
  (cond
    [(or (empty? seq1) (empty? seq2)) 0]  
    [(and (cons? seq1) (cons? seq2))
     (if (string=? (first seq1) (first seq2))
         (add1 (num-matches (rest seq1) (rest seq2)))
         (num-matches (rest seq1) (rest seq2)))]))
       
; Exercise:
; Design the function same-sequence? that accepts two sequences and
; returns whether or not they are the same.

; same-sequence? : Sequence Sequence -> Boolean
; Returns whether or not the sequences are the same

(check-expect (same-sequence? (explode "ATGACT") (explode "TGCATT")) #false)

(define (same-sequence? seq1 seq2)
  (cond [(and (empty? seq1) (empty? seq2)) #true]  
        [(and (empty? seq1) (cons? seq2)) #false]
        [(and (cons? seq1) (empty? seq2)) #false]
        [(and (cons? seq1) (cons? seq2))
         (and (string=? (first seq1) (first seq2))
              (same-sequence? (rest seq1) (rest seq2)))]))


; LOCAL/LAMBDA

; Exercise:
; Design a function that determines if every number in a list is bigger than a supplied number.

; all-bigger-than-n? : [List-of Number] Number -> Boolean
; are all numbers bigger than n?

(check-expect (all-bigger-than-n? (list 1 2 3) 0) #true)
(check-expect (all-bigger-than-n? (list 1 2 3) 2) #false)
                       
(define (all-bigger-than-n? lon n)
 (andmap (λ (x) (> x n)) lon))

; Exercise:
; Design a function that negates a predicate.

; negate : (X) [X -> Boolean] -> [X -> Boolean]
; negates p

(check-expect ((negate even?) 2) (odd? 2))
(check-expect ((negate even?) 3) (odd? 3))

(define (negate p?)
  (λ (x) (not (p? x))))

; mycompose : (X Y Z) [X -> Y] [Y -> Z] -> [X -> Z]
; composes two functions

(check-expect ((mycompose add1 add1) 2) 4)
(check-expect ((mycompose add1 add1) 4) 6)

(define (mycompose f g)
  (λ (x)
    (g (f x))))





         