;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |move moon practice|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Design a program big-bang-moon that moves a moon across the sky

; big-bang-moon : RealNumber -> RealNumber
; moves the moon across the sky

(define (big-bang-moon initial-x)
  (big-bang initial-x
    [to-draw draw-moon]
    [on-tick move-moon]
    [on-key restart-moon]
    [stop-when stop-moon]))

; draw-moon : RealNumber -> Image
; draws the moon on the sky at the supplied x-position

(define SKY-WIDTH 300)
(define SKY-HEIGHT 200)
(define RADIUS 25)

(define MOON (circle RADIUS "solid" "gray"))
(define SKY (rectangle SKY-WIDTH SKY-HEIGHT "solid" "light blue"))

(check-expect
 (draw-moon 10)
 (place-image
  MOON
  10 (/ SKY-HEIGHT 2)
  SKY))

(define (draw-moon x)
  (place-image
   MOON
   x (/ SKY-HEIGHT 2)
   SKY))

; move-moon : RealNumber -> RealNumber
; moves the moon in the sky

(check-expect (move-moon 10) 12)

(define (move-moon x)
  ( + x 2))

; restart-moon : RealNumber KeyEvent -> RealNumber

(check-expect (restart-moon 10 "t") (- RADIUS))

(define (restart-moon x ke)
  (- RADIUS))

; stop-moon : RealNumber -> Boolean
; determines if the moon is off the screen

(check-expect (stop-moon 10) #false)
(check-expect (stop-moon 1000) #true)


(define (stop-moon x)
  (> x (+ SKY-WIDTH RADIUS)))



              
              


