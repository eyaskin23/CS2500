;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exam notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Transport is one of:
; - "plane"
; - "train"
; - "automobile"
; Interpretation: a mode of transportation

(define-struct trip [mode destination cost])

; A trip is a (make-trip Transport String PosInt)
; Interpretation: a journey to a location using
; a mode of transportation with a cost (in whole $'s)

; A Vacation is one of:
; - "stay home"
; - Trip
; Interpretation: a vacation that is either staying home or
; an associated trip.

(define-struct vacation [trip days next])

; An Itinerary is a (make-vacation Trip PosInt Intinerary)
; Interpretation: a sequence of trip segments 
; - trip is the destination and means of transport
; - days is how long this part of the itinerary will take
; - next is the next part of the itinerary

; pros-cons : Vacation -> String
; Produces a description of a vacation

(define (pros-cons v)
  (cond
    [(string? v) "Nothing spend, nothing gained"]
    [(trip? v)
     (string-append
      "Spent $"
      (number->string (trip-cost v))
      " on "
      (cond
        [(string=? (trip-mode v) "plane") "flying"]
        [(string=? (trip-mode v) "train") "riding"]
        [(string=? (trip-mode v) "automobile") "driving"]) 
        " to "
        (trip-destination v)
        ", but gained a lifetime of memories :)")])) 


(check-expect (pros-cons "stay home")
              "Nothing spend, nothing gained")
(check-expect (pros-cons (make-trip "plane" "London" 800))
              "Spent $800 on flying to London, but gained a lifetime of memories :)") 