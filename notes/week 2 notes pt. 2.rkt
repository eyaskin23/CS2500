;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |week 2 notes pt. 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)



(define SKY-WIDTH 300)
(define SKY-HEIGHT 200)

(define RADIUS 25)

(define SUN (circle RADIUS "solid" "yellow"))
(define MOON (circle RADIUS "solid" "gray"))
(define SKY (rectangle SKY-WIDTH SKY-HEIGHT "solid" "light blue"))


; draw-eclipse : Number -> Image
; Draws the moon at the given x-coordinate, on a scene when the sun is in
; the exact middle

(define (draw-eclipse x-moon)
  ; original code for draw
  ; (place-image MOON <x> <y> (place-image SUN 220 y SKY)))


(place-image
 MOON
 x-moon (/ SKY-HEIGHT 2)
 (place-image SUN (/ SKY-WIDTH 2) (/ SKY-HEIGHT 2) SKY)))

;(animate draw-eclipse)

; gonna-get-an-A : Number -> Boolean
; Returns whether or not you're going to get an A, given your grade

(define (gonna-get-an-A? grade)
  (< 90 grade))


(gonna-get-an-A? 10)
(gonna-get-an-A? 89)
(gonna-get-an-A? 95)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; gonna-get-an-A? : Number -> Boolean
; Returns whether or not you're going to get an A, given your grade
; Examples:

; (check-expect (gonna-get-an-A? 10) should be false
; (gonna-get-an-A? 10) should be false
; (gonna-get-an-A? 89) should be false
; (gonna-get-an-A? 95) should be true

#;
(define (gonna-get-an-A? grade)
  (<= 90 grade))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; VOCAB: check-expect 
;; Grammar: (check-expect (add-two 0) 2)
;; Semantics: 

 (check-expect (gonna-get-an-A? 10) #false)
 (check-expect (gonna-get-an-A? 89) #false)
 (check-expect (gonna-get-an-A? 95) #true)
 


