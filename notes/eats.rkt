;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname eats) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; TODO 1/4: Sanitation scores for restaurants can be either a
;           rating (A, B, C, D, F) or a number (1-100). Design
;           would-eat? that determines if a supplied sanitation
;           score is better than a "C" or at least 80.

; A Rating is one of: 
; - "A"
; - "B"
; - "C"
; - "D"
; - "F"
; Interpretation: restaurant sanitation rating

(check-expect RATING-A "A")
(check-expect RATING-B "B")
(check-expect RATING-C "C")
(check-expect RATING-D "D")
(check-expect RATING-F "F") 

(define (rating-temp f)
  (...
   (cond
     [(string=? r RATING-A)]
     [(string=? r RATING-B)]
     [(string=? r RATING-C)]
     [(string=? r RATING-D)]
     [(string=? r RATING-F)])))

(define RATING-A "A")
(define RATING-B "B")
(define RATING-C "C")
(define RATING-D "D")
(define RATING-F "F")

; A SanitationScore is one of:
; - Rating
; - PosInt[1, 100]
; Interpretation: a restaurant sanitation score
; either categorical or numeric

(define SANSCORE-A RATING-A)
(define SANSCORE-C RATING-C)
(define SANSCORE-F RATING-F)
(define SANSCORE-23 23)
(define SANSCORE-80 80)
(define SANSCORE-97 97)

(define (sanscore-temp score)
  (...
   (cond
     [(string? score) ... (rating-temp score) ...]
     [(number? score) ... score ...])))
               
; would-eat? : SanitationScore -> Boolean
; determines if the supplied score is A/B or at least 80

(check-expect (would-eat? RATING-A) #true)
(check-expect (would-eat? RATING-C) #false)
(check-expect (would-eat? RATING-F) #false)
(check-expect (would-eat? SANSCORE-23) #false)
(check-expect (would-eat? SANSCORE-80) #true)
(check-expect (would-eat? SANSCORE-97) #true)

(define (would-eat? score)
  (cond
    [(string? score) (would-eat?/rating score)]
    [(number? score) (>= score 80)])) 

; would-eat?/rating : Rating -> Boolean
; would I eat based upon the categorical rating

(check-expect (would-eat?/rating RATING-A) #t)
(check-expect (would-eat?/rating RATING-B) #t)
(check-expect (would-eat?/rating RATING-C) #f)
(check-expect (would-eat?/rating RATING-D) #f)
(check-expect (would-eat?/rating RATING-F) #f)

(define (would-eat?/rating r)
  (or
   (string=? r RATING-A)
   (string=? r RATING-B))) 


; TODO 2/4: Design sanitary-restaurants, a function that produces
;           a subset of restaurants in a supplied group that
;           have a good enough sanitation score to eat at. Each
;           restaurant in a group has a name, its sanitation score,
;           and whether or not it's healthy.

(define-struct restaurant [name score healthy?])

; A Restaurant is a (make-restaurant String SanitationScore Boolean)
; Interpretation: info about a restaurant 

(define REST-1 (make-restaurant "El Jefe's" RATING-B #f))
(define REST-2 (make-restaurant "Pizza Union" RATING-F #f))
(define REST-3 (make-restaurant "B.Good" 89 #t))
(define REST-4 (make-restaurant "Chipotle" RATING-C #t))

(define (rest-temp r)
  (... (restaurant-name r) ...
       (sanscore-temp (restaurant-score r)) ...
       (restaurant-healthy? r) ...))

(define-struct group [restaurant others])
       

; A RestaurantGroup is one of: 
; - #false
; - (make-group Restaurant RestaurantGroup)
; Interpretation: an empty group or a restaurant
; and the others in the group

(define GROUP-0 #false)
(define GROUP-1 (make-group REST-1 GROUP-0))
; El Jefe's + False
(define GROUP-2 (make-group REST-2 GROUP-1))
; Pizza Union + El Jefe's #false
(define GROUP-3 (make-group REST-3 GROUP-2))
; B.Good + El Jefe's #false
(define GROUP-4 (make-group REST-4 GROUP-3))
; Chipotle + B Good + El Jefe's #false

(define (group-temp g)
  (...
   (cond
     [(boolean? g) ...]
     [(group? g)
      (...(rest-temp (group-restaurant g) ...
                     (group-temp (group-others g) ...)))])))


; sanitary-restaurants : RestaurantGroup -> RestaurantGroup
; produces the subset of the group that is sanitary

(check-expect (sanitary-restaurants GROUP-0) GROUP-0)
(check-expect (sanitary-restaurants GROUP-4)
              (make-group REST-3
                          (make-group REST-1
                                      GROUP-0))) 
(define (sanitary-restaurants g)
  (cond
    [(boolean? g) g]
    [(group? g)
     (if (sanitary? (group-restaurant g))
         (make-group (group-restaurant g)
                     (sanitary-restaurants (group-others g)))
         (sanitary-restaurants (group-others g)))]))

; sanitary? : Restaurant -> Boolean
; is the restaurant sanitary?

(check-expect (sanitary? REST-1) #t)
(check-expect (sanitary? REST-2) #f)
(check-expect (sanitary? REST-3) #t)
(check-expect (sanitary? REST-4) #f)

(define (sanitary? r)
  (would-eat? (restaurant-score r)))

; TODO 3/4: Design group-summary, a function that produces a comma-
;           separated textual summary of a restaurant group, where
;           healthy restaurants are *'d and the sanitation score is
;           shown for each restaurant. 


; group-summary : RestaurantGroup -> String
; Produces a summary of which restaurants are healthy along with their sanitation scores.

(check-expect (group-summary GROUP-0) "")
(check-expect (group-summary GROUP-2) "Pizza Union (F), El Jefe's (B), ")
(check-expect (group-summary GROUP-3) "B.Good*(89), Pizza Union (F), El Jefe's (B), ") 

(define (group-summary g)
  (cond
    [(boolean? g) ""] 
    [(group? g) (string-append (print-restaurant (group-restaurant g)) (group-summary (group-others g)))])) 
     

; healthy? : Restaurant -> Boolean
; States whether or not a restaurant is healthy.

;(check-expect (healthy? REST-1) #f)
;(check-expect (healthy? REST-2) #f)
;(check-expect (healthy? REST-3) #t)
;(check-expect (healthy? REST-4) #t)

;(define (healthy? r)
;  (cond
;   [(string? (restaurant-score r))
;    (or 
;   (string=? RATING-A (restaurant-score r))
;   (string=? RATING-B (restaurant-score r)))]
;   [(number? (restaurant-score r) (>= restaurant-score 80))]))

; print-restaurant : Restaurant -> String
; Prints a string with Restaurant info.

(check-expect (print-restaurant REST-1) "El Jefe's (B), ")

(define (print-restaurant r)
  (string-append (restaurant-name r)(if (restaurant-healthy? r)
        "*" " ") "(" (sanscore (restaurant-score r)) "), ")) 

; sanscore : SanitationScore -> String

(define (sanscore score)
   (cond
     [(string? score) score]
     [(number? score) (number->string score)])) 
   

; TODO 4/4: Design half-healthy?, a function that determines if at
;           least half the restaurants in a supplied group are
;           healthy (noting that a group with no restaurants isn't
;           considered half healthy).


