;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |hw5-problem1_1 (1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; You are going to make yourself a useful interactive app: flash cards
; (https://en.wikipedia.org/wiki/Flashcard).

; To begin, consider the following data definition...

(define-struct flashcard [front back])

; A FlashCard is a (make-flashcard String String)
; Interpretation: the front and back of a card

(define CARD-1 (make-flashcard "hello" "world"))
(define CARD-2 (make-flashcard "1+1" "2")) 

(define (flashcard-temp f)
  (... (flashcard-front f) ...
       (flashcard-back f) ...)) 
         

; TODO 1/4: Complete the design recipe for FlashCard.

; Now a single flash card wouldn't be super useful, and so...

; TODO 2/4: Design ListOfFlashCard (LoFC) to support an arbitrarily sized
;           sequence of flash cards. Importantly...
;           - These should be proper lists (i.e., using cons and '()).
;           - Make sure to give yourself a few example lists, of different sizes;
;             hopefully they are useful in your classes!
;           - Remember that your LoFC template should reflect that your list
;             elements are themselves designed types (FlashCard).

; A ListOfFlashCard is one of:
; '()
; - (cons Flashcard LoFC)
; Interpretation: Creates a list of flashcards.

(define LOFC-0 '())
(define LOFC-1 (cons CARD-1 LOFC-0))
(define LOFC-2 (cons CARD-2 LOFC-1))

(define (lofc-temp lofc)
  (...
   (cond
     [(empty? lofc) ...]
     [(cons? lofc) ...
      (flashcard-temp (first lofc)) ...
      (lofc-temp (rest lofc)) ...])))

; Now, for practice...

; TODO 3/4: Design the function has-text?, which determines if a list of flash
;           cards contains any card that contains a supplied text.
;
;           Hint: the string-contains? function is very useful for determining
;           if one string contains another :)


; has-text? : ListOfFlashCards String -> Boolean
; Returns True or False if a list of flash
; cards contains any card that contains a supplied text.

(check-expect (has-text? LOFC-1 "world") #true)
(check-expect (has-text? LOFC-2 "back") #false) 
(check-expect (has-text? LOFC-2 "1+1") #true)
(check-expect (has-text? LOFC-2 "world") #true)
(check-expect (has-text? LOFC-1 "hello") #true)


(define (has-text? lofc s)
  (cond
    [(empty? lofc) #false]
    [(cons? lofc)
     (if (card-contains? (first lofc) s) #true
         (has-text? (rest lofc) s))]))


; card-contains? : FlashCard String -> Boolean
; Determines if the FlashCard contains the given text.

(check-expect (card-contains? CARD-1 "world") #true)
(check-expect (card-contains? CARD-1 "back") #false)
(check-expect (card-contains? CARD-2 "1+1") #true)

(define (card-contains? fc s) 
  (or (string-contains? (flashcard-front fc) s)
      (string-contains? (flashcard-back fc) s))) 
  

; Finally, let's put this list to use :)

; TODO 4/4: Design the program go-cards, which helps you study with a supplied list
;           of cards. It starts on the first card and then flips it when a key is
;           pressed, and then goes to the front of the next card when another key is
;           pressed. The program should end when the last card has been flipped, and
;           the go-cards function should return how many cards were in the original
;           list. Some hints...
;           - To get you started, you have been supplied the data definition of a
;             way to represent the state of the program (don't forget to uncomment
;             the structure definition and finish the design recipe for data!).
;           - The return value of this function is a bit challenging, since the list
;             you get at the end is empty! So uncomment the code we've given you below,
;             but to understand: you can *add* the length of the originally supplied
;             list to that of the (empty) final list and still get the right answer :)
;           - Be sure to follow the templates for all your data, which will typically
;             entail helpers for the FS, the LoFC, and the FC.
;           - As long as the program operates as described, you are welcome to make it
;             look as simple or as creative as you would like - we hope it helps you
;             in your classes!! :)


(define-struct fs [cards front?])

; A FlashState (FS) is a (make-fs LoFC Boolean)
; Interpretation: a list of cards, and whether
; the front is face up

(define FLASHSTATE-0 (make-fs LOFC-0 #true))
(define FLASHSTATE-1 (make-fs LOFC-1 #true)) 
(define FLASHSTATE-2 (make-fs LOFC-1 #false))
(define FLASHSTATE-3 (make-fs LOFC-2 #false))

(define (flashstate-temp fs)
  (... (lofc-temp (fs-cards)) ...
       (fs-front?) ... ))   
       
 
; go-cards : LoFC -> Nat
; displays the cards in sequence (flip via key),
; returning the number of cards 


(define (go-cards lofc)
  (+
   (length lofc)
   (length (fs-cards
            (big-bang (make-fs lofc #t)
              [to-draw draw-fs]
              [on-key flip-fs] 
              [stop-when done-fs?])))))   


; draw-fc : FlashCard -> Image
; Creates an Image out of the FlashCard


(define BG (empty-scene 200 200))
(define FONT-COLOR "red")
(define FONT-SIZE 35)

(check-expect (draw-fc CARD-1 #true) (overlay (text "hello" FONT-SIZE FONT-COLOR) BG))
(check-expect (draw-fc CARD-1 #false) (overlay (text "world" FONT-SIZE FONT-COLOR) BG))
(check-expect (draw-fc CARD-2 #true) (overlay (text "1+1" FONT-SIZE FONT-COLOR) BG))
(check-expect (draw-fc CARD-2 #false) (overlay (text "2" FONT-SIZE FONT-COLOR) BG))

(define (draw-fc fc front?)
  (cond [front? (overlay (text (flashcard-front fc) FONT-SIZE FONT-COLOR) BG)]
        [(not front?) (overlay (text (flashcard-back fc) FONT-SIZE FONT-COLOR) BG)]))


; draw-lofc : LoFc Boolean -> Image
; draws each FlashCard in the LoFc


(check-expect (draw-lofc LOFC-1 #t) (overlay (text "hello" 35 "red") BG))
(check-expect (draw-lofc LOFC-2 #t) (overlay (text "1+1" 35 "red") BG))
(check-expect (draw-lofc LOFC-2 #f) (overlay (text "2" 35 "red") BG)) 


(define (draw-lofc lofc front?)
  (cond [(empty? lofc) BG]
        [(cons? lofc) (draw-fc (first lofc) front?)]))

 
; draw-fs : FlashState -> Image
; Draws the full FlashState.

(check-expect (draw-fs FLASHSTATE-1) (overlay (text "hello" 35 "red") BG))
(check-expect (draw-fs FLASHSTATE-2) (overlay (text "world" 35 "red") BG))
(check-expect (draw-fs FLASHSTATE-3) (overlay (text "2" 35 "red") BG))
  
(define (draw-fs fs)
 (draw-lofc (fs-cards fs) (fs-front? fs)))   


; flip-fs : KeyEvent FlashState -> FlashState
; Flips the flashcard on a key press, and goes to the next card on a second press.

(check-expect (flip-fs FLASHSTATE-1 "x") (make-fs LOFC-1 #f))
(check-expect (flip-fs FLASHSTATE-2 "x") (make-fs LOFC-0 #t))
(check-expect (flip-fs FLASHSTATE-3 "x") (make-fs LOFC-1 #t))  

(define (flip-fs fs ke)
  (if (fs-front? fs)
   (make-fs (fs-cards fs) (not (fs-front? fs)))
   (next-card (fs-cards fs))))  

                    
; next-card : LoFc -> FlashState
; Goes to the next card in a list of cards.

(check-expect (next-card LOFC-1) (make-fs LOFC-0 #t))
(check-expect (next-card LOFC-2) (make-fs LOFC-1 #t))
(check-expect (next-card LOFC-0) (make-fs LOFC-1 #t)) 

(define (next-card lofc)
   (cond
     [(empty? lofc) FLASHSTATE-1]
     [(cons? lofc)
      (make-fs (rest lofc) #true)]))
  
; done-fs? : FlashState -> Boolean
; Checks if the FlashState is out of cards.

(check-expect (done-fs? (make-fs LOFC-0 #t)) #t)
(check-expect (done-fs? (make-fs LOFC-1 #t)) #f)
(check-expect (done-fs? (make-fs LOFC-2 #f)) #f) 

(define (done-fs? fs)
  (done-fc? (fs-cards fs)))

; done-fc? : LoFc -> Boolean
; Checks if the LoFc is out of cards.

(check-expect (done-fc? LOFC-1) #false)
(check-expect (done-fc? LOFC-0) #true)
(check-expect (done-fc? LOFC-2) #false)

(define (done-fc? lofc)
  (empty? lofc))  

 
        





                               
                               



  
 







        
        





