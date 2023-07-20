;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m7_l2_v2_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; (X Y) [X -> Y] [List-of X] -> [List-of Y]
; constructs a list by applying f to each item on lx
; (map f (list x1 ... xn)) == (list (f x1) ... (f xn))
; (define (map f lx) ...)


; increment-all : [List-of Number] -> [List-of Number]
; adds 1 to every number in the list


(check-expect
 (increment-all '())
 '())

(check-expect
 (increment-all (list 1 2 3))
 (list 2 3 4)) 

(define (increment-all lon)
  (map add1 lon))


; smiley-all : [List-of String] -> [List-of String]
; add " :)" to the end of every string in the list


(check-expect
 (smiley-all '())
 '())

(check-expect
 (smiley-all
  (list "hi" "programming is fun"))
 (list "hi :)"
       "programming is fun :)"))

(define (smiley-all los)
  (map add-smiley los)) 

; add-smiley : String -> String
; adds ":)" to a given string

(check-expect
 (add-smiley "hi")
 "hi :)")

(define (add-smiley s)
  (string-append s " :)")) 



; picture-nums: [List-of Number] -> [List-of Image]
; returns the image representation of every number in the list

(define FONT 20)

(check-expect
 (picture-nums '())
 '())

(check-expect
 (picture-nums (list 3 1 4))
 (list (text "3" FONT "black")
       (text "1" FONT "black")
       (text "4" FONT "black")))

(define (picture-nums lon)
  (map num->image lon))

; num->image : Number -> Image
; converts the number to an image

(check-expect
 (num->image 3)
 (text "3" FONT "black"))

(define (num->image n)
  (text (number->string n) FONT "black"))
  

   