;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname P1-structs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Recall our silly-eclipse from last class, where we used make-posn
; as the basis for a data design for MoonPosition.
; Suppose we wanted to make the sun move as well, independent of the moon.
; How could we upgrade the world-state to support that?
;<BRAINSTORM>


(define (random-seq r)
  (gen-sequence (random r)))


; gen-sequence : Integer (make-posn Integer (make-posn Integer Integer))
; given a number, returns that plus the two integers


(define (gen-sequence n)
  (make-posn n (make-posn (+ 1 n) (+ 2 n))))


; A SunMoonPosition is a (make-posn (make-posn Number Number) (make-posn Number Number))
; Interpretation: The location of the moon and the sun on the x-axis and y-axis



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; One idea might be a nested structure like...

; A SunMoonPosition is a (make-posn (make-posn Number Number) (make-posn Number Number))
; Interpretation:  The location of the moon and the sun on the x- and y-axis
 
(define SMP-1 (make-posn (make-posn 3 4) (make-posn 5 5)))
 
(define (sunmoonposition-temp smp)
  (... (posn-x (posn-x smp)) ... (posn-y (posn-x smp)) ...
       (posn-x (posn-y smp)) ... (posn-x (posn-y smp)) ...))

; What is wrong with this?

; Let's look at a better solution

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CUSTOM STRUCTURES
; We could technically handle almost an situation with one or more make-posn's.
; Why shouldn't we do so? It's unnecessarily convoluted. Also, we might want different names.
; Solution:
;
; Vocabulary	define-struct
; Grammar	(define-struct name [x y z ...]) where name is the name of the structure
;		and x, y, ... are the names of the fields.
; Semantics	It creates a new type of data. It also creates a bunch of functions for you
;		to use to manipulate that data.
;
; Basically, it creates the following functions for you. Assume you ran...

;(define-struct foo [x y z])

; This would make available to you:
; make-foo ; Constructor; SIG: Any Any Any -> make-foo
; foo? ; Predicate        SIG: foo? : Any -> Boolean
; foo-x ; Selector        SIG: (make-foo ...) -> Any
; foo-y ; Selector       
; foo-z ; Selector

; What would the signatures of these functions be?
;<DO NOW>








; make-foo : Any Any Any -> (make-foo Any Any Any)
; foo? : Any -> Boolean
; foo-x, foo-y, foo-z : (make-foo Any Any Any) -> Any

; N.B.: make-foo is a value, not a data definition!
; To use it in our design, we need more:


(define-struct foo [x y z])
 
; A Foo is a (make-foo Number String MoonPosition)
; Interpretation: store a planetary body size, name, and current position 
;  - x is the thing's size in km
;  - y is the astronomical name
;  - z is where it is right now 
 
(define FOO-1 (make-foo 1 "hi" (make-posn 5 10)))
 
(define (foo-temp f)
  (... (foo-x f) ...
       (foo-y f) ...
       (moonposition-temp (foo-z f)) ...))

; Notice: if a field's type is itself a data definition - call it's template (more next week)!

; With the creation of the definition, we can be more precise with our implied
; signatures:

; make-foo : Number String MoonPosition -> Foo
; foo? : Any -> Boolean
; foo-x : Foo -> Number
; foo-y : Foo -> String
; foo-z : Foo -> MoonPosition

; (You don't actually have to declare these explicitly anywhere)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Design the data to represent a Northeastern student, covering their first name,
; last name, and NUID, using a structure. For practice, let's list all of the functions
; that become available, and what their signatures are in the context of our program.

(define-struct student [firstname lastname nuid])

; A Student is a (make-student String String Number)
; Interpretation: A student at Northeastern
;  - firstname is their first name
;  - lastname is their last name
;  - nuid is their NUID
     
; The following list of automatically created functions is not a necessary part of
; the data design recipe for structures--we are just doing it the first few times
; to get familiar with what is provided by BSL:
; make-student : String String Number -> Student
;   student? : Any -> Boolean
;   student-firstname : Student -> String
;   student-lastname : Student -> String
;   student-nuid : Student -> Number
     
(define STUDENT-1 (make-student "Alice" "Doe" 1234))
     
(define (student-temp s)
  (... (student-firstname s) ...
       (student-lastname s) ...
       (student-nuid s) ...))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Now, implement a function letter-header that accepts a Student and produces the opening
; line of a letter ("Dear Alice Doe,").

; letter-header : Student -> String
; Produces the opening line of a letter to that student
     
(check-expect (letter-header STUDENT-1) "Dear Alice Doe,")

(define (letter-header STUDENT-1)
  (string-append "Dear " (student-firstname STUDENT-1) " " (student-lastname STUDENT-1) ","))
