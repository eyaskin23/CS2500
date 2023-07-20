;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EVELYN YASKIN-hw 2 problem 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; valid-5mc?: 1String -> Boolean
; States whether the given string is a valid answer to a 5 option multiple choice question. 

(check-expect (valid-5mc? "A") #true)
(check-expect (valid-5mc? "B") #true)
(check-expect (valid-5mc? "C") #true)
(check-expect (valid-5mc?"D") #true)
(check-expect (valid-5mc? "E") #true)
(check-expect (valid-5mc? "a") #true)
(check-expect (valid-5mc? "b") #true)
(check-expect (valid-5mc? "c") #true)
(check-expect (valid-5mc? "d") #true)
(check-expect (valid-5mc? "e") #true)
(check-expect (valid-5mc? "f") #false)
(check-expect (valid-5mc? "7") #false)
(check-expect (valid-5mc? "?") #false)
(check-expect (valid-5mc? "Z") #false)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (valid-5mc? a)
  (cond
    [(string=? a "A") #true]
    [(string=? a "B") #true]
    [(string=? a "C") #true]
    [(string=? a "D") #true]
    [(string=? a "E") #true]
    [(string=? a "a") #true]
    [(string=? a "b") #true]
    [(string=? a "c") #true]
    [(string=? a "d") #true]
    [(string=? a "e") #true]
    [else false]))
               



















