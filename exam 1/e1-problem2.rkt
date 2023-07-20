;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname e1-problem2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the following data definition...


(define-struct puppy [name loud? rest])

; A DoggieParade is one of:
; - ":("
; - (make-puppy String Boolean DoggieParade)
; Interpretation: a sequence of doggies that is either empty (":(") or
; a puppy (with its name, whether it's loud, and the rest of the parade
; that follows.


; TODO 1/2: When you live in an apartment, you really can't have a loud
;           doggie parade. Now consider a function, apartment-friendly?,
;           that determines if the supplied parade of doggies lacks even
;           a single loud puppy. Your task: write a sufficient set of tests
;           for this function.
;
;           Notes:
;           - You do NOT actually have to design the function, but you can
;             if you wish (we'll ignore it).
;           - Assuming you do not write the function, we recommend that you
;             comment the check-expect statements for this problem, so that
;             they don't prevent you from running code in the next part of
;             this problem.




; TODO 2/2: Design the function parade-names, which produces a textual
;           representation of the names of the puppies in the supplied
;           parade of doggies, with sadness at the end. For example,
;           an empty doggie parade would just be sad (":("), whereas
;           one that started with Bailey, followed by Spot, would be
;           "Bailey -> Spot -> :(".


