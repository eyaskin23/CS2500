;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EVELYN YASKIN- Homework 1 (problem 2)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; boxed-letter: String and Number --> Image
; Creates a boxed-letter, with given box parameter, and box color.
;Also creates a border around a given letter. 

(define (boxed-letter size letter letter-color box-color border)
  (overlay (text letter 40 letter-color)
           (square 100 "solid" box-color)
           (square 110 "solid" border)))
