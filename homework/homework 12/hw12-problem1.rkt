;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw12-problem1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; In Homework 3 you worked with the following data...


(define-struct sc [str count])

; A StringCount (SC) is a (make-sc String Nat)
; Interpretation: a string and its count of occurrences

(define SC-A1 (make-sc "A" 1))
(define SC-B1 (make-sc "B" 1))
(define SC-C1 (make-sc "C" 1))
(define SC-A2 (make-sc "A" 2))
(define SC-A3 (make-sc "A" 3))

(define (sc-temp sc)
  (... (sc-str sc) ...
       (sc-count sc) ...)) 


; TODO 1/2: Finish designing the function count-strings, which counts the
;           distinct strings in a list (in the order they appear, left to
;           right). For the purposes of this problem, you are NOT allowed to use
;           the foldl abstraction (which would have been quite useful!).
;
;           Here's a high-level guide to the function...
;           1. Use a list of SC as your accumulator (starting empty).
;           2. Write a template-based function (much like foldl) that returns
;              the accumulator when you've run out of strings; otherwise, it
;              adds the count of the current string to the count and THEN
;              recurs to the rest of the list (passing along the newly
;              accumulated counts). To add to the count...
;              a) If the counts are empty, just create a new one, initializing
;                 it with the string count of 1. Otherwise...
;              b) If the string matches the current SC in the list, add 1 to its
;                 count; otherwise...
;              c) Continue searching for the string in the count list.


; count-strings : [List-of String] -> [List-of SC]
; Produces a count of the distinct strings found in the list

(check-expect (count-strings '()) '())

(check-expect (count-strings (explode "A"))
              (list SC-A1))

(check-expect (count-strings (explode "AAA"))
              (list SC-A3))

(check-expect (count-strings (explode "ABC"))
              (list SC-A1 SC-B1 SC-C1))

(check-expect (count-strings (explode "ABACA"))
              (list SC-A3 SC-B1 SC-C1))    

(check-expect (count-strings (list "cat" "hat" "cat" "hat" "hat"))
              (list (make-sc "cat" 2)
                    (make-sc "hat" 3)))

(define (count-strings los)
  (local [; counts-string/acc : [List-of String] [List-of [Count X]]
          ; accumulates the given list of strings 
          (define (counts-string/acc los counts)
            (cond
              [(empty? los) counts]
              [(cons? los)
               (counts-string/acc (rest los)
                                  (add-count (first los) counts))])) 

          ; add-count : X [List-of [Count X]] -> [List-of [Count X]]
          ; reflects an added count for the supplied string
          (define (add-count x counts)
            (cond
              [(empty? counts)
               (list (make-sc x 1))]
              [(cons? counts) 
               (if (correct-count? x (first counts))
                   (cons (increment-count (first counts))
                         (rest counts))  
                   (cons (first counts)
                         (add-count x (rest counts))))]))
          
          ; correct-count? : X [Count X] -> Boolean
          ; does the count match the element
          (define (correct-count? x count)
            (string=? (sc-str count) x))  

          ; increment-count : [Count X] -> [Count X]
          ; adds one to the supplied count
          (define (increment-count count)
            (make-sc (sc-str count)
                     (add1 (sc-count count))))]
    (counts-string/acc los '())))    

