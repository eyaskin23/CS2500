;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab3-main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; <file "lab3-starter.rkt">
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the following data definitions & interpretations...


(define-struct address [num st city us-state zip])

; An Address is a (make-address Nat String String String Nat)
; - num is the number of the building on the street
; - st is the name of the street
; - city is the city the building is in
; - us-state is the state the city is in
; - zip is the zipcode of the building
; Interpretation: a US address


(define-struct student [first last nuid local perm])

; An NUStudent is a (make-student String String PositiveNumber Address Address)
; - first is the student's first name
; - last is the student's last name
; - nuid is the student's NUID
; - local is the student's local address
; - perm is the student's permanent address
; Interpretation: a Northeastern student


; TODO 1/3: complete the data design recipe for Address and NUStudent


; <solution>

(define ADDRESS-NYSE
  (make-address 11 "Wall Street"
                "New York" "NY" 10005))

(define ADDRESS-HOLLYWOOD
  (make-address 4059 "Mt Lee Drive"
                "Hollywood" "CA" 90068))

(define (address-temp a)
  (... (address-num a) ...
       (address-st a) ...
       (address-city a) ...
       (address-us-state a) ...
       (address-zip a) ...))

(define STUDENT-1
  (make-student "Hermione" "Granger"
                975 ADDRESS-NYSE ADDRESS-HOLLYWOOD))

(define (student-temp st)
  (... (student-first st) ...
       (student-last st) ...
       (student-nuid st) ...
       (address-temp (student-local st)) ...
       (address-temp (student-perm st)) ...))

; </solution>


; TODO 2/3: Design the function student-email which takes an NUStudent and
;           produces a string representing that student’s email address.
;           For simplicity we will say that a student’s email address is always
;           their last name (all lowercase),  followed by a period, followed
;           by the first initial of their first name (also lowercase; you can
;           assume this exists), and finished with "@northeastern.edu".


; <solution>

; student-email : NUStudent -> String
; produces the default e-mail for a student

(check-expect (student-email STUDENT-1) "granger.h@northeastern.edu")

(define (student-email st)
  (string-append
   (string-downcase (student-last st))
   "."
   (string-downcase (substring (student-first st) 0 1))
   "@northeastern.edu"))

; </solution>


; TODO 3/3: Design the function update-perm-zipcode which takes an NUStudent
;           and a natural number, representing the new zip code of the person,
;           and updates their permanent address to have that zip code.
;
;           Be sure to follow the template!


; <solution>

; update-perm-zipcode : NUStudent Nat -> NUStudent
; updates the student's permanent address to have
; the new supplied zip code

(check-expect
 (update-perm-zipcode STUDENT-1 02115)
 (make-student "Hermione" "Granger"
               975 ADDRESS-NYSE
               (make-address 4059 "Mt Lee Drive"
                             "Hollywood" "CA" 02115)))
 
(define (update-perm-zipcode st new-zip)
  (make-student
   (student-first st)
   (student-last st)
   (student-nuid st)
   (student-local st)
   (update-zipcode (student-perm st) new-zip)))


; update-zipcode : Address Nat -> Address
; produces an address with the supplied zip code

(check-expect
 (update-zipcode ADDRESS-HOLLYWOOD 02115)
 (make-address 4059 "Mt Lee Drive"
               "Hollywood" "CA" 02115))

(define (update-zipcode a new-zip)
  (make-address (address-num a)
                (address-st a)
                (address-city a)
                (address-us-state a)
                new-zip))

; </solution>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Note: to receive full credit, submit as much as you complete - you do NOT
;       have to finish all parts in lab.


; You are to design a program text-mover to display and manipulate text on a
; background. Your program should accept some phrase to show, as well as initial
; location and color (we only support three: red, black, or purple) - you should
; then display the phrase on the screen as described.

; When the user presses a mouse button, the program should move the text to the
; location that they clicked. When the user presses any key on the keyboard, the
; program should rotate colors.

; Here is our suggested plan for this program...

; 1. Design the text-mover function - think through the arguments to the
;    function, how you will represent the world state, and what handlers
;    you need to support.
;
;    - Hint A: since your state has multiple parts that change, you'll need a
;              structure to hold them, but the parts themselves might also be new.
;    - Hint B: you've been provided some data definitions below that will be quite
;              useful.

