;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sillyposn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Silly1 is one of:
; - Number
; - (make-posn String Image)

(define (silly1-temp s1)
  (...
   (cond
     [(number ? s1) ...]
     [(posn? s1) ...
      (posn-x s1) ...
      (posn-y s1) ...])))

; A SillyPosn is a (make-posn String Image)

(define (sillyposn-temp sp)
  (... (posn-x sp) ...
       (posn-y sp) ...))

; A Silly2 is one of:
; - Number
; - SillyPosn

(define (silly2-temp s2)
  (...
   (cond
     [(number? s2) ... s2 ...]
     [(posn? s2) ... (sillyposn-temp s2) ...])))

; A Silly3 is one of
; - "hello"
; - PosInteger

(define (silly3-temp s3)
  (...
   (cond
     [(string ? s3)...]
     [(number? s3) ... s3 ...])))

(define-struct sillystrucy [ab cd])
; A Silly4 is a (make-sillystruct Number Silly3)

(define (silly4-temp s4)
  (... (sillystruct-ab s4) ...
       (sillystruct-cd s4) ...))
       
       