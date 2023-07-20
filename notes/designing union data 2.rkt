;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |designing union data 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design data to represent a Lyft you ordered,
; which can be either its (x,y) location or
; a status (such as "arrived")

; A PosnOrString (PorS) is one of:
; - (make-posn Real Real)
; - String
; Interpretation: location of the car,
; or its status

(define PORS-1 (make-posn 5 10))
(define PORS-1 "arrived")

(define (pors-temp pors)
  (...
   (cond
     [(posn? pors) ...
     (posn-x pors) ...
     (posn-y pors) ...]
     [(string? pors) ... pors ...])))


     