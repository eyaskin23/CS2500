;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m6_l1_v2p3_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; == Function Abstraction ==
; 1. Implement functions
; 2. Compare, identify similarities/differences
; 3. Extract differences as parameters in a newly designed function
; 4. Re-implement the original functions using the new function


; A ListOfNumbers (LoN) is one of
; - '()
; - (cons Number LoN)
; Interpretation: a list of numbers
 
(define LON-0 '())
(define LON-1 (cons 3 LON-0))
(define LON-2 (cons -4 LON-1))
 
(define (lon-temp lon)
  (...
   (cond
     [(empty? lon) ...]
     [(cons? lon) ...
      (first lon) ...
      (lon-temp (rest lon)) ...])))

; a) Design the function negate, which accepts
; a ListOfNumbers and multiplies each by -1

; negate : LoN -> LoN
; negates all the numbers in the list

(check-expect
 (negate LON-0)
 LON-0)

(check-expect
 (negate LON-2)
 (cons 4
       (cons -3 '())))

(define (negate lon)
  (cond
    [(empty? lon) lon]
    [(cons? lon)
     (cons
      (* -1 (first lon))
      (negate (rest lon)))]))

; b) Design the function double, which accepts
; a ListOfNumbers and multiplies each by 2

; double : LoN -> LoN
; doubles all the values in the list

(check-expect
 (double LON-0)
 LON-0)

(check-expect
 (double LON-2)
 (cons -8
       (cons 6 '())))

(define (double lon)
  (cond
    [(empty? lon) lon]
    [(cons? lon)
     (cons
      (* 2 (first lon))
      (double (rest lon)))]))






