;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw3-problem2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Back to Wordle (https://www.nytimes.com/games/wordle/)!

; Recall that in HW2 you designed the type LetterStatus, an enumeration
; that categorized letters as correct, misplaced, or wrong.

; TODO 1/1: Design LetterStatusPair - data that represents pairing a letter
;           (1String) with its status (LetterStatus). Example values might
;           include that the the letter "A" is correct, "B" is wrong, or
;           "C" is misplaced.
;
;           Notes:
;           - You are welcome to use your own (correct) design of
;             LetterStatus, or ours (once released); either way, include
;             it below as a part of your solution to this problem.
;           - Follow all steps of the design recipe for data and remember
;             that in templates, if the type of a field is a data definition,
;             you need to call its associated template!

; A LetterStatus (LS) is one of:
; - "wrong"
; - "misplaced"
; - "right"
; Interpretation: status of a guessed letter

(define LS-WRONG "wrong")
(define LS-MISPLACED "misplaced")
(define LS-RIGHT "right")

(define (ls-temps ls)
  (...
   (cond
     [(string=? ls LS-WRONG) ...]
     [(string=? ls LS-MISPLACED) ...]
     [(string=? ls LS-RIGHT) ...])))

    
(define-struct letter-status-pair [1string LetterStatus])

; A LetterStatusPair is a (make-letter-status-pair 1String LetterStatus)
; Represents a pair between a letter and whether or not it's correct.

(define LETTER-STATUS-PAIR-A (make-letter-status-pair "A" LS-WRONG))
(define LETTER-STATUS-PAIR-B (make-letter-status-pair "B" LS-MISPLACED))
(define LETTER-STATUS-PAIR-C (make-letter-status-pair "C" LS-RIGHT))

(define (lps-temp lps)
  (...
   (cond
     [(string=? ls LS-A) ...]
     [(string=? ls LS-B) ...]
     [(string=? ls LS-C) ...]))) 