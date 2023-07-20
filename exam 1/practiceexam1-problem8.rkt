;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practiceexam1-problem8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 8
;;
;; *This is a programming problem that you should do in DrRacket.*
;;
;; Consider the following data definition and interpretation:

(define-struct star [name mass])
(define-struct planet [name mass closer]) 

;; A SolarSystem is one of:
;; - (make-star String Number)
;; - (make-planet String Number SolarSystem)
;; Interpretation: A solar system has a star, and some number of planets 
;; orbiting that star.
;; A SolarSystem is either:
;; - The star of a solar system, with its name and mass in Earth masses.
;;   (The mass of the Earth is 1 Earth mass.)
;; - A planet with name and mass (in Earth masses) that orbits farther
;;   than the portion of the solar system that is closer.

;; Part A 

;; Write four examples of a SolarSystem. You do *not* have to get names of
;; planets or their masses correct. Feel free to make them up.

;; [TODO] Four examples

(define SOLAR-SYSTEM-1 (make-star "Sun" 333000))
(define SOLAR-SYSTEM-2 (make-planet "Mercury" 0.055 SOLAR-SYSTEM-1))
(define SOLAR-SYSTEM-3 (make-planet "Venus" 0.82 SOLAR-SYSTEM-2))
(define SOLAR-SYSTEM-4 (make-planet "Earth" 1 SOLAR-SYSTEM-3)) 

;; Part B

;; Write the template for a SolarSystem.

;; [TODO] Template

(define (ss-temp ss)
  (...
   (cond
     [(star? ss) ...
      (star-name ss) ...
      (star-mass ss) ...]
     [(planet? ss) ...
      (planet-name ss) ...
      (planet-mass ss) ...
      (ss-temp (planet-closer ss)) ...])))

;; Part C

;; Design a function called solar-system-star-name
;; that produces the name of the star in a solar system.

;; [TODO] Function design

; solar-system-star-name : SolarSystem -> String
; Produces the name of the sun in the solar system. 

(check-expect (solar-system-star-name SOLAR-SYSTEM-1) "Sun")
(check-expect (solar-system-star-name SOLAR-SYSTEM-2) "Sun")
(check-expect (solar-system-star-name SOLAR-SYSTEM-3) "Sun")
(check-expect (solar-system-star-name SOLAR-SYSTEM-4) "Sun")

(define (solar-system-star-name ss)
   (cond
     [(star? ss) (star-name ss)]
     [(planet? ss) (solar-system-star-name (planet-closer ss))]))






