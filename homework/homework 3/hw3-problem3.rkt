;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw3-problem3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Recently a new website (https://neal.fun/design-the-next-iphone/) was made
; to allow you to design the next iPhone by mixing & matching features.
; Let's make a simple version of this as a World program :)

; TODO 1/3: Design the data PhoneModel that allows you to represent a set
;           of (at least) four enumerated models. You are welcome to be
;           creative, but an example set of options could be "Small",
;           "Regular", "Max", or "Fold"

; A PhoneModel is one of:
; - "Small"
; - "Regular"
; - "Max"
; - "Fold"


; Takes a preferred function of the iPhone.

(define PHONEMODEL-SMALL "Small")
(define PHONEMODEL-REGULAR "Regular")
(define PHONEMODEL-MAX "Max")
(define PHONEMODEL-FOLD "Fold")

(define (PhoneModel?-temp pm)
  (...
   (cond
    [(string=? pm "Regular") ...]
    [(string=? pm "Small") ...]
    [(string=? pm "Max") ...]
    [(string=? pm "Fold")] ...))) 



; TODO 2/3: Now design the data PhoneCompany that allows you to represent a set
;           of (at least) three enumerated company names, such as "Apple",
;           "Google", "Amazon".


; A PhoneCompany is one of:
; - "Apple"
; - "Google"
; - "Amazon"


; Represents a preferred phonecompany of the iPhone.

(define PHONECOMPANY-APPLE "Apple")
(define PHONECOMPANY-GOOGLE "Google")
(define PHONECOMPANY-AMAZON "Amazon")


(define (PhoneCompany?-temp pm)
  (...
   (cond
    [(string=? pm "Apple") ...]
    [(string=? pm "Google") ...]
    [(string=? pm "Amazon") ...])))

; TODO 3/3: Now design a World program that allows someone to interactively see all
;           combinations of models and companies.
;
;           Notes:
;           - You will need to design data to represent the current combination of
;             model/company, which should be a structure. Your program can accept
;             the starting value and should return the last when the window is closed.
;           - When the "m" keyboard key is pressed, you should proceed to the next
;             model (e.g., "Small" -> "Regular" -> "Max" -> "Fold" -> "Small"...);
;             the "c" key should similarly work for companies.
;           - Your drawing function should overlay some visualization of the company
;             (e.g., could be just the text, or a pretty logo) on top of a
;             visualization of the model (e.g., could differ in size, camera, ...).
;           - Be sure to follow the templates, which will guide you as to when to
;             create data-specific helper functions!!

(define-struct phone-combination [PhoneModel PhoneCompany]) 

; A Define-struct phone is a (make-phone PhoneModel PhoneCompany)
; Represents a phone with a combined model and company.

(define PHONE-COMBINATION-1 (make-phone-combination PHONEMODEL-SMALL PHONECOMPANY-APPLE))
(define PHONE-COMBINATION-2 (make-phone-combination PHONEMODEL-FOLD PHONECOMPANY-AMAZON))
(define PHONE-COMBINATION-3 (make-phone-combination PHONEMODEL-REGULAR PHONECOMPANY-GOOGLE))
(define PHONE-COMBINATION-4 (make-phone-combination PHONEMODEL-MAX PHONECOMPANY-APPLE))



; Phone-temp phone: Phone-model & Phone-Company -> 
(define (phone-temp phone)
     (... (PhoneModel-temp (phone-phone-model phone)) (... (PhoneCompany-temp (phone-phone-company phone) ...))))



; Wishlist is:

; phone-combination-run : MP -> MP
; Animates a phone
 
               
(define (phone-run initial-phone-combination)
  (big-bang initial-phone-combination
    [to-draw draw-phone-combination]
    [on-key change-phone-combination])) ; MP KeyEvent -> MP


; draw-phone-combination: PhoneCompany/PhoneModel -> Image
; visualizes Phone 

(check-expect (draw-phone-combination PHONE-COMBINATION-1) (overlay (text PHONECOMPANY-APPLE 100 "gray")
                                                                          (rectangle 100 200 "solid" "gray")
                                                                          (square 500 "solid" "red")))
;(check-expect (draw-phone-combination (make-phone-combination PHONEMODEL-SMALL PHONECOMPANY-APPLE) (rectangle 1 2 "solid" "gray")) 
;(check-expect (draw-phone-combination (make-phone-combination PHONEMODEL-SMALL PHONECOMPANY-APPLE) (rectangle 1 2 "solid" "gray")) 
 
(define (draw-phone-combination pc)
  (overlay
    (draw-phone-model (phone-combination-PhoneModel pc))
    (draw-phone-company (phone-combination-PhoneCompany pc)) (square 500 "solid" "red")))


(define (draw-phone-company x)
    (text x 100 "gray"))

(define (draw-phone-model x)
  (cond
    [(string=? PHONEMODEL-SMALL x) (rectangle 100 200 "solid" "gray")]
    [(string=? PHONEMODEL-REGULAR x) (rectangle 200 400 "solid" "gray")]
    [(string=? PHONEMODEL-MAX x) (rectangle 100 200 "solid" "gray")]
    [(string=? PHONEMODEL-FOLD x) (rectangle 100 200 "solid" "gray")]
    [(string=? PHONECOMPANY-APPLE (phone-combination-PhoneModel x)) (text "APPLE" 100 "gray")]
    [(string=? PHONECOMPANY-GOOGLE (phone-combination-PhoneModel x)) (text "GOOGLE" 100 "gray")]
    [(string=? PHONECOMPANY-AMAZON (phone-combination-PhoneModel x)) (text "AMAZON" 100 "gray")] 
    )) 
   

; change-phone: phone-combination KeyEvent -> phone-combination

(check-expect (change-small "m") PHONEMODEL-REGULAR)

(define (change-phone-combination pc ke)
 (cond [(key=? ke "m") (change-regular ke)]  
        [(string=? (phone-combination-PhoneModel pc) PHONEMODEL-REGULAR) (change-small ke)]
        [(string=? (phone-combination-PhoneModel pc) PHONEMODEL-FOLD) (change-max ke)]))
       
; change-small : KeyEvent -> PhoneCombination
; When key "m" is pressed, it changes the small phone model into the regular phone model.

(check-expect (change-small "m") PHONEMODEL-REGULAR)

(define (change-small ke)
  (cond
    [(key=? ke "m") PHONEMODEL-REGULAR]
    [else PHONEMODEL-SMALL]))

; change-regular : KeyEvent -> PhoneCombination
; When key "m" is pressed, it changes the regular phone model into the max phone model.

(check-expect (change-regular "m") PHONEMODEL-MAX)

(define (change-regular ke)
  (cond
    [(key=? ke "m") PHONEMODEL-MAX]
    [else PHONEMODEL-REGULAR]))

; change-small : KeyEvent -> PhoneCombination
; When key "m" is pressed, it changes the fold phone model into the small phone model.

(check-expect (change-fold "m") PHONEMODEL-SMALL)

(define (change-fold ke)
  (cond
    [(key=? ke "m") PHONEMODEL-SMALL]
    [else PHONEMODEL-FOLD]))

; change-small : KeyEvent -> PhoneCombination
; When key "m" is pressed, it changes the max phone model into the fold phone model.

(check-expect (change-max "m") PHONEMODEL-FOLD)

(define (change-max ke)
  (cond
    [(key=? ke "m") PHONEMODEL-FOLD]
    [else PHONEMODEL-MAX]))


    





  
