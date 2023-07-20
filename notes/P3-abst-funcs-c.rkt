;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname P3-abst-funcs-c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Congratulations! But what can we do with this new superpower?

; Recall our data definition for Position and ListOfPosns

; A Position is a (make-posn Number Number)
; representing a 2D position
 
(define POSN-0 (make-posn 0 0))
(define POSN-1 (make-posn 3 4))
 
(define (posn-temp p)
  (... (posn-x p) ...
       (posn-y p) ...))
 
; A ListOfPosns (LoP) is one of:
; - '()
; - (cons Position LoP)
; representing a list of Positions
 
(define LOP-0 '())
(define LOP-1 (cons POSN-0 '()))
(define LOP-2 (cons POSN-1 LOP-1))
 
(define (lop-temp lop)
  (...
   (cond
     [(empty? lop) ...]
     [(cons? lop) ...
      (posn-temp (first lop)) ...
      (lop-temp (rest lop)) ...]))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Side A:
;   Write manhattan-dist-all that accepts a ListofPosns and computes the
;   Manhattan distance of all of them.


; Side B:
;   Write euclidean-dist-all that accepts a ListOfPosns and computes the
;   Euclidean distance of all of them.

; We are providing helper functions manhattan-dist and euclidean-dist

;<DO NOW><SCROLL> 





; manhattan-dist-all : LoP -> LoN
; Compute the manhattan distance to the origin of all positions
 
(check-expect (manhattan-dist-all LOP-0) LOP-0)
(check-expect (manhattan-dist-all LOP-2)
              (cons 7
                    (cons 0 '())))

;(define (manhattan-dist-all lop)
  ;(cond
   ;  [(empty? lop) ' ()]
    ; [(cons? lop) ((first lop))
     ;             (manhattan-dist-all (rest lop))])) 
 

; manhattan-dist : Position -> Number
; Computes the manhattan distance to the origin
 
(check-expect (manhattan-dist POSN-0) 0)
(check-expect (manhattan-dist POSN-1) 7)
 
(define (manhattan-dist p)
  (+ (abs (posn-x p))
     (abs (posn-y p))))


; euclidean-dist-to-all : LoP -> LoN
; Compute the Euclidean distance to the origin of all positions
 
(check-expect (euclidean-dist-to-all LOP-0) LOP-0)
(check-expect (euclidean-dist-to-all LOP-2)
              (cons 5
                    (cons 0 '())))
 
;(define (euclidean-dist-to-all lop)
  ;<DO NOW> Helper: euclidean-dist<DONE>




 ; )
 
; euclidean-dist : Position -> Number
; Computes the Euclidean distance to the origin
 
(check-expect (euclidean-dist POSN-0) 0)
(check-expect (euclidean-dist POSN-1) 5)
 
(define (euclidean-dist p)
  (sqrt
   (+ (sqr (posn-x p))
      (sqr (posn-y p)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Now abstract those. Where are the differences?
; Similar to previous exercise, can we leverage effort there? REALLY leverage??
;<BRAINSTORM>






; We can reuse do-to-all!!!
; But does do-to-all care about what data type is in the list?

; do-to-all : LoN Function-that-accepts-a-Number-and-returns-a-Number -> LoN
; Applies the second argument to each of the numbers
 
(define (do-to-all lon f)
  (cond
    [(empty? lon) '()]
    [(cons? lon)
     (cons
      (f (first lon))
      (do-to-all (rest lon) f))]))

; Our signature says it does, but let's try it anyway.
; Rewrite those two in terms of do-to-all:
;<DO NOW><SCROLL>





; visualize-all : [List-of String] -> [List of Image]
; visualizes all the supplied strings


(define FONT 18)

(check-expect
 (visualize-all '())
 '())


(check-expect
 (visualize-all
  (cons "foo"
        (cons "bar" '())))
 (cons (text "foo" FONT "black")
       (cons (text "bar" FONT "black") '())))

(define (visualize-all los)
  (do-to-all los string-> image))

; string->image : String -> Image
; visualizes a string

(check-expect
 (string->image "foo")
 (text "foo" FONT "black"))

(define (string->image s)
  (text "foo" FONT "black"))


;(define (manhattan-dist-all lop)
;  (do-to-all lop manhattan-dist))

;(define (euclidean-dist-to-all lop)
  ;(do-to-all lop euclidean-dist))
;
; Note: signatures for helpers are:
; euclidean-dist : Position -> Number
; euclidean-dist : Position -> Number

; This suggests that our previous signature for do-to-all might be a bit too restrictive.
; Think about that for tomorrow.

