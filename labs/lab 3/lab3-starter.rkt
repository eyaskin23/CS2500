;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab3-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the following data definitions & interpretations...


(define-struct address [num st city us-state zip])

; TODO 1/3: complete the data design recipe for Address and NUStudent

; An Address is a (make-address Nat String String String Nat)
; - num is the number of the building on the street
; - st is the name of the street
; - city is the city the building is in
; - us-state is the state the city is in
; - zip is the zipcode of the building
; Interpretation: a US address

(define ADDRESS-0 (make-address 15 "plateau drive" "los angeles" "MA" 94024))
(define ADDRESS-1 (make-address 16 "lovely lane" "mountain view" "CA" 94024))

#; (define (address ad)
     (... (address-num ad) ...
          (address-st ad)
          (address-city ad)
          (address-us-state ad)
          (address-zip ad) ...))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define-struct NUstudent [first last nuid local perm])

; An NUStudent is a (make-student String String PositiveNumber Address Address)
; - first is the student's first name
; - last is the student's last name
; - nuid is the student's NUID
; - local is the student's local address
; - perm is the student's permanent address
; Interpretation: a Northeastern student

(define NUStudent-0 (make-NUstudent "Evelyn" "Yaskin" 12345 ADDRESS-0 ADDRESS-1))
(define NUStudent-1 (make-NUstudent "Inna" "Yaskin" 123456 ADDRESS-0 ADDRESS-1))

;(define (student-temp ad)
;  (...
 ;  (student-first ad) ...
  ; (student-last ad)
  ; (student-nuid ad)
  ; (address-temp (student-local ad))...)
  ; (address-temp (student-perm ad))...)





; TODO 2/3: Design the function student-email which takes an NUStudent and
;           produces a string representing that student’s email address.
;           For simplicity we will say that a student’s email address is always
;           their last name (all lowercase),  followed by a period, followed
;           by the first initial of their first name (also lowercase; you can
;           assume this exists), and finished with "@northeastern.edu".


; Student-email : NUStudent -> String
; Creates a student email given the student's information as defined above.


(check-expect (student-email NUStudent-0) "yaskin.e@northeastern.edu")
(check-expect (student-email NUStudent-1) "yaskin.i@northeastern.edu")

(define (student-email se)
  (string-append (string-downcase(NUstudent-last se)) "." (string-downcase(substring (NUstudent-first se) 0 1)) "@northeastern.edu"))



; TODO 3/3: Design the function update-perm-zipcode which takes an NUStudent
;           and a natural number, representing the new zip code of the person,
;           and updates their permanent address to have that zip code.
;
;           Be sure to follow the template!


; Update-perm-zipcode : NUStudent & Natural Number -> String
; Updates the NUStudent's adress with a new permanent zip code.

(check-expect (update-dperm-zipcode NUstudent-0) "Evelyn Yaskin 12345 15 plateau drive los angeles MA 94026")
(check-expect (updated-perm-zipcode NUstudent-1) "Evelyn Yaskin 12345 16 lovely lane mountain view CA 94028")

(define (updated-perm-zipcode NUStudent nu)
  (make-NUstudent (NUstudent-first NUstudent)
                  (NUstudent-last NUstudent)
                  (NUstudent-nuid NUstudent)
                  (NUstudent-local NUstudent)
                  (updated-address (NUstudent-address NUStudent) nu)))
                  
(define (updated-address ad zip)
  (make-address (address-num ad) 
                (address-st ad)
                (address-city ad)
                (address-us-state ad)
                (zip)))

                
                

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
  (if (mouse=? me "button-up") text-mover tm
      (else
       0 0)))

;    - Hint #2: make sure to follow your templates, which may involve breaking 
;               the handlers into helper functions.


; TODO 1/1: Design the text-mover World program!

(define-struct tm [str pos col])

(define (text-mover-temp tm)
  (...
   (tm-str tm)...
   (position-temp (tm-pos tm))...
   (rbp-temp (tm-col tm)...)))  
  
; A Position is a (make-posn Real Real)
; Interpretation: a 2D location


; A RedBlackPurple (RBP) is one of:
; - "red"
; - "black"
; - "purple"
; Interpretation: available font colors


(define RBP-RED "red")
(define RBP-Black "black")
(define RBP-PURPLE "purple")


(define (red-black-purple-temp rbp)
  (...
   (cond
     [(string=? RBP-RED rbp)...]
     [(string=? RBP-BLACK rbp)...]
     [(string=? RBP-PURPLE rbp)...])))
     
     

(define-struct text-mover [str pos col])


; A TextMover (TM) is a (make-tm String Position RBP)
; - str is the text to be displayed
; - pos is the location of the text
; - col is the color of the text
; Interpretation: all the information needed for the text-mover program.

; Examples: 

(define text-mover-0 (make-tm "fundies" (make-posn 2 2) "red"))
(define text-mover-1 (make-tm "fundies" (make-posn 2 2) "purple"))

(define (text-mover (make-text-mover ("evelyn" pos1 RBP-RED))))
(define (text-mover (make-text-mover ("maya" pos2 RBP-BLACK))))
(define (text-mover (make-text-mover ("simone" pos3 RBP-PURPLE))))

(define (text-mover-run initial-tm)
  (big-bang initial-tm
    [to-draw draw-mp] ; TM -> Image
    [on-tick move-mp] ; TM -> TM
    [on-key start-mp])) ; TM KeyEvent -> TM
 



