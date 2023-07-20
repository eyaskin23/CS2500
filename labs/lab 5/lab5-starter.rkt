;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lab5-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Your goal is to design a slide show program. Every slide will have
; a title and a list of bullets to display, and each slide and item
; will be preceded by a key press.

; Consider the data definitions and examples below...


; A ListOfStrings (LoS) is one of:
; - '()
; - (cons String LoS)
; Interpretation: a list of strings

(define SLIDE-1-LOS
  (cons "Designing programs to solve problems"
        (cons "Building good habits for developing large systems with a team"
              (cons "CS: fundamental ideas, thinking" '()))))

(define SLIDE-2-LOS
  (cons "Effectively using computers as tools"
        (cons "Breaking down problems" '())))

(define SLIDE-3-LOS
  (cons "Easy to start"
        (cons "Informative feedback"
              (cons "Functional programming is a useful paradigm" '()))))


(define-struct slide [title shown hidden])

; A Slide is a (make-slide String LoS LoS)
; Interpretation: a slide's title, what bullets
; have been shown, and those that are hidden

(define SLIDE-1
  (make-slide
   "What is Fundies 1 About?"
   '() SLIDE-1-LOS))

(define SLIDE-1-NEXT
  (make-slide
   "What is Fundies 1 About?"
   (cons "Designing programs to solve problems" '())
   (cons "Building good habits for developing large systems with a team"
         (cons "CS: fundamental ideas, thinking" '()))))

(define SLIDE-1-NEXT-NEXT
  (make-slide
   "What is Fundies 1 About?"
   (cons "Designing programs to solve problems"
         (cons "Building good habits for developing large systems with a team" '()))
   (cons "CS: fundamental ideas, thinking" '())))

(define SLIDE-1-DONE
  (make-slide "What is Fundies 1 About?"
              SLIDE-1-LOS '()))

(define SLIDE-2
  (make-slide "What is Computer Science?"
              '() SLIDE-2-LOS))

(define SLIDE-3
  (make-slide "Why DrRacket?"
              '() SLIDE-3-LOS))

; A Slideshow is one of:
; - '()
; - (cons Slide Slideshow)
; Interpretation: an ordered slideshow

(define SLIDESHOW-1
  (cons SLIDE-1 (cons SLIDE-2 (cons SLIDE-3 '()))))

(define SLIDESHOW-1-NEXT
  (cons SLIDE-1-NEXT (cons SLIDE-2 (cons SLIDE-3 '()))))

(define SLIDESHOW-1-DONE
  (cons SLIDE-1-DONE (cons SLIDE-2 (cons SLIDE-3 '()))))

(define SLIDESHOW-2
  (cons SLIDE-2 (cons SLIDE-3 '())))


; TODO 1/7: Complete the Design Recipe for LoS, Slide and Slideshow
;           by creating their templates.


(define (los-temp los)
  (...
   (cond
     [(empty? los) ...]
     [(cons? los) ...
      (first los) ...
      (los-temp (rest los)) ...])))

(define (slide-temp slide)
  (... (slide-title slide) ...
       (los-temp (slide-shown slide)) ...
       (los-temp (slide-hidden slide)) ...))



; TODO 2/7: Design the function draw-slide that draws a slide, showing
;           only its title and unhidden content on a large background
;           of a fixed size. The text of the bullets should be arranged
;           above each other. You are free to be creative about your
;           slide design :)


; draw-slide : Slide -> Image
; Visualizes a slide

(define FONT-SIZE 15)
(define FONT-COLOR "black")
(define BG (empty-scene 500 500))

(check-expect
 (draw-slide SLIDE-1)
 (overlay
  (above
   (text/font "What is Fundies 1 About?"
              FONT-SIZE FONT-COLOR #false "default" "normal" "normal" #true)
   (text "Designing programs to solve problems"
         FONT-SIZE FONT-COLOR)
   (text "Building good habits for developing large systems with a team"
         FONT-SIZE FONT-COLOR)
   (text "CS: Fundamental ideas, thinking"
         FONT-SIZE FONT-COLOR))
  BG))

(define (draw-slide slide)
  (overlay
   (above
    (text/font (slide-title slide)
               FONT-SIZE FONT-COLOR #false "default" "normal" "normal" #true)
    (draw-bullets (slide-shown slide)))
   BG))

; draw-bullets : LoS -> Image
; Draw the bullets.

(check-expect
 (draw-bullets (cons "a" (cons "b" '())))
 (above
  (text "a" FONT-SIZE FONT-COLOR)
  (text "b" FONT-SIZE FONT-COLOR)))

(define (draw-bullets los)
  (cond
    [(empty? los) empty-image]
    [(cons? los)
     (above
      (text (first los) FONT-SIZE FONT-COLOR)
      (draw-bullets (rest los)))]))



; TODO 3/7: Design the function draw-slideshow that draws the
;           slideshow’s first slide (if one exists, otherwise
;           an empty background).


; draw-slideshow : Slideshow -> Image
; Visualize the slideshow

(check-expect
 (draw-slideshow '())
 BG)

(check-expect
 (draw-slideshow SLIDESHOW-1)
 (draw-slide SLIDE-1))

(define (draw-slideshow slideshow)
  (cond
    [(empty? slideshow) BG]
    [(cons? slideshow)
     (draw-slide (first slideshow))])) 



; TODO 4/7: Design the function slide-over? that determines if a
;           slide is over (none of its bullets are hidden).


; slide-over? : Slide -> Boolean
; Is the slide over?

(check-expect
 (slide-over? SLIDE-1) #false)

(check-expect
 (slide-over? SLIDE-1-NEXT) #false)

(check-expect
 (slide-over? SLIDE-1-NEXT-NEXT) #false)

(check-expect
 (slide-over? SLIDE-1-DONE) #true)

(define (slide-over? slide)
  (empty? (slide-hidden slide)))



; TODO 5/7: Design the function advance-slide that moves the first
;           entry in a slide’s hidden content to the end of its shown
;           content if there is any hidden content. As examples,
;           look to SLIDE-1 -> SLIDE-1-NEXT -> SLIDE-1-NEXT-NEXT ->
;           SLIDE-1-DONE.
;           (Hint: the append function will be quite useful.)


; advance-slide : Slide -> Slide
; Advance a slide

(check-expect
 (advance-slide SLIDE-1)
 SLIDE-1-NEXT)

(check-expect
 (advance-slide SLIDE-1)
 SLIDE-1-NEXT-NEXT) 

(check-expect
 (advance-slide SLIDE-1)
 SLIDE-1-DONE)

(define (advance-slide slide)
  (if (slide-over? slide)
      slide
      (make-slide
       (slide-title slide)
       (added-to-bottom
        (slide-hidden slide)
        (slide-shown slide))
       (rest (slide-hidden slide)))))
        
; added-to-bottom : LoS LoS -> LoS
; produces the result of adding the first element of the first line
; to the bottom of the second list

(check-expect (added-to-bottom '() '()) '())
(check-expect (added-to-bottom '() (list 1 2 3)) (list 1 2 3))
(check-expect (added-to-bottom (list 1 2 3) '()) (list 1))
(check-expect (added-to-bottom (list "a" "b" "c") (list "howdy")) (list "howdy" "a"))

(define (added-to-bottom l1 l2)
  (cond
    [(empty? l1) l2]
    [(cons? l1)
     (append
      l2
      (list (first l1)))]))


; TODO 6/7: Design the function advance-slideshow that either
;           advances its first slide if it has more content to be
;           shown or moves onto the next slide if there is one.


(check-expect
 (advance-slide '())
 '())

(check-expect
 (advance-slideshow SLIDESHOW-1)
 SLIDESHOW-1-NEXT)

(check-expect
 (advance-slideshow SLIDESHOW-1-DONE)
 SLIDESHOW-1-DONE) 

(define (advance-slideshow ss)
  (cond
    [(empty? ss) '()]
    [(cons? ss)
     (if (slide-over? (first ss))
         (rest ss)
         (cons (advance-slide (first ss))
               (rest ss)))]))
 
; TODO 7/7: Design the World program go-slideshow that will advance
;           a slideshow when any key is pressed. The program should
;           end (i.e., stop-when) when there are no more slides left,
;           returning the total number of slides.


(define (go-slideshow slideshow)
  (+ (length slideshow)
     (length
      (big-bang slideshow
        [to-draw draw-slideshow]
        [on-key key-slideshow]
        [stop-when empty?])))) 

; key-slideshow : Slideshow KeyEvent -> Slideshow
; Advances a slideshow, ignoring the key pressed

(check-expect
 (key-slideshow SLIDESHOW-1-DONE " ")
 SLIDESHOW-2)

(define (key-slideshow ss ke)
  (advance-slideshow ss)) 

