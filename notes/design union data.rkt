;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |design union data|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design data to represent a Northeastern's Student's NUID, while taking
; into account that it might not be known.

; A NUIDorFalse is one of:
; - NaturalNumber (Nat)
; - #false
; Interpretation: a Northeastern's student NUID,
; or #false if the NUID is not known

(define NORF-1 12345)
(define NORF-UNKNOWN #false)

(define (norf-temp norf)
  (...
   (cond
     [(number? norf) ... norf ...]
     [(boolean? norf) ...])))

