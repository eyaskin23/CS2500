;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m7_l3_v1p4_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct guessed (char))
(define-struct unguessed (char))
 
; A Game1String is one of:
; - (make-guessed 1String)
; - (make-unguessed 1String)
; Interpretation: a 1String in the word,
; either it has been guessed already or
; it is still hidden
 
(define G1S-1 (make-guessed "a"))
(define G1S-2 (make-unguessed "a"))
 
(define (g1s-temp g1s)
  (...
   (cond
     [(guessed? g1s) (... (guessed-char g1s) ...)]
     [(unguessed? g1s) (... (unguessed-char g1s) ...)])))
 
; A WorldOfFortune (WoF) is a [List-of Game1String]
; Interpretation: the current state of the game

; start
(define WOF-0 (list (make-unguessed "h")
                    (make-unguessed "e")
                    (make-unguessed "l")
                    (make-unguessed "l")
                    (make-unguessed "o")))

; guessed e
(define WOF-1 (list (make-unguessed "h")
                    (make-guessed "e")
                    (make-unguessed "l")
                    (make-unguessed "l")
                    (make-unguessed "o")))

; then guessed l
(define WOF-2 (list (make-unguessed "h")
                    (make-guessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-unguessed "o")))

; then guessed h
(define WOF-3 (list (make-guessed "h")
                    (make-guessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-unguessed "o")))

; then guessed o
(define WOF-4 (list (make-guessed "h")
                    (make-guessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-guessed "o")))


; guessing-game : String -> WoF
; play the guessing game!

(define (guessing-game word)
  (big-bang (map make-unguessed (explode word))
    [to-draw draw-wof]
    [stop-when all-guessed? draw-wof]
    [on-key handle-key]))
  
; draw-wof : WoF -> Image
; visualize the game state

(define IMAGE-TEXT-SIZE 35)
(define IMAGE-COLOR "red")
 
(check-expect
 (draw-wof WOF-0)
 (text "?????" IMAGE-TEXT-SIZE IMAGE-COLOR))

(check-expect
 (draw-wof WOF-1)
 (text "?e???" IMAGE-TEXT-SIZE IMAGE-COLOR))

(define (draw-wof wof)
  (text (wof->string wof) IMAGE-TEXT-SIZE IMAGE-COLOR))

; wof->string : WoF -> String
; produces a string from a WoF

(check-expect
 (wof->string WOF-0)
 "?????")

(check-expect
 (wof->string WOF-1)
 "?e???")

(define (wof->string wof)
  (foldr string-append
         ""
         (map g1s->string wof)))

; g1s->string : Game1String -> 1String
; converts a Game1String to either a letter or a question mark

(check-expect
 (g1s->string
  (make-guessed "a"))
 "a")

(check-expect
 (g1s->string
  (make-unguessed "a"))
 "?")

(define (g1s->string g1s)
   (cond
     [(guessed? g1s)
      (guessed-char g1s)]
     [(unguessed? g1s)
      "?"]))

; all-guessed? : WoF -> Boolean
; detects when all letters have been guessed

(check-expect
 (all-guessed? WOF-0)
 #false)

(check-expect
 (all-guessed? WOF-1)
 #false)

(check-expect
 (all-guessed? WOF-2)
 #false)

(check-expect
 (all-guessed? WOF-3)
 #false)

(check-expect
 (all-guessed? WOF-4)
 #true)

(define (all-guessed? wof)
  (andmap guessed? wof))

; handle-key : WoF KeyEvent -> WoF

(define (handle-key wof ke)
  ...)
