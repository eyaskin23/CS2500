;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |hw6-problem1 (2)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; In this problem you'll practice with lists by designing a function to
; help bookstores!

; Most bookstores sort the books on their shelves by the author’s last
; name. Unfortunately, some bookstore patrons do not preserve this order
; when browsing books, and simply place books back wherever they fit.

; Assume that bookstores keep all authors whose last name starts with the
; same letter on the same shelf, and those shelves are labeled with that
; letter. A record of which authors are on a given shelf would be represented
; using the following data definitions:

(define-struct shelf [letter authors])

; A Shelf is a (make-shelf 1String [List-of String])
; Interpretation: a record of the letter the authors' last name *should* start
; with, and the list of the *actual* last names on the shelf.

(define SHELF-1 (make-shelf "A" (list "Austen" "Hurston" "Angelou" "Butler" "Alvarez")))
(define SHELF-2 (make-shelf "B" (list)))
(define SHELF-3 (make-shelf "C" (list "Carle" "Coates"))) 

(define (shelf-temp s)
  (... (shelf-letter s) ...
       (list-of-string-temp (shelf-authors s)) ...)) 


; TODO 1/1: Design the function fix-shelves that takes a list of Shelf records
;           and produces a list of Shelf records where at least one author does
;           not belong on the Shelf. The output Shelf records should only contain
;           the authors who don't belong on that shelf. Shelf records and the authors
;           within those records should be in the same order in the output as they
;           appear in the input. Do not generate empty Shelf records; this generates
;           needlessly long reports, which annoys the employees. You have been
;           supplied a test for clarity (which you can use in your design, but
;           should supplement). Make sure your solution follows the (list) templates!

; fix-shelves: List-Shelf -> List-Shelf


(define (fix-shelves l)
  (cond [(empty? l) '()]
        [(cons? l)
         (if (empty? (shelf-authors (shelf-helper (first l))))
             (fix-shelves (rest l))
             (cons (first0letter (first l)) (fix-shelves (rest l))))]))
         
        

; returns a list of authors whose last name does not match the given shelf


(check-expect (fix-shelves SHELF-1)
              (list (make-shelf "A" (list "Hurston" "Butler"))))   

(define (fix-shelves s)
  (cond [(empty? s) '()]
        [(cons? s)
         (if (empty? (shelf-authors (shelf-helper (first s))))
             (fix-shelves (rest s))
             (cons (shelf-helper (first s)) (fix-shelves (rest s))))]))

; first-letter: Shelf -> String
; returns a list of the first letter of each authors last name given a shelf

(check-expect (first-letter SHELF-1) (list "A" "H" "A" "B" "A"))

(define (shelf-helper s)
  (make-shelf (shelf-letter s) 
              (first-letter (shelf-letter s) (shelf-authors s))))  

(define (first-letter f)
   (cond [(empty? make-shelf)'()]
        [(cons? make-shelf)
         (if (string=? string
                       (substring
                        (first make-shelf)
                        0 1))
             (first-letter string (rest make-shelf))
             (cons (first make-shelf) (first-letter string (rest make-shelf))))]))    
       

