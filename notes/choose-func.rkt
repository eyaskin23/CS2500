;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname choose-func) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Try cutting-and-pasting following into new window
;
;; Try 1:

;(check-expect (choose-func #true) +)  
;(check-expect (choose-func #false) -) 
;
;; Try 2: 
;(check-expect ((choose-func #true) 1 1) 2)
;(check-expect ((choose-func #false) 1 1) 0) 

;; Try 3:

(define (choose-func x)
  (if x + -))

(define F-TRUE (choose-func #true))
(define F-FALSE (choose-func #false))
(check-expect (F-TRUE 1 1) 2)
(check-expect (F-FALSE 1 1) 0) 

 
;; Why the error even on Try 3?
;
;; Unfortunately, this also implies the check-expects have to come
;; *after* the code for the function.
;; (Why now, but not before? <EXPLAIN>)
;
;; This will have to do... for now.  