; 2. Finish designing the data from #1; think ahead to make examples that are
;    useful for testing such operations as changing location and color.

; 3. Design your to-draw handler, making use of the template(s) you 
;    designed in #2.

; 4. Design your remaining handler(s), again following the appropriate template(s).
;
;    - Hint #1: for the mouse, you'll want to respond only to the "button-up"
;               event, which you can check using the mouse=? function. Here's code
;               to get you started...

(define (mouse-handler state x y me)
  (if (mouse=? me "button-up")
      ...
      ...))

;    - Hint #2: make sure to follow your templates, which may involve breaking 
;               the handlers into helper functions.


; TODO 1/1: Design the text-mover World program!


; A Position is a (make-posn Real Real)
; Interpretation: a 2D location

; <solution>

(define POSN-1 (make-posn 50 50))
(define POSN-2 (make-posn 100 50))

(define (posn-temp posn)
  (... (posn-x posn) ...
       (posn-y posn) ...))

; </solution>


; A RedBlackPurple (RBP) is one of:
; - "red"
; - "black"
; - "purple"
; Interpretation: available font colors

; <solution>

(define RBP-RED "red")
(define RBP-BLACK "black")
(define RBP-PURPLE "purple")

(define (rbp-temp rbp)
  (...
   (cond
     [(string=? rbp RBP-RED) ...]
     [(string=? rbp RBP-BLACK) ...]
     [(string=? rbp RBP-PURPLE) ...])))

; </solution>


(define-struct tm [str pos col])

; A TextMover (TM) is a (make-tm String Position RBP)
; - str is the text to be displayed
; - pos is the location of the text
; - col is the color of the text
; Interpretation: all the information needed for the text-mover program.


; <solution>

(define TEXT "Howdy!")

(define TM-1
  (make-tm TEXT POSN-1 RBP-RED))

(define TM-2
  (make-tm TEXT POSN-2 RBP-RED))

(define TM-3
  (make-tm TEXT POSN-1 RBP-BLACK))

(define (tm-temp tm)
  (... (tm-str tm) ...
       (posn-temp (tm-pos tm)) ...
       (rbp-temp (tm-col tm)) ...))


; text-mover : String Real Real RBP -> TM
; displays and manipulates text on the screen

(define (text-mover phrase x y rbp)
  (big-bang (make-tm phrase (make-posn x y) rbp)
    [to-draw draw-tm]
    [on-mouse mouse-tm]
    [on-key key-tm]))
    

; draw-tm : TM -> Image
; visualizes a text-mover

(define BG (square 500 "solid" "white"))
(define FONT 20)

(check-expect
 (draw-tm TM-1)
 (place-image
  (text TEXT FONT "red")
  50 50
  BG))

(define (draw-tm tm)
  (place-image
   (text (tm-str tm) FONT (tm-col tm))
   (posn-x (tm-pos tm))
   (posn-y (tm-pos tm))
   BG))


; mouse-tm : TM Int Int MouseEvent -> TM
; moves the tm when the user's button is up

(check-expect
 (mouse-tm TM-1 100 50 "button-up") TM-2)

(define (mouse-tm tm x y me)
  (if (mouse=? me "button-up")
      (move-tm tm x y)
      tm))


; move-tm : TM Int Int -> TM
; moves the tm to the supplied location

(check-expect
 (move-tm TM-1 100 50) TM-2)

(define (move-tm tm x y)
  (make-tm (tm-str tm)
           (make-posn x y)
           (tm-col tm)))


; key-tm : TM KeyEvent -> TM
; cycles the colors of the TM

(check-expect
 (key-tm TM-1 "a") TM-3)

(define (key-tm tm ke)
  (make-tm
   (tm-str tm)
   (tm-pos tm)
   (cycle-color (tm-col tm))))


; cycle-color : RBP -> RBP
; cycles the supported colors

(check-expect (cycle-color RBP-RED) RBP-BLACK)
(check-expect (cycle-color RBP-BLACK) RBP-PURPLE)
(check-expect (cycle-color RBP-PURPLE) RBP-RED)

(define (cycle-color rbp)
  (cond
    [(string=? rbp RBP-RED) RBP-BLACK]
    [(string=? rbp RBP-BLACK) RBP-PURPLE]
    [(string=? rbp RBP-PURPLE) RBP-RED]))


; (text-mover TEXT 50 50 RBP-PURPLE)

; </solution>
