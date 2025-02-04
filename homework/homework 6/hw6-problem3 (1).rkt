;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |hw6-problem3 (1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Back to Wordle (https://www.nytimes.com/games/wordle/)!

; We are going to put together some work you did in prior assignments...
; - In HW1, you made code for a boxed-letter function, which could create a
;   letter in a box, given lots of specific details (about color, size, etc).
; - In HW2, you designed an ls->color function, which would return the color
;   associated with the status of a letter.
; - In HW3, you designed the LetterStatusPair data type, which could represent
;   the pairing of a letter with its status.

; Moving towards the full game, it's going to be handy to be able to more
; simply draw various boxed letters (e.g., those that are part of the current
; guess, as well as those that were previously guessed). So let's build & use
; some abstractions :)

; TODO 1/2: Re-design boxed-letter to work a bit differently: instead of being
;           supplied details of how to draw the box (e.g., background/border
;           colors), it takes a function to make one (given a size), as well as
;           a letter, and then places the letter onto the background produced
;           by the function (with a font size proportional to the box size).
;
;           For clarity, you have been provided a function to produce a "blank"
;           background (useful while typing a guess) - when combined with your
;           new boxed-letter function, the supplied test should pass. You should
;           supplement this test with others in your design.


(define BG-COLOR "white")
(define BORDER-COLOR "dimgray")
(define GUESS-COLOR "black") 

; blank : NonNegReal -> Image
; produces a blank box in the appropriate size

(check-expect (blank 5)
              (overlay (square 5 "outline" BORDER-COLOR)
                       (square 5 "solid" GUESS-COLOR)))

(check-expect (blank 7)
              (overlay (square 7 "outline" BORDER-COLOR)
                       (square 7 "solid" GUESS-COLOR)))

(define (blank size)
  (overlay (square size "outline" BORDER-COLOR)
           (square size "solid" GUESS-COLOR)))


; boxed-letter: 1String NonNegReal [NonNegReal -> Image] -> Image
; places the string on a given background 

(check-expect
 (boxed-letter "B" 64 blank)
 (overlay
  (text "B" 32 BG-COLOR)
  (square 64 "outline" BORDER-COLOR)
  (square 64 "solid" GUESS-COLOR)))

(check-expect
 (boxed-letter "A" 32 blank)
 (overlay
  (text "A" 16 BG-COLOR)
  (square 32 "outline" BORDER-COLOR)
  (square 32 "solid" GUESS-COLOR)))

(define (boxed-letter s num s->img)
  (overlay (text s (/ num 2) BG-COLOR)
           (s->img num)))


; TODO 2/2: Now, use your boxed-letter abstraction to design two useful
;           functions: guess-letter->image and lsp->image. The former
;           produces a visualization of a letter on a blank background,
;           while the latter produces a visualization of a LetterStatusPair
;           (LSP) on a background associated with he letter's status.
;           You have been supplied some tests for clarity (which you can use
;           in your design, but should supplement).
;
;           You are welcome to use your own (correct) design of LetterStatus,
;           LetterStatusPair, or ours; either way, include it below as a part
;           of your solution to this problem. (Note that you might have to
;           adjust your constants and structure name to accommodate the
;           supplied tests.) 


(define LT-SIZE 64)

; guess-letter->image: 1String -> Image
; places the string on a blank background

(define (guess-letter->image s)
  (boxed-letter s LT-SIZE blank))

(check-expect
 (guess-letter->image "A")
 (overlay
  (text "A" (/ LT-SIZE 2) BG-COLOR)
  (square LT-SIZE "outline" BORDER-COLOR)
  (square LT-SIZE "solid" GUESS-COLOR)))

(check-expect
 (guess-letter->image "x")
 (overlay
  (text "x" (/ LT-SIZE 2) BG-COLOR)
  (square LT-SIZE "outline" BORDER-COLOR)
  (square LT-SIZE "solid" GUESS-COLOR)))


; A LetterStatus (LS) is one of:
; - "wrong"
; - "misplaced"
; - "right"
; Interpretation: status of a guessed letter

(define LS-WRONG "wrong")
(define LS-MISPLACED "misplaced")
(define LS-RIGHT "right")

(define (ls-temp ls)
  (...
   (cond
     [(string=? ls LS-WRONG) ...]
     [(string=? ls LS-MISPLACED) ...]
     [(string=? ls LS-RIGHT) ...])))


(define-struct lsp [letter status])

; A LetterStatusPair (LSP) is a (make-lsp 1String LetterStatus)
; Interpretation: the status associated with a letter

(define LSP-A-R (make-lsp "A" LS-RIGHT))
(define LSP-B-W (make-lsp "B" LS-WRONG))
(define LSP-C-M (make-lsp "C" LS-MISPLACED))

(define (lsp-temp lsp)
  (... (lsp-letter lsp) ...
       (ls-temp (lsp-status lsp)) ...))

; lsp->image: LetterStatusPair -> Image
; produces a visualization of the LetterStatusPair

(check-expect
 (lsp->image (make-lsp "A" "right"))
 (overlay
  (text "A" (/ LT-SIZE 2) BG-COLOR)
  (square LT-SIZE "solid" "darkgreen"))) 

(check-expect
 (lsp->image (make-lsp "B" "wrong"))
 (overlay
  (text "B" (/ LT-SIZE 2) BG-COLOR)
  (square LT-SIZE "solid" "dimgray")))

(check-expect
 (lsp->image (make-lsp "C" "misplaced"))
 (overlay
  (text "C" (/ LT-SIZE 2) BG-COLOR)
  (square LT-SIZE "solid" "goldenrod")))

(define (lsp->image lsp)
  (boxed-letter (lsp-letter lsp)
                (/ LT-SIZE 2)
                (make-background lsp)))
   

; make-background: LetterStatusPair -> Image
; chooses a background depending on the status of the LSP
(check-expect (make-background LSP-A-R) (square LT-SIZE "solid" "darkgreen"))
(check-expect (make-background LSP-B-W) (square LT-SIZE "solid" "dimgray"))
(check-expect (make-background LSP-C-M) (square LT-SIZE "solid" "goldenrod"))

(define (make-background lsp)
  (cond [(string=? (lsp-status lsp) LS-RIGHT) (square LT-SIZE "solid" "darkgreen")]
        [(string=? (lsp-status lsp) LS-WRONG) (square LT-SIZE "solid" "dimgray")]
        [(string=? (lsp-status lsp) LS-MISPLACED) (square LT-SIZE "solid" "goldenrod")])) 
