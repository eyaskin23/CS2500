;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |lab 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO 1/1: Design the function string-starts-with?, which takes two
;           Strings and determines if the first begins with the second.
;           This could happen in three situations...
;           - The second string is empty ("")
;           - The strings are actually the same
;           - The first string is longer than the second,
;             and the beginning of the first string is the same as
;             the second

;           Provide a signature, uncomment the supplied tests, and
;           write the code for the function that matches the description.


; string-starts-with? : String String -> Boolean
; Purpose: To state whether the first given string begins with the second given string. 

; The Strings are a part of:
; ""
; the same
; (string 1 > string 2)
; (string1 beginning = string2)
; Interpretation: Does the first string start with the second?


(define STRING-STARTS-WITH-1 "fun")
(define STRING-STARTS-WITH-2 "fundies")


(check-expect (string-starts-with? "fundies" "fun") #true)
(check-expect (string-starts-with? "fun" "fundies") #false)
(check-expect (string-starts-with? "fundies" "fundies") #true)
(check-expect (string-starts-with? "any" "") #true)
(check-expect (string-starts-with? "cat" "dog") #false)

(define (string-starts-with? s1 s2)
  (cond
    [(> (string-length s2)(string-length s1)) #false]
    [else (string=? (substring s1 0 (string-length s2)) s2)]))
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; You are to design a small door-simulator program...
;
; - A door can either be open, closed, or locked. Your program
;   will take in a representation of one of these states as its
;   starting position.
;
; - The user can open a closed door by pressing the "o"
;   key on their keyboard. You cannot open a locked door,
;   and attempting to open an already open door will do nothing.
;
; - The user can close an open door by pressing the "c" key
;   on their keyboard. Attempting to close an already closed
;   (or closed and locked) door will do nothing.
;
; - The user can lock a closed door by pressing the "l" key
;   on their keyboard. Attempting to lock an open door or an
;   already locked door will do nothing.
;
; - The user can unlock a locked door by pressing the "u" key
;   on their keyboard. Attempting to unlock a closed door that
;   is already unlocked, or an open door, will do nothing.

; When finished, you'll uncomment the following code and run
; something like ... (door-simulator "open")


; door-simulator : DoorState -> DoorState
; Simulates a lockable door

(define (door-simulator ds)
  (big-bang ds
    [to-draw draw-door]
    [on-key change-door]))


; TODO 1/3: Finish the Design Recipe for data for DoorState
;           (so provide examples and a template).


; A DoorState is one of:
; - "closed"
; - "locked"
; - "open"
; Interpretation: state of a lockable door

; Examples:
(define DS-CLOSED "closed")
(define DS-OPEN "open")
(define DS-LOCKED "locked")

; (define (door-state d)
;  (cond [(string=? d DOORSTATE-CLOSED) ... ]
;        [(string=? d DOORSTATE-OPEN) ... ]
;        [(string=? d DOORSTATE-LOCKED) ... ]))

  
; TODO 2/3: Design the function draw-door takes a DoorState and
;           produces a corresponding image. To help get you
;           started, you have been provided...
;           - Example constants (DOOR-CLOSED, DOOR-LOCKED, DOOR-OPEN);
;             feel free to be creative if you'd like to make a more
;             interesting door :)
;           - A signature, purpose statement, and tests (commented out)


(define BG (rectangle 400 200 "solid" "blue"))

(define DOOR-W (/ (image-width BG) 5))
(define DOOR-H (- (image-height BG) 40))

(define KNOB-X (* .8 DOOR-W))
(define KNOB-Y (/ DOOR-H 2))

(define DOOR
  (place-image
   (circle (/ DOOR-W 10) "solid" "gray")
   KNOB-X KNOB-Y
   (rectangle DOOR-W DOOR-H "solid" "brown")))

(define DOOR-LOCK
  (place-image
   (text "x" 10 "black")
   KNOB-X KNOB-Y
   DOOR))

(define DOOR-X (* 0.6 (image-width BG)))
(define DOOR-Y (+ (/ DOOR-H 2) (- (image-height BG) DOOR-H)))

(define DOOR-CLOSED
  (place-image
   DOOR
   DOOR-X DOOR-Y
   BG))

(define DOOR-LOCKED
  (place-image
   DOOR-LOCK
   DOOR-X DOOR-Y
   BG))

(define DOOR-OPEN
  (place-image
   (beside (flip-horizontal DOOR)
           (rectangle DOOR-W DOOR-H "solid" "lightblue"))
   (- DOOR-X (/ DOOR-W 2)) DOOR-Y
   BG))


; draw-door : DoorState -> Image
; Draw the current state of the door


(check-expect (draw-door DS-CLOSED) DOOR-CLOSED)
(check-expect (draw-door DS-LOCKED) DOOR-LOCKED)
(check-expect (draw-door DS-OPEN) DOOR-OPEN)


; CODE HERE
(define (draw-door d)
 (cond [(string=? d DS-CLOSED) DOOR-CLOSED]
       [(string=? d DS-LOCKED) DOOR-LOCKED]
       [(string=? d DS-OPEN) DOOR-OPEN]))
         


; TODO 3/3: Uncomment the following function - you are not to change it,
;           but rather design the helper functions it references.
;           The first (change-closed-door) produces a DoorState based upon
;           the key pressed when the door is closed - this has been provided
;           for you. Your job is to implement the remaining two, which
;           determine the next state when the door is locked (change-locked-door)
;           and then open (change-open-door).


; change-door : DoorState KeyEvent -> DoorState
; Open/close/lock/unlock the door as necessary

(check-expect (change-door DS-CLOSED "o") DS-OPEN)
(check-expect (change-door DS-LOCKED "o") DS-LOCKED)
(check-expect (change-door DS-OPEN "o") DS-OPEN)

(check-expect (change-door DS-CLOSED "l") DS-LOCKED)
(check-expect (change-door DS-LOCKED "l") DS-LOCKED)
(check-expect (change-door DS-OPEN "l") DS-OPEN)

(check-expect (change-door DS-CLOSED "c") DS-CLOSED)
(check-expect (change-door DS-LOCKED "c") DS-LOCKED)
(check-expect (change-door DS-OPEN "c") DS-CLOSED)

(check-expect (change-door DS-CLOSED "u") DS-CLOSED)
(check-expect (change-door DS-LOCKED "u") DS-CLOSED)
(check-expect (change-door DS-OPEN "u") DS-OPEN)

(check-expect (change-door DS-CLOSED "a") DS-CLOSED)
(check-expect (change-door DS-LOCKED "a") DS-LOCKED)
(check-expect (change-door DS-OPEN "a") DS-OPEN)

(define (change-door ds ke)
  (cond [(string=? ds DS-CLOSED) (change-closed-door ke)]
        [(string=? ds DS-LOCKED) (change-locked-door ke)]
        [(string=? ds DS-OPEN) (change-open-door ke)]))


; change-closed-door : KeyEvent -> DoorState
; applies a key event to a closed door

(check-expect (change-closed-door "o") DS-OPEN)
(check-expect (change-closed-door "l") DS-LOCKED)
(check-expect (change-closed-door "c") DS-CLOSED)
(check-expect (change-closed-door "u") DS-CLOSED)
(check-expect (change-closed-door "a") DS-CLOSED)

(define (change-closed-door ke)
  (cond
    [(key=? ke "o") DS-OPEN]
    [(key=? ke "l") DS-LOCKED]
    [else DS-CLOSED]))

; change-locked-door : KeyEvent -> DoorState
; applies a key event to a locked door

(check-expect (change-locked-door "o") DS-LOCKED)
(check-expect (change-locked-door "u") DS-CLOSED)
(check-expect (change-locked-door "c") DS-LOCKED)
(check-expect (change-locked-door "a") DS-LOCKED)
(check-expect (change-locked-door "l") DS-LOCKED)

(define (change-locked-door ke)
  (cond
    [(key=? ke "u") DS-CLOSED]
    [else DS-LOCKED]))

; change-open-door : KeyEvent -> DoorState
; applies a key event to an open door

(check-expect (change-open-door "o") DS-OPEN)
(check-expect (change-open-door "u") DS-OPEN)
(check-expect (change-open-door "c") DS-CLOSED)
(check-expect (change-open-door "a") DS-OPEN)
(check-expect (change-open-door "l") DS-OPEN)

(define (change-open-door ke)
  (cond
    [(key=? ke "c") DS-CLOSED]
    [else DS-OPEN]))

