;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Evelyn Yaskin- Hw 1 problem 3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Remember back in school when you had to remember various math facts like the
; multiplication table? Well, let's make an animation that will quickly show
; off DrRacket's multiplication skills.

; TODO 1/1: Define a humble-square function that, when called by animate
;
;           (animate humble-square)
;
;           counts up the perfect squares in the following way: the first
;           frame is...
;
;           0 squared is 0
;
;           then...
;
;           1 squared is 1
;
;           then ...
;
;           2 squared is 4
;
;           and so on, for as long as the program runs.
;
;           Hints:
;           - Since animate produces frames 28 times a second, it'll likely
;             go too fast for you to see... hence the humble brag ;)
;           - The size of the animate window will always stay the same, so
;             you should make a background big enough to handle the growing
;             size of numbers/squares.
;           - Don't forget reasonable signature & purpose statements!
;           - As usual, have fun with colors/fonts/background, but make sure
;             the result is useful, readable, and respectful :)


; perfect-squares: Numbers--> Image
; The purpose of this is to take an integer "x" and square it. It then prints the
;phrase "x squared is x*x" in an outside window. 
(define (perfect-squares x)
  (place-image
   (beside (text (number->string x) 20 "black"); defining what "text" is
           (text "squared is" 20 "black")
           (text (number->string (* x x)) 20 "black"))
   150 150
   (empty-scene 300 300)))

