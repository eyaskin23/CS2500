;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m6_l2_v1_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; A [List-of Number] is one of
; - '()
; - (cons Number [List-of Number])
; Interpretation: a list of numbers
 
(define LON-0 '())
(define LON-1 (cons 9 LON-0))
(define LON-2 (cons 4 LON-1))
 
(define (lon-temp lon)
  (...
   (cond
     [(empty? lon) ...]
     [(cons? lon) ...
      (first lon) ...
      (lon-temp (rest lon)) ...])))

; a) Design sqrt-of-all, which takes a list
;    of numbers and produces a list that results
;    from taking the square root of all the numbers

; sqrt-of-all : ??? -> ???
; takes the square root of all input numbers

(check-expect
 (sqrt-of-all LON-0)
 ???)

(check-expect
 (sqrt-of-all LON-2)
 ???)

; b) Design sqr-of-all, which takes a list
;    of numbers and produces a list that results
;    from squaring all the numbers

; sqr-of-all : ??? -> ???
; squares all input numbers

(check-expect
 (sqr-of-all LON-0)
 ???)

(check-expect
 (sqr-of-all LON-2)
 ???)

; c) Using the new abstraction, design visualize-all,
;    that takes a list of strings and produces a list
;    that results from converting all of them to
;    images of that text

(define FONT 18)
