;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab4-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO 1/2: Design the data necessary to represent a book, which can
;           either be physical or electronic. All books have a title
;           and author. Physical books are either paperback or hardcover,
;           and have some number of pages. Electronic (e-books) have a
;           format (pdf, epub, txt) and a source URL.
;
;           We've gotten you started with the design of a PhysicalBook
;           and EFormat :) So your task is an EBook and a Book!


(define-struct physbook [title author paperback? pages])

; A PhysicalBook is a (make-physbook String String Boolean PosInteger)
; Interpretation: a physical book
; - title is the title of the book
; - author is the author of the book
; - paperback? is #true if paperback, #false if hardcover
; - pages is the number of pages in the book

(define
  PHYSBOOK-DUNE
  (make-physbook "Dune" "Frank Herbert" #true 896))

(define
  PHYSBOOK-JUSTICE
  (make-physbook
   "Doing Justice: A Prosecutor's Thoughts on Crime, Punishment, and the Rule of Law"
   "Preet Bharara"
   #false
   368))

(define (physbook-temp pb)
  (... (physbook-title pb) ...
       (physbook-author pb) ...
       (physbook-paperback? pb) ...
       (physbook-pages pb) ...))

; An EFormat is one of:
; - "pdf"
; - "epub"
; - "txt"
; Interpretation: e-book formats

(define EFORMAT-PDF "pdf")
(define EFORMAT-EPUB "epub")
(define EFORMAT-TXT "txt")

(define (eformat-temp ef)
  (...
   (cond
     [(string=? ef EFORMAT-PDF) ...]
     [(string=? ef EFORMAT-EPUB) ...]
     [(string=? ef EFORMAT-TXT) ...])))

(define-struct ebook [title author eformat source-url pages])
                
; An EBook is a (make-ebook [title author eformat source-url pages])
; Interpretation: an electronic book
; - title is the title of the book
; - author is the author of the book
; - eformat is the e-book format
; - source-url is the url of the book
; - pages is the number of pages in the book


(define
  EBOOK-DUNE
  (make-ebook "Dune" "Frank Herbert" EFORMAT-PDF "google.com/Dune" 896))

(define
  EBOOK-JUSTICE
  (make-ebook "Doing Justice: A Prosecutor's Thoughts on Crime, Punishment, and the Rule of Law"
              "Preet Bharara"
              EFORMAT-TXT
              "google.com/justice"
              368))

(define (ebook-temp eb)
  (... (ebook-title eb) ...
       (ebook-author eb) ...
       (eformat-temp (ebook-format eb)
                     (ebook-source-url eb)
                     (ebook-pages eb) ...)))

                    
; A Book is one of:
; PhysBook
; EBook
; Interpretation: a physical or electronic book

(define (book b)
  (cond [(physbook? b) b]
        [(ebook? b) b]))

(define BOOK-DUNE (book EBOOK-DUNE))
(define BOOK-EBOOK (book PHYSBOOK-DUNE))

(define (book-temp b)
  (...
   (cond [(physbook? b)] (physbook-temp b) ...
         [(ebook? b)] (ebook-temp b) ...)))
   
  





; TODO 2/2: Now design the function where-to-find that accepts a book
;           and returns where you can find it: physical books are either
;           in the "hardcover section" or "paperback section", whereas
;           electronic books are found at their URL.

; Where-to-find : Book -> String
; gives the source of the book 

(check-expect (where-to-find EBOOK-DUNE) "google.com/Dune")
(check-expect (where-to-find PHYSBOOK-DUNE) "paperback section") 

(define (where-to-find b)
   (cond [(physbook? b) (if (physbook-paperback? b)
                             "paperback section"
                             "hardcover section")]
   [(ebook? b) (ebook-source-url b)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Consider the following data definitions...

; A Genre is one of:
; - "comedy"
; - "drama"
; - "action"
; - "education"
; Interpretation: genre for a video

(define GENRE-COMEDY "comedy")
(define GENRE-DRAMA "drama")
(define GENRE-ACTION "action")
(define GENRE-EDUCATION "education")

; Genre -> ?

;(define (genre-temp g)
;  (...
; (cond
; [(string=? g GENRE-COMEDY) ...]
;[(string=? g GENRE-DRAMA) ...]
;[(string=? g GENRE-ACTION) ...]
;[(string=? g GENRE-EDUCATION) ...])))


(define-struct video [name duration hd? genre next])

; A StreamingQueue is one of:
; - #false
; - (make-video String PosInteger Boolean Genre StreamingQueue)
; Interpretation: either an empty queue (#false) or a video
; with a name, duration in minutes, whether it's available in HD,
; and its genre.

(define QUEUE-EMPTY #false)

(define QUEUE-CRASH
  (make-video "Crash Course Organic Chemistry #5"
              14 #true GENRE-EDUCATION
              QUEUE-EMPTY))

(define QUEUE-OLIVER
  (make-video
   "Prisons & Jails: Last Week Tonight with John Oliver"
   18 #true GENRE-COMEDY
   QUEUE-CRASH))

(define QUEUE-DUEL
  (make-video
   "Duel" 2 #false GENRE-ACTION QUEUE-OLIVER))

(define QUEUE-STORM
  (make-video
   "Tim Minchin's Storm the Animated Movie"
   11 #false GENRE-DRAMA
   QUEUE-DUEL))

; StreamingQueue -> ?


; only-15min : StreamingQueue -> Streaming Queue
; Purpose: Returns the videos from a queue of viddeos that are 15 minutes or less.

(check-expect (only-15min QUEUE-EMPTY) QUEUE-EMPTY)
(check-expect (only-15min QUEUE-CRASH) QUEUE-CRASH)
(check-expect (only-15min QUEUE-STORM) (make-video
                                        "Tim Minchin's Storm the Animated Movie"
                                        11 #false
                                        GENRE-DRAMA
                                        (make-video
                                         "Duel" 2 #false
                                         GENRE-ACTION
                                         QUEUE-CRASH)))

(define (only-15min sq)
  (cond
    [ (boolean? sq) QUEUE-EMPTY]
    [ (video? sq)
      (if (<= (video-duration sq) 15)
          (make-video 
           (video-name sq) 
           (video-duration sq) 
           (video-hd? sq)
           (video-genre sq)
           (only-15min (video-next sq)))
          (only-15min (video-next sq)))])) 
      
  


; TODO 1/1: Design the following functions. For clarity, we've provided
;           (commented out) tests for each. Don't forget to follow the
;           templates!!!
;
;           Note: for full credit, you only need to submit your attempt
;           for ONE function; however, we recommend trying them all! :)


; Design the function good-for-friday? that determines if a streaming queue
; contains any content that is comedy or action.


(check-expect (good-for-friday? QUEUE-EMPTY) #false)
(check-expect (good-for-friday? QUEUE-STORM) #true)

; good-for-friday? : GENRE -> Boolean
; Determines whether the streaming queue contains content that is comedy or action. 

(define (good-for-friday? sq)
  (cond
    [(boolean? sq) #f]
    [(video? sq)
     (if (or (string=? GENRE-COMEDY (video-genre sq))
             (string=? GENRE-COMEDY (video-genre sq)))
         #t
         (good-for-friday? (video-next sq)))]))
          


; Design the function duration that calculates the total number of minutes
; of content in a streaming queue. For example, an empty queue has 0 minutes
; of content, whereas QUEUE-STORM has 45 minutes (14 + 18 + 2 + 11).

#|
(check-expect (duration QUEUE-EMPTY) 0)
(check-expect (duration QUEUE-STORM) 45)
|#



; Design the function upgrade that takes a streaming queue and produces a
; new queue containing HD versions of all the videos in the original queue.

#|
(check-expect (upgrade QUEUE-EMPTY) QUEUE-EMPTY)

(check-expect
 (upgrade QUEUE-STORM)
 (make-video
  "Tim Minchin's Storm the Animated Movie"
  11 #true GENRE-DRAMA
  (make-video
   "Duel" 2 #true GENRE-ACTION
   QUEUE-OLIVER)))
|#

