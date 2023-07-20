;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Practice problem |) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; boolean logic sample problem:
; signature: Foo: String Number Number -> Number
(define (foo x y z)
  (if (and (even? (string-length x)) (> y 5)) z 0))

; (if boolean result 1 result 2)

(check-expect (foo "fundies" 6 1) 0)
; (if (and (even? (string-length "fundies")) (> 6 5)) 1 0))
; (if (and #f 1 0)

; Design the data type "Fruit" that is available at our "Fundies 1 Grocery"

; A Fruit is one of:
; - "banana"
; - "mango"
; - "apple"
; Interpretation: A fruit that is available at our grocery store

; Examples:
(define F-BANANA "banana")
(define F-MANGO "mango")
(define F-APPLE "apple")


; Design a function that returns the color of a fruit
; Fruit-Color : Fruit -> Color
; Purpose: Returns the color of a given fruit


(check-expect (fruit-color F-MANGO) "orange")
(check-expect (fruit-color F-BANANA) "yellow")
(check-expect (fruit-color F-APPLE) "red")

(define (fruit-color f)
    (cond [(string=? f F-BANANA) "yellow"]
          [(string=? f F-MANGO) "orange"]
          [(string=? f F-APPLE) "red"]))





