;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |abstraction notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; == Function Abstraction
; 1. Implement functions
; 2. Compare, identify similarities/differences
; 3. Extract differences as parameters in a newly designed funciton
; 4. Re-implement the original functions using the new function


; A ListOfStrings (LoS) is one of
; - '()
; - (cons String LoS)
; Interpretation: a list of strings

(define LOS-0 empty)
(define LOS-1 (cons "alice" LOS-0))
(define LOS-2 (cons "bob" LOS-1))

(define (los-temp los)
  (...
   (cond
     [(empty? los) ...]
     [(cons? los) ...]
     (first los) ...
     (los-temp (rest los)) ...)))

; a) Design the function prefix-with-from, which accepts
; a ListOfStrings and prefixes every string with "From: "


; prefix-with-from : LoS -> LoS
; prefix all strings with "From:"

(check-expect
 (prefix-with-from LOS-0)
 LOS-0)

(check-expect
 (prefix-with-from LOS-2)
 (cons "From: bob"
       (cons "From: alice" '())))

(define (prefix-with-from los)
  (prefix-with los "From: "))

; b) Design the function prefix-with-to, which accepts a
; ListOfStrings and prefixes every string with "To: "

; prefix-with-to: LoS -> LoS
; prefixes all strings with "To: "

(check-expect
 (prefix-with-to LOS-0)
 LOS-0)

(check-expect
 (prefix-with-to LOS-2)
 (cons "To: bob"
       (cons "To: alice" '()))) 

(define (prefix-with-to los)
  (prefix-with los "To: "))
 
; prefix-with : LoS String -> LoS
; prefixes all strings with the supplied prefix

(check-expect
 (prefix-with LOS-0 "Hello! ")
 LOS-0)

(check-expect
 (prefix-with LOS-2 "Hello! ")
 (cons "Hello! bob"
       (cons "Hello! alice" '())))

(define (prefix-with los prefix)
  (cond
    [(empty? los) los]
    [(cons? los)
     (cons
      (string-append prefix (first los)) 
      (prefix-with (rest los) prefix))]))




    

