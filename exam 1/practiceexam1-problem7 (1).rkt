;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |practiceexam1-problem7 (1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 7
;;
;; *This is a programming problem that you should do in DrRacket.*
;;
;; You have been tasked with building a web-based takeout menu for a pizzeria.
;; The pizzeria sells pizzas and soft drinks. Every pizza has a name
;; (e.g., "margherita" or "pepperoni"), and size (small, medium, or large).
;; Soft drinks only have a name (e.g., "Pepsi" or "Harmony Springs Cola").
;;
;; Design a data definition that represents a single menu item for the pizzeria.
;; Ensure you follow the entire data design recipe for all data that you design.

;; [TODO] Data designs

; PSize is one of:
; - "small"
; - "medium"
; - "large"
; Interpretation: The size of a pizza

(define PSIZE-S "small")
(define PSIZE-M "medium")
(define PSIZE-L "large")

(define (size-temp ps)
  (...
   (cond
     [(string=? PSIZE-S ps) ...]
     [(string=? PSIZE-M ps) ...]
     [(string=? PSIZE-L ps) ...])))

(define-struct pizza [name size])
(define-struct soft-drink [name]) 

; A MenuItem is one of:
; - (make-pizza String PSize)
; - (make-soft-drink String)
; Interpretation: An item off this pizzeria's menu.

(define MI-1 (make-pizza "Cheese" PSIZE-S))
(define MI-2 (make-soft-drink "Sprite"))

(define (menu-item temp mi)
  (...
   (cond
     [(pizza? mi) ... (pizza-name mi) ... (size-temp (pizza-size mi))] 
     [(soft-drink? mi) ... (soft-drink-name mi) ...]))) 


























  




  