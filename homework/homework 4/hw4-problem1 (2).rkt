;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |hw4-problem1 (2)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Let's think about what goes into designing notifications for a mobile device.
;
; Consider the following data definitions...


(define-struct info [app message])

; An InfoMessage is a (make-info String String)
; Interpretation: a message from an app


(define INFO1 (make-info "Instagram" "You have 1 new message."))
(define INFO2 (make-info "Snapchat" "You have 1 new snap."))
(define INFO3 (make-info "Facebook" "You have 1 new follower."))

(define (info-temp msg)
  (.... (info-app msg) ...
        (info-message msg) ...))
  

(define-struct badge [app num])

; A Badge is a (make-badge String Nat)
; Interpretation: a numeric indicator for an app

(define BADGE1 (make-badge "Instagram" 1))
(define BADGE2 (make-badge "Snapchat" 3))
(define BADGE3 (make-badge "Facebook" 7))

(define (badge-temp b)
  (... (badge-app b) ...
       (badge-num b) ...))
       

(define-struct confirm [app yestxt notxt])

; A Confirmation is a (make-confirm String String String)
; Interpretation: a yes/no question from an app, with
; associated text to display for each option

(define CONFIRM1 (make-confirm "Instagram" "Confirm follower request" "Decline follower request"))
(define CONFIRM2 (make-confirm "Snapchat" "Add friend request" "Decline friend request"))


(define (confirm-temp q)
  (... (confirm-app q) ...
       (confirm-yestxt q) ...
       (confirm-notxt q) ...))



; TODO 1/2: Complete the design recipe for InfoMessage,
;           Badge, and Confirmation. You should come up
;           with reasonable examples, but are welcome
;           to be creative :)





; TODO 2/2: Design the data type Notification, which represents
;           a single notification that could be of any of the
;           types described above.

; A Notification is one of:
; - "InfoMessage"
; - "Confirmation"
; - "Badge"
; Interpretation: A message from one of the apps.

(define NOTIFICATION1 INFO1)
(define NOTIFICATION2 BADGE3)
(define NOTIFICATION3 CONFIRM1)

;(define (notification-temp n)
 ; (...
 ;  (cond [(info? n) ... (info-temp n) ... ]
    ;     [(badge? n) ... (badge-temp n) ... ]
      ;   [(confirm? n) ... (confirm-temp n) ... ])))
         
         
(define (notification-temp n)
 (...
  (cond [(make-notification (info? n) ... (info-temp n)...)]
        [(badge? n) ... (badge-temp n)...]
        [(confirm? n) ... (confirm-temp n)...])))
        
         

  




