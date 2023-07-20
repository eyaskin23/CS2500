;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lab6-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the definitions below...

; A Position is a (make-posn Real Real)
; Interpretation: an (x, y) coordinate

; matching-x-position : [List-of Position] Real Position -> Position
; Finds the first position in the list with the given x-coordinate, or
; produces the given position if no such position can be found.

(define LIST-0 '())
(define LIST-1 (list
                (make-posn 1 2)
                (make-posn 3 4)))
(define LIST-2 (list
                (make-posn 1 2)
                (make-posn 3 4)
                (make-posn 5 6)
                (make-posn 7 8)
                (make-posn 3 3)))

(check-expect (matching-x-position LIST-0 4 (make-posn 0 1)) (make-posn 0 1))
(check-expect (matching-x-position LIST-2 5 (make-posn 1 7)) (make-posn 5 6))
(check-expect (matching-x-position LIST-1 3 (make-posn 1 7)) (make-posn 3 4))

(define (matching-x-position lop coord default)
  (cond [(empty? lop) default]
        [(cons? lop)
         (if (= (posn-x (first lop)) coord)
             (first lop)
             (matching-x-position (rest lop) coord default))])) 


; string-with-length : [List-of String] Nat -> String
; Finds the first string in the list with the given length, or produce
; "no such string" if no such String can be found.

(check-expect
 (string-with-length
  (list)
  10)
 "no such string")

(check-expect
 (string-with-length
  (list "hi" "hello" "aloha")
  5)
 "hello")

(define (string-with-length los desired-length)
  (cond [(empty? los) "no such string"]
        [(cons? los)
         (if (= (string-length (first los)) desired-length)
             (first los)
             (string-with-length (rest los) desired-length))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Write an abstract function that performs a mathematical operation on 2 Natural Numbers.

; math-two-nats : [Nat Nat -> Number] Nat Nat

(check-expect (math-two-nats + 4 1) 5)
(check-expect (math-two-nats / 9 6) 1.5)
(check-expect (math-two-nats - 9 6) 3)


(define (math-two-nats op x y)
  (op x y)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TODO 1/3: Design the function find-first-match that abstracts the
;           two functions defined above. Don't forget to provide a
;           signature that is as general as possible, while still
;           not over-promising :)
;
;           Hint: one way to approach this is to think that a
;           function is being applied to every element in the
;           supplied list, which converts it from its original type
;           into a number - now just look for the desired number!


; find-first-match : {X} [List-of X] X Number [X -> Number]
; Takes in a list of X and a number to compare to, reutrns the first value in the list that is
; equal to the number when to-num is applied, otherwise returns default if not match is found.



(check-expect (find-first-match (list (make-posn 1 2) (make-posn 3 4)) (make-posn 5 6) 3 posn-x)
              (make-posn 3 4))

(check-expect (find-first-match (list "hi" "hello" "aloha") "no such string" 5 string-length))

(define (find-first-match lox default desired-num to-num)
  (cond [(empty? lox) default]
        [(cons? lox)
         (if (= (to-num (first lox)) desired-num)
             (first lox)
             (find-first-match (rest lox) default desired-num to-num))]))

; TODO 2/3: Redefine matching-x-position and string-with-length using
;           find-first-match.

; matching-x-position2 : [List-of Position] Real Positive -> Position
; Finds the first posiiton in the list with the given x-coordinate or
; produces the given position if no such position can be found.

(check-expect (matching-x-position2 (list (make-posn 

(define (matching-x-position2 lop desired-x default)
  (find-first-match lop default desired-x (posn-x (first lop))))


; TODO 3/3: Design the function any-true? that returns #true if a
;           list of Boolean data contains at least one #true, otherwise
;           #false. Use find-first-match to do so. You have been
;           supplied some tests for clarity (which you can use in your
;           design, but should supplement). 

#|
(check-expect
 (any-true? (list #f #f #f))
 #false)

(check-expect
 (any-true? (list #f #t #t))
 #true)
|#


