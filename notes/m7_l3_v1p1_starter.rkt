;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m7_l3_v1p1_starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; play the game!

(define (guessing-game word)
  (big-bang (map make-unguessed (explode-word)
      [to-draw draw-wof]
      [stop-when all-guessed? draw-wof]
      [on-key handle-key])))

; draw-wof : WoF -> Image

(define (draw-wof wof)
  ...)

; handle-key : WoF KeyEvent -> WoF

(define (handle-key wof ke)
  ...)
