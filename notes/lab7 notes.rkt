;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |lab7 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; build-list : {X} Nat [Nat -> X] -> [List-of X]
; takes in a number of elements and function to create each element

#; (check-expect (identity 1) 1)
#; (check-expect (identity "hi") "hi")

#; (check-expect (build-list 5 identity) (list 0 1 2 3 4))
#; (check-expect (build-list 5 add1) (list 1 2 3 4 5))

#; (check-expect (build-list 5 number->string) (list "0" "1" "2" "3" "4"))

#; (check-expect (build-list 10 number->string) (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))

; andmap {X} [X -> Boolean] [List-of X] -> Boolean
; returns true if at least one (any) of the elements follow the predicate 

(check-expect (andmap string? (list))
              true)

(check-expect (andmap string? (list "a" "b" "c"))
              ...)

(check-expect (andmap string? (list "a" "b" 0))
              ...)

; ormap : {X} [X -> Boolean] [List-of X] -> Boolean
; returns true if at least one of the elements follows the predicate

(check-expect (ormap string? (list))
              #false)

(check-expect (ormap string? (list "a" "b" "c"))
              #true)

(check-expect (ormap string? (list #false 0))
              #false)

(define (equal-x? s)
  (string=? s "x"))

(check-expect (ormap equal x? (list "x" "x")) #true)
(check-expect (ormap equal x? (list "y" "z")) #false)

                     
