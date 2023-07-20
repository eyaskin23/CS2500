;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |designing a world program notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A position is a (make-posn Real Real)
; Interpretation: a 2-dimensional point

(define POSN-0 (make-posn 0 0))
(define POSN-1 (make-posn 1 2))
(define POSN-0 (make-posn 10 -3.5))

(define (posn-temp p)
  (... (posn-x p) ...
       (posn-y p) ...))

