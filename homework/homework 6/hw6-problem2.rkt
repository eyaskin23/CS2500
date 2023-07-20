;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hw6-problem2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; It's super useful to be able to answer the question: does a value appear
; in a list? But of course that question can be phrased multiple ways...

; TODO 1/3: Design two functions: string-in-list? and string-in-list-ci?.
;           The first returns #true if a supplied string appears
;           *exactly* in a list of strings, whereas the second returns
;           #true if a supplied string occurs in a list of strings if
;           we ignore lower/upper-case. You have been supplied some tests
;           for clarity (which you can use in your design, but should
;           supplement). Make sure your code follows the list template!

; string-in-list?: String [List-of String] -> Boolean
; is the given string in the list with matching caps?

(check-expect (string-in-list?/old "" '()) #f)
(check-expect (string-in-list?/old "a" (list "a" "b" "c")) #t)
(check-expect (string-in-list?/old "A" (list "a" "b" "c")) #f)
(check-expect (string-in-list?/old "world" (list "hello" "world" "cs2500")) #t)
(check-expect (string-in-list?/old "worlD" (list "hello" "world" "cs2500")) #f)
(check-expect (string-in-list?/old "a" (list "hello" "world" "cs2500")) #f)

(define (string-in-list?/old s los)
  (cond [(empty? los) #f]
        [(cons? los) (or (string=? s (first los))
                         (string-in-list?/old s (rest los)))])) 

; string-in-list-ci?: String [List-of String] -> Boolean
; is the given string in the list with or without matching caps?

(check-expect (string-in-list-ci?/old "" '()) #f)
(check-expect (string-in-list-ci?/old "a" (list "a" "b" "c")) #t)
(check-expect (string-in-list-ci?/old "A" (list "a" "b" "c")) #t)
(check-expect (string-in-list-ci?/old "world" (list "hello" "world" "cs2500")) #t)
(check-expect (string-in-list-ci?/old "WORLD" (list "hello" "world" "cs2500")) #t)
(check-expect (string-in-list-ci?/old "a" (list "hello" "world" "cs2500")) #f)

(define (string-in-list-ci?/old s los)
  (cond [(empty? los) #f]
        [(cons? los) (or (string=? (string-upcase s) (string-upcase (first los)))
                     (string-in-list-ci?/old s (rest los)))]))

; TODO 2/3: Those two functions probably feel rather similar - so now
;           design the abstraction value-in-list? based on these two
;           functions.

;           Notes:
;           - Think through your signature to make sure it is as general
;             as possible, while still not making promises your abstraction
;             cannot keep!
;           - Don't forget to improve your implementations for the last
;             step! (Importantly: keep the old code by renaming the
;             functions string-in-list?/old and string-in-list-ci?/old;
;             you do not need to change/reproduce any parts of the function
;             design recipe for these old function implementations.)

; value-in-list?: X [List-of X] [X -> Boolean] -> Boolean
; Checks if the given value in the list.

(define (value-in-list? lox)
  (cond
    [(empty? lox) #f]
    [(cons? lox) (or (x->b


; TODO 3/3: Now put your fancy new abstraction to good use! Design the function
;           anything-bigger? that determines if any of a list of numbers is
;           bigger than a supplied number. You have been supplied some tests
;           for clarity (which you can use in your design, but should supplement).

; anything-bigger?: Number [List-of Number] -> Boolean
; is any value in the list greater than the given number?


(check-expect (anything-bigger? 5 (list 10 -1 3)) #t)
(check-expect (anything-bigger? 100 (list 10 -1 3)) #f)


(define (anything-bigger? n lon)


