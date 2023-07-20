;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname e2-problem3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO 1/1: Design the data RoadNetwork to represent a network of roads in a new
;           town, which contains... 

;           stretches of road of a particular distance (measured in kilometers,
;           or km)

;                 |   |
;                 | 3 |
;                 |   |
;                   ↑
;
;           (example stretch of road, 3km),

;           "dead ends", where roads end

;                 -----
;                 |   |
;                   ↑
;
;           (example dead end),

;           and "T" intersections, where a road can go left or right

;               -----------
;
;               ---┐   ┌---
;                  |   |
;                    ↑
;
;           (example T-intersection).

;           Notes:
;           - Your design does NOT need to in any way visualize the road
;             network, only represent any network made up of these road types.
;           - Remember to follow all steps of the design recipe for data!
;           - Your design MUST contain the following example (written
;             and then visualized for clarity; you may create more examples if
;             you'd like but they will not be graded)... 

;             A stretch 3km long, arriving at a T intersection:
;             - to the left is a dead end.
;             - to the right is a stretch 1km long, followed by another stretch
;               7km long, arriving at a T-intersection:
;               - to the left is a stretch 4km long, followed by a dead end.
;               - to the the right is a stretch 2km long, followed by a
;                 T-intersection:
;                 - to the left is a stretch 2km long, followed by a dead end.
;                 - to the right is a stretch 3km long, followed by a dead end.

; stretch 3
; t-intersection
; left -> dead end
; right -> stretch 1
; stretch 7 -> t-intersection
; left -> stretch 4 -> dead end
; right t - > stretch 2 -> t-intersection
; stretch 2 -> dead end
; stretch 3 -> dead end

       
;                                ---
;                               |   |
;                               |   |
;                               | 4 |
;                               |   |
;                 --------------┘   |
;                |       1    7     |
;                 -┐   ┌--------┐   |
;                  |   |        | 2 |
;                  | 3 |        |   |
;                  |   |     ---┘   └--
;                    ↑      | 3      2 |
;                            ----------


(define-struct t-intersection [stretch deadend?])

; A T-Intersection is a (make-t-intersection Nat Boolean)
; Interpretation: A T-intersection in a roadnetwork.
; -  stretches of road of a particular distance (measured in kilometers,
;           or km)
; - dead end returns #t if goes to a dead end, and #f if otherwise

(define (t-intersection-temp tl)
  (... (t-intersection stretch) ...
       (t-intersection deadend?) ...))

(define-struct roadnetwork [stretch deadend? t-intersection])

; A RoadNetwork is a (make-roadnetwork Nat Boolean T-Intersection)
; Interpretation: the type of road in a new town. 
; -  stretches of road of a particular distance (measured in kilometers,
;           or km)
; - dead end returns #t if goes to a dead end, and #f if otherwise
; - t-intersection is a t-intersection of a road that turns left or right

; stretch 3
; t-intersection
; left -> dead end
; right -> stretch 1
; stretch 7 -> t-intersection
; left -> stretch 4 -> dead end
; right t - > stretch 2 -> t-intersection
; stretch 2 -> dead end
; stretch 3 -> dead end

(define ROADNETWORK1
  (make-roadnetwork
   (make-roadnetwork 3 #f
                     (make-t-intersection 1 #t))
   (make-roadnetwork 1 #t
                     (make-t-intersection 2 #f))
   (make-roadnetwork 0 #f
                     (make-t-intersection 2 #t))
   (make-roadnetwork 0 #f
                     (make-t-intersection 3 #t))))

(define (roadnetwork-temp rn)
  (... (roadnetwork-stretch) ...
       (roadnetwork-deadend?) ...
       (t-intersection-temp (roadnetwork-t-intersection)) ...)) 

                                     








