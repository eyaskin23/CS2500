;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |list of posts|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct post [user body])

; A Post is a (make-post String String)
; Interpretation: Represents the username and text of a post

(define POST-DECORUM (make-post "TheMod" "Just please be respectful."))
(define POST-DUMB (make-post "silly_bear" "sounds dumb lol"))
(define POST-BANNED (make-post "TheMod" "The above user has been banned. "))
(define POST-CENSORSHIP (make-post "free_speech" "STOP CENSORING ME! lol"))

(define (post-temp p)
  (... (post-user p) ...
       (post-body p) ...))

; A  ListofPosts (LoP) is one of:
; '()
; - (cons Post LoP)
; Interpretation: a list of posts

(define LOP-0 '())
(define LOP-DECORUM (cons POST-DUMB (cons POST-BANNED LOP-0)))
(define LOP-CENSORSHIP (cons POST-SPAM LOP-0))

(define (lop-temp lop)
  (...
   (cond
     [(empty? lop) ...]
     [(cons? lop) ...
      (post-temp (first lop)) ...
      (lop-temp (rest lop)) ...])))

(define-struct thread [title pinned? post replies])

; A Thread is a (make-thread String Boolean Post LoP)
; Interpretation: Represents the name, whether or not it is a pinned thread,
; the initial post, and replies of a thread

(define THREAD-DECORUM
  (make-thread "Message Bored Decorum" #true POST-DECORUM LOP-DECORUM))

(define THREAD-CENSORSHIP
  (make-thread "CENSORS!!!" #false POST-CENSORSHIP LOP-CENSORSHIP))

(define (thread-temp t)
  (... (thread-title t) ...
       (thread-pinned? t) ...
       (post-temp (thread-post t)) ...
       (lop-temp (thread-replies t)) ...))

(define (lot-temp lot)
  (...
   (cond
     [(empty? lot)...]
     [(cons? lot) ...]
     (first los) ...
     (lot-temp (rest lot) ...))))

(define (mb-temp mb)
  (... (mb-name mb) ...
       (mb-threads mb) ...)) 

      


     