;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |process of abstracting functions pt.3 |) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (multiply-by lon -1))

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
  (multiply-by lon 2))

; multiply-by : LoN Numer -> LoN
; multiply all values by the supplied value

(check-expect
 (multiply-by LON-0 100)
 LON-0)

(check-expect
 (multiply-by LON-2 100)
 (cons -400
       (cons 300 '())))

(define (multiply-by lon n)
  (cond
    [(empty? lon) lon]
    [(cons? lon)
     (cons
      (* n (first lon))
      (multiply-by (rest lon) n))]))









