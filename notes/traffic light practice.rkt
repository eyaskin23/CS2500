;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |traffic light practice|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Design a program loop-light that shows a traffic light,
; and just changed red-> green-> yellow

; A TrafficLight is one of:
; - "red"
; - "yellow"
; - "green"
; Interpretation: colors of a traffic light

(define TL-RED "red")
(define TL-YELLOW "yellow")
(define TL-GREEN "green")


; loop-light : TrafficLight -> TrafficLight
; vizualize a looping traffic light

(define (loop-light initial-tl)
  (big-bang initial-tl
    [to-draw draw-tl]
    [on-tick cycle-tl 1]))

; draw-tl : TrafficLight -> Image
; visualizes a traffic light

(define RADIUS 50)

(check-expect (draw-tl TL-RED)
              (circle RADIUS "solid" "red"))

(check-expect (draw-tl TL-YELLOW)
              (circle RADIUS "solid" "yellow"))

(check-expect (draw-tl TL-GREEN)
              (circle RADIUS "solid" "green"))

(define (draw-tl tl)
   (cond
     [(string=? tl TL-RED) (circle RADIUS "solid" "red")]
     [(string=? tl TL-YELLOW) (circle RADIUS "solid" "yellow")]
     [(string=? tl TL-GREEN) (circle RADIUS "solid" "green")]))

; cycle-tl: TrafficLight -> TrafficLight
; changes the color of the light

(check-expect (cycle-tl TL-RED) TL-GREEN)
(check-expect (cycle-tl TL-GREEN) TL-YELLOW)
(check-expect (cycle-tl TL-YELLOW) TL-RED)

(define (cycle-tl tl)
   (cond
     [(string=? tl TL-RED) TL-GREEN]
     [(string=? tl TL-YELLOW) TL-RED]
     [(string=? tl TL-GREEN) TL-YELLOW]))




