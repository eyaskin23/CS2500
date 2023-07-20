;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname P3-list-of-moons-skel) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; USING LISTS OF STRUCTURES

; Recall our data definition for Position:

; A Position is a (make-posn Real Real)
; Interpretation: a 2d location
 
(define POSN-1 (make-posn 1 2))
(define POSN-2 (make-posn 5 6))

(define (posn-temp p)
  (... (posn-x p) ...
       (posn-y p) ...))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Create a data definition for a list of Positions.


; A ListofPositions (LoP) is...
;<DO NOW><SCROLL>









; A ListofPositions (LoP) is one of:
; - '()
; - (cons Position LoP)
; Interpretation: a list of positions
 
(define LOP-1
  (cons POSN-1
        (cons POSN-2 '())))
 
(define (lop-temp lop)
  (...
   (cond [(empty? lop) ...]
         [(cons? lop) (posn-temp (first lop)) ...
                      (lop-temp (rest lop) ...)])))
         
         



          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Design the function max-distance-from-origin that accepts a LoP and
; determines the maximal distance of any LoP from the origin.
; For this, we will need to use check-within as we are dealing
; with irrational numbers.


; max-distance-from-origin : LoP -> NonNegReal
; Finds the maximal distance of all positions from the origin

(check-expect (max-distance-from-origin '()) 0)

(check-within (max-distance-from-origin LOP-1)
              (sqrt 61) 0.001)

(check-within (max-distance-from-origin (cons POSN-1 '()))
              (sqrt 5) 0.001)
 
(define (max-distance-from-origin lop) 
  (cond
    [(empty? lop) 0]
    [(cons? lop) (max (distance-from-origin (first lop))
                      (max-distance-from-origin (rest lop)))]))       
 
; distance-from-origin : Position -> NonNegReal
; Calculates the distance to the origin of the given position
 
(check-within (distance-from-origin POSN-1) (sqrt 5) 0.001)
(check-within (distance-from-origin POSN-2) (sqrt 61) 0.001)
  
(define (distance-from-origin p)
  (sqrt (+ (sqr (posn-x p))
           (sqr (posn-y p))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; For the next exercise, let's review our most recent revision of the many-moons simulation

(require 2htdp/image)
(require 2htdp/universe)
 
(define-struct moon [x vx])
 
; A Moon is a (make-moon Number Number)
; Representing the position and velocity of a moon.
;  - x is the x-position of the moon
;  - vx is the x-velocity of the moon
 
(define MOON-1 (make-moon 10 1))
(define MOON-2 (make-moon 300 -1))
 
(define (moon-temp m)
  (... (moon-x m) ... (moon-vx m) ...))
 
  
; A ListofMoons (LoM) is one of:
; - ' ()
; - (cons Moon System)
; Representing the collection of moons we're trying
; to simulate

 
(define LOM-0 '())
(define LOM-1 (cons MOON-1 LOM-0))
(define LOM-2 (cons MOON-2 LOM-1))
 
(define (lom-eclipse s)
  (...
   (cond 
     [(empty? lom) ...]
     [(cons? lom) (... (moon-temp (first s)) ...
                     (lom-temp (rest s)) ...)])))
 
; eclipse : LoM -> LoM
; Runs an eclipse of moons
 
(define (eclipse initial-s)
  (big-bang initial-s
    [to-draw draw-eclipse]
    [on-tick move-and-filter-eclipse]
    [on-key add-moon]))
 
; draw-eclipse : LoM -> Image
; Draw the moons on a scene with the sun
 
(define SIZE 400)
(define HALF (/ SIZE 2))
(define RADIUS (/ SIZE 10))
 
(define SUN (circle RADIUS "solid" "yellow"))
(define MOON (circle RADIUS "solid" "gray"))
(define SKY (square SIZE "solid" "pink"))
 
(check-expect (draw-eclipse LOM-0)
              (place-image
               SUN
               HALF HALF
               SKY))
 
(check-expect (draw-eclipse LOM-2)
              (place-image
               MOON
               300 HALF
               (place-image
                MOON
                10 HALF
                (place-image
                 SUN
                 HALF HALF
                 SKY))))
 
(define (draw-eclipse s)
  (cond
    [(empty? s) (place-image SUN HALF HALF SKY)]
    [(cons? s) (draw-moon (first s)
                          (draw-eclipse (rest s)))]))
 
; draw-moon : Moon Image -> Image
; Draws a moon onto a background
 
(check-expect (draw-moon MOON-1 SKY)
              (place-image MOON (moon-x MOON-1) HALF SKY))
 
(define (draw-moon moon background)
  (place-image MOON
               (moon-x moon) HALF
               background)) 
 
; move-eclipse : LoM -> LoM
; Moves moons for one tick
 
(check-expect (move-eclipse LOM-0) LOM-0)
 
(check-expect (move-eclipse LOM-2)
              (cons
               (make-moon 299 -1)
               (cons
                (make-moon 11 1)
                '())))
 
(define (move-eclipse lom)
  (cond
    [(empty? lom) '()]
    [(cons? lom) (cons (move-moon (first lom))
                       (move-eclipse (rest lom)))])) 
 
; move-moon : Moon -> Moon
; Moves a single moon
 
(check-expect (move-moon MOON-1)
              (make-moon 11 1))
 
(check-expect (move-moon MOON-2)
              (make-moon 299 -1))
 
(define (move-moon m)
  (make-moon (+ (moon-x m) (moon-vx m))
             (moon-vx m))) 
 
; add-moon : System KeyEvent -> System
; Adds a moon to the system
 
(define NEW-MOON-X 1)
(define NEW-MOON-VX 20)
 
(check-expect (add-moon LOM-0 " ")
              (cons
               (make-moon NEW-MOON-X NEW-MOON-VX) 
               '()))
 
(check-expect (add-moon LOM-2 "right")
              (cons
               (make-moon NEW-MOON-X NEW-MOON-VX)
               LOM-2))
 
(define (add-moon s ke)
  (cons (make-moon NEW-MOON-X NEW-MOON-VX) s))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; First move, then filter those out of sight.
; Start with big-bang, then design move-and-filter-eclipse -> filter-eclipse -> keep-moon?.


; move-and-filter-eclipse : LoM -> LoM
; Moves moons for one tick, filtering those off the screen
 
(check-expect (move-and-filter-eclipse LOM-0) '())
 
(check-expect (move-and-filter-eclipse LOM-2)
              (cons
               (make-moon 299 -1)
               (cons
                (make-moon 11 1)
                '())))
 
(check-expect (move-and-filter-eclipse
               (cons (make-moon (* 2 SIZE) 1)
                     (cons
                      (make-moon 10 1)
                      '())))
              (cons (make-moon 11 1) '()))
 
(define (move-and-filter-eclipse lom)
 (filter-eclipse
 (move-eclipse lom)))
  
; filter-eclipse : LoM -> LoM
; Filters those moons off the screen
 
(check-expect (filter-eclipse
               (cons (make-moon (* 2 SIZE) 1)
                     (cons
                      (make-moon 10 1)
                      '())))
              (cons (make-moon 10 1) '()))
 
(define (filter-eclipse lom)
  (...
   (cond
     [(empty? lom) '()]
     [(cons? lom) (if (keep-moon? (first lom)) ; if we want to keep the first moon, create a new list with that same moon
                      (cons (first lom) (filter-eclipse (rest lom)) ...
                      (filter-eclipse (rest lom))))]))) 

; keep-moon? : Moon -> Boolean
; Determines if a moon is visible
 
(check-expect (keep-moon? (make-moon (* 2 SIZE) 1)) #false)
(check-expect (keep-moon? (make-moon (* 0.5 SIZE) 1)) #true)
 
(define (keep-moon? m)
  (< (moon-x m) (+ SIZE RADIUS)))

; Lastly, don't forget to update event handler in big-bang call
;<DO NOW>
