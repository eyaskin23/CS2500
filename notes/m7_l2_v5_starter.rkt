;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m7_l2_v5_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; (X) Nat [Nat -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
; (build-list n f) == (list (f 0) ... (f (- n 1)))
; (define (build-list n f) ...)

(build-list 5 number->string)

; perfect-squares : Nat -> [List-of Nat]
; produce a list of the first k perfect squares

(check-expect
 (perfect-squares 0)
 '())

(check-expect
 (perfect-squares 1)
 (list 1))

(check-expect
 (perfect-squares 5)
 (list 1 4 9 16 25))

(define (perfect-squares k)
  (build-list k make-perfect-square))

; make-perfect-square : Nat -> Nat
; produces the square of 1 plus the input

(check-expect
 (make-perfect-square 0)
 1)

(check-expect
 (make-perfect-square 1)
 4)

(define (make-perfect-square n)
  (sqr (add1 n)))




