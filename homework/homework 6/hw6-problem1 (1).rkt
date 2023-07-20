;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |hw6-problem1 (1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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

; fix-shelves: List-of Shelf -> List-of Shelf
; returns only the misplaced books on each shelf in the LoS


(check-expect (fix-shelves (list SHELF-1 SHELF-2 SHELF-3))
              (list (make-shelf "A" (list "Hurston" "Butler"))))

(check-expect (fix-shelves (list SHELF-3))
              '())

(check-expect (fix-shelves (list SHELF-1 SHELF-3))
              (list (make-shelf "A" (list "Hurston" "Butler"))))

(define (fix-shelves los)
  (cond [(empty? los) '()]
        [(cons? los) (remove-if-empty
                      (cons (remove-shelf (first los)) 
                            (fix-shelves (rest los))) shelf-empty?)])) 

; remove-if-empty: List-of Shelf [Shelf-> Boolean] -> List-of Shelf
; removes the empty shelves from the los
(check-expect (remove-if-empty (list SHELF-1) shelf-empty?)
              (list (make-shelf "A"
                                (list "Austen" "Hurston" "Angelou" "Butler" "Alvarez"))))

(check-expect (remove-if-empty (list SHELF-2) shelf-empty?) '())

(check-expect (remove-if-empty (list SHELF-3) shelf-empty?)
              (list (make-shelf "C"
                                (list "Carle" "Coates"))))
(define (remove-if-empty los s->b?)
  (cond [(empty? los) los]
        [(cons? los)
         (if (s->b? (first los))
             (remove-if-empty (rest los) s->b?)
             (cons (first los)
                   (remove-if-empty (rest los) s->b?)))]))
             
                   
; shelf-empty?: Shelf -> Boolean
; is the given shelf empty?
(check-expect (shelf-empty? SHELF-1) #f)
(check-expect (shelf-empty? SHELF-2) #t)
(check-expect (shelf-empty? SHELF-3) #f)

(define (shelf-empty? s)
  (empty? (shelf-authors s)))


; remove-shelf: Shelf -> Shelf
; removes the books that belong on the given shelf 

(check-expect (remove-shelf SHELF-1) (make-shelf "A" (list "Hurston" "Butler")))
(check-expect (remove-shelf SHELF-2) (make-shelf "B" '()))
(check-expect (remove-shelf SHELF-3) (make-shelf "C" '()))

(define (remove-shelf s)
  (make-shelf (shelf-letter s)
              (shelf-and-author (shelf-letter s) (shelf-authors s))))


; shelf-and-author : 1String List-of String -> List-of String
; removes authors from the LoS that start with the given letter

(check-expect (shelf-and-author
               "A" (list "Austen" "Hurston" "Angelou" "Butler" "Alvarez"))
              (list "Hurston" "Butler")) 
(check-expect (shelf-and-author "B" '()) '())
(check-expect (shelf-and-author "C" (list "Carle" "Coates")) '())

(define (shelf-and-author str los)
  (cond [(empty? los) '()]
        [(cons? los)
         (if (string=? str (substring (first los) 0 1))
             (shelf-and-author str (rest los))
             (cons (first los) (shelf-and-author str (rest los))))]))
