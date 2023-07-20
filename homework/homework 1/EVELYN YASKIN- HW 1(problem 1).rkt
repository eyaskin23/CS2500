;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EVELYN YASKIN- HW 1(problem 1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Understanding code that doesn't have effective naming and documentation
; can be really challenging! (That's part of the reason that this class, and
; most organizations with software-development teams, employ style guides.)

; As an example, consider the confusing functions defined below...

; Hints:
;  - For built-in functions that aren’t familiar to you,
;    be sure to look them up in the DrRacket documentation!
;  - Once you have a theory about what a function is doing, try
;    running it in the interactions window, then try changing
;    parameters to confirm how it all works!
;  - You might start with smaller, simpler functions, and
;    then that can help understand bigger ones (that use them!)


; String and Number --> String
; Capitalizes string assigned to the value a, and adds the number of
;exclamation marks assigned to the value of b
(define (nonplus1 a b)
  (string-append
   (string-upcase a)
   (replicate b "!")))


; String and Number --> Number
; It determines the minimum value from the number assigned to a, the
;string-length, as well as the number assigned to b)
(define (nonplus2 a b c)
  (min
   (max
    (string-length b)
    a)
   c))


; String and Number and Color--> String and Image
; This function prints the string in all capital letters in the specific
;color as well as the amount of stars assigned to the c value. 
(define (nonplus3 a b c)
  (above
   (text (nonplus1 a b) 30 c)
   (text (replicate (nonplus2 b a 5) "⭐") 20 c)))




; TODO 2/2:

(define NONPLUS1-ACTUAL (nonplus1 "hello" 3))
(define NONPLUS1-EXPECTED "HELLO!!!")

(define NONPLUS2-ACTUAL (nonplus2 4 "hello" 5))
(define NONPLUS2-EXPECTED 5)

(define NONPLUS3-ACTUAL (nonplus3 "fundamentals" 5 "red"))
(define NONPLUS3-EXPECTED
  (above
   (text "FUNDAMENTALS!!!!!" 30 "red")
   (text "⭐⭐⭐⭐⭐" 40 "red")))











