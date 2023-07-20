;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw4-problem2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Now let's think about what goes into making a particularly useful app, Weather!
;
; Consider the following data definition:


(define-struct cloudy [morn? eve?])
(define-struct rain [chance])
(define-struct snow [inches])

; A Prediction is one of:
; - "sunny"
; - (make-cloudy Boolean Boolean)
; - (make-rain Nat[1, 100])
; - (make-snow Nat)
; Intepretation: weather prediction, either...
; - Sunny!
; - Cloudy (either in the morning, evening, both, or unsure)
; - Raining (with provided % chance as 1-100)
; - Snow (with provided accumulation)


; TODO 1/2: Complete the data design recipe for Prediction.

(define PREDICTION1 "sunny")
(define PREDICTION2 (make-cloudy #true #false))
(define PREDICTION3 (make-rain 68))
(define PREDICTION4 (make-snow 3))

(define (prediction-temp w)
  (...
   (cond
     [(string? w) ...]
     [(cloudy? w) ...]
     [(rain? w) ...]
     [(snow? w) ...])))


; TODO 2/2: Design the function announcement, which given
;           a prediction (e.g., "sunny"), produces a short
;           text announcement to display (e.g., "It's going
;           to be sunny!").

;           Some other example announcements include:
;           - "It's going to be cloudy in the morning."
;           - "There's a 60% chance of rain."
;           - "It's going to snow, with 2 inches on the ground."

(check-expect (announcement PREDICTION1) "It's going to be sunny!")
(check-expect (announcement PREDICTION2) "It's going to be cloudy in the morning.")
(check-expect (announcement PREDICTION3) "There's a 68% chance of rain.")
(check-expect (announcement PREDICTION4) "It's going to snow, with 3 inches on the ground.")


; Announcement : Prediction -> String
; Purpose: It returns an announcement for the weather.

(define (announcement w)
   (cond
     [(string? w) "It's going to be sunny!"]
     [(cloudy? w) (cond [(and (cloudy-morn? w) (cloudy-eve? w)) "It'll be cloudy all day."]
                        [(cloudy-morn? w) "It's going to be cloudy in the morning."]
                        [(cloudy-eve? w) "It's going to be cloudy in the evening."]
                        [(not (cloudy-morn? w)) "We are unsure if it will be cloudy."])]
     [(rain? w) (string-append "There's a " (number->string (rain-chance w)) "% chance of rain.")]
     [(snow? w) (string-append "It's going to snow, with " (number->string (snow-inches w)) " inches on the ground.")]))








