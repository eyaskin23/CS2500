;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname P1-list-abst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Last class, we designed an abstract function do-to-all, which applied another
; function, passed in as a parameter, to every element of a list. Here's the signature we
; threw up then:

; do-to-all : ListOfNumbers ??? -> ListOfNumbers

; What should ??? be? Well, when we created the function, we were abstracting the two
; similar functions sqr-of-all and srqt-of-all. Those functions wanted to apply sqr
; or sqrt to each number in the list; in other words, do-to-all was being passed a function
; that would take a number, and process it and return a number. Here's a first pass at
; a better signature:

; do-to-all : ListOfNumbers Function-that-accepts-a-Number-and-returns-a-Number -> ListOfNumbers

; Is there a better notation? How about borrowing from the style of the entire signature itself?

; do-to-all : ListOfNumbers [Number -> Number] -> ListOfNumbers
;<QUESTION>: why the square brackets??

; Better. But is this the best data definition? Let's take a look at the function:

(define (do-to-all lon f)
  (cond
    [(empty? lon) '()]
    [(cons? lon)
     (cons
      (f (first lon))
      (do-to-all (rest lon) f))]))

; Is there anything in this function that requires that lon is a ListOfNumbers? Well,
; f does. However, that comes from outside do-to-all. Whatever f takes as an argument,
; is what the elements in lon should be.
; What about the return value? Does it have to be a ListofNumbers? In fact, does it have
; to be the same kind of list as the input list?
; If not, how do we express what it must be?
;<BRAINSTORM><SCROLL>






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A DIGRESSION OF CONVENIENCE

; Before we can resolve the bigger problem at hand, we need a more general way
; to talk about, and refer to, various types of lists (i.e., lists containing
; different types of things). Instead of referring to ListofNumbers and ListofPositions,
; Let's use the references  [List-of Number] and [List-of Position], or more generally,
; [List-of X], where X is some particular type. But what is a [List-of X]?
; Let's look at two of our past list data definitions:
; We already noticed that all of our ListofSomething's are 90.7% similar:

; A ListOfNumber is one of:
; - '()
; - (cons Number ListOfNumber)
 
; A ListOfPosition is one of:
; - '()
; - (cons Position ListOfPosition)

; The only differences between these is the type of the indiviual elements of the list.
; Let's abstract these data definitions:

; A [List-of X] is one of:
; - '()
; - (cons X [List-of X])

; We can then "invoke" this abstract data definition, by merely referring to
; a [List-of Number], or a [List-of String], or a [List-of-Position], or any other type!
; (Notice we use brackets to notate we are using an abstracted data definition.]

; We now no longer need to separate data design for every kind of list.
; No more data definition, interpretation, examples, or templates--yay!!
; (...Unless we explicitly ask you to, in which case... yeah.
;  ...Or it's useful, like examples to reuse in tests, etc..
;  ...And we will still be constantly referring back to list templates...
;  So, maybe delay throwing all that stuff away for a bit??)

; Note: this feature doesn't take effect until future assignments, so you can't use
; it for the current assignments :-(

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Note the difference between [List-of X] and ...

; A BadList is one of
; - '()
; - (cons Any BadList)

; A [List-of X] can only contain values of type X, whereas a BadList can mix-and-match
; different values. This is rarely what we want, and so, would be usually wrong (but not always...).
; (Note that BadList here is would be the same as [List-of Any].)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; As another example, consider a non-empty list...

; A [NEList-of X] is one of:
; - (cons X '())
; - (cons X [NEList-of X])

; Here are some examples of a non-empty list of numbers:

(define NELON-1 (cons 1 '()))
(define NELON-2 (cons 2 NELON-1))

; What about the template?

(define (nelon-temp nelon)
  (...
   (cond
     [(empty? (rest nelon))
      (... (first nelon) ...)]
     [(cons? (rest nelon))
      (...
       (first nelon) ...
       (nelon-temp (rest nelon)) ...)])))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Going back to perfecting the signature for do-to-all :
; How about:

; do-to-all : [List-of Any] [Any -> Any] -> [List-of Any]
;<DISCUSS>






; Better version:

; do-to-all : [List-of X] [X -> Y] -> [List-of Y]

; What are some issues with this?
;<DISCUSS>






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; We also need to indicate that X and Y are data definitions!
; When you go to use do-to-all, you need to have a particular X and Y in mind.

; Best version:

; do-to-all : (X Y) [List-of X] [X -> Y] -> [List-of Y]








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FILTER

; Let's look at two other list-processing function abstractions
; ("list abstractions" for short).In past lectures, we've had occasion to:
;   (1) Filter a list (e.g., removing moons that are not visible)
;   (2) Collapse a list (summing numbers).

; Let's start with filtering strings...

; For old time's sake:

; A [List-of String] (LoS) is one of
; - '()
; - (cons String [List-of String])
; Interpretation: a list of strings!

(define STR-S "msg")
(define STR-SP "dear msg")
(define STR-L "really really long message")
(define STR-LP "dear person this is a really really long message that is polite")
 
(define LOS-0 '())
(define LOS-1 (cons STR-S LOS-0))
(define LOS-2 (cons STR-SP LOS-1))
(define LOS-3 (cons STR-L LOS-2))
(define LOS-4 (cons STR-LP LOS-3))

(define (los-temp los)
  (...
   (cond [(empty? los) ...]
         [(cons? los) (... (first los) ...
                           (los-temp (rest los)) ...)])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Group A:
;   Design short-msgs that accepts a list of strings and returns just those that are
;   shorter than 14 characters;
;
; Group B:
;   Design polite-msgs that accepts a list of strings and returns just those that
;   start with "dear".
;<DO NOW><SCROLL>








; short-msgs : [List-of String] -> [List-of String]
; Keeps just the strings that are < 14 characters
 
(define SHORT 14)
 
(check-expect (short-msgs LOS-0) LOS-0)
(check-expect (short-msgs LOS-1) LOS-1)
(check-expect (short-msgs LOS-2) LOS-2)
(check-expect (short-msgs LOS-3) LOS-2)
(check-expect (short-msgs LOS-4) LOS-2)
 
(define (short-msgs los)
  ; Start w/template:
  #;
  (define (los-temp los)
    (cond [(empty? los)'()]
          [(cons? los) (if (< (string-length (first los)) SHORT)
                           (cons (first los)(short-msgs (rest los))
                                 (short-msgs (rest los)) ...))]))
;<DO NOW><SCROLL>







  
(cond
  [(empty? los) '()]
  [(cons? los)
   (if (< (string-length (first los)) SHORT)
       (cons (first los) (short-msgs (rest los)))
       (short-msgs (rest los)))]))
 
; polite-msgs : [List-of String] -> [List-of String]
; Keeps just the strings that start with "dear"
 
(define POLITE "dear")
 
(check-expect (polite-msgs LOS-0) LOS-0)
(check-expect (polite-msgs LOS-1) LOS-0)
(check-expect (polite-msgs LOS-2) (cons STR-SP '()))
(check-expect (polite-msgs LOS-3) (cons STR-SP '()))
(check-expect (polite-msgs LOS-4) (cons STR-LP
                                        (cons STR-SP '())))
 
(define (polite-temp los)
  ; Start w/template:
  #;
  (define (los-temp los)
    (...
     (cond [(empty? los) '()]
           [(cons? los) (if (string=? (substring (first los) 0 4) "dear")
                            (cons (first los) (polite-msgs (rest los)))
                            (polite-msgs (rest los)) ...)])))
  ;<DO NOW><SCROLL>







  
  (cond
    [(empty? los) '()]
    [(cons? los)
     (if (and (>= (string-length (first los)) (string-length POLITE))
              (string=? (substring (first los) 0 (string-length POLITE)) POLITE))
         (cons (first los) (polite-msgs (rest los)))
         (polite-msgs (rest los)))]))

; Recall the steps to abstraction: First highlight the differences - in this case,
; it's only the condition for the if, which is easier to see with helper functions...

(define (short-msgs/v2 los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     (if (short? (first los))
         (cons (first los) (short-msgs (rest los)))
         (short-msgs (rest los)))]))

; short? : String -> Boolean
; Determines if a string is short
 
(check-expect (short? STR-SP) #true)
(check-expect (short? STR-L) #false)
 
(define (short? s)
  (< (string-length s) SHORT))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (polite-msgs los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     (if (polite? (first los))
         (cons (first los) (polite-msgs (rest los)))
         (polite-msgs (rest los)))]))

; polite? : String -> Boolean
; Determines if a string starts with "dear"
 
(check-expect (polite? STR-S) #false)
(check-expect (polite? STR-LP) #true)
 
(define (polite? s)
  (and (>= (string-length s) (string-length POLITE))
       (string=? (substring s 0 (string-length POLITE)) POLITE)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 2: parameterize the difference(s) as parameters

; So what would our abstracted function look like? Let's call it keep-if.

; keep-if : (X) [List-of X] [X -> Boolean] -> [List-of X]


; Keeps just the strings that the function returns true for
 
(check-expect (keep-if LOS-4 short?)
              (cons STR-SP
                    (cons STR-S '())))
 
(check-expect (keep-if LOS-4 polite?)
              (cons STR-LP
                    (cons STR-SP '())))
 
(define (keep-if lox p?)
  (cond
    [(empty? lox) '()]
    [(cons? lox)
     (if (p? (first lox))
         (cons (first lox) (keep-if (rest lox) p?))
         (keep-if (rest lox) p?))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Step 3: re-write our original functions to use the abstracted one.
; Half the class do short-msgs, the other half do polite-msgs.
;<DO NOW><SCROLL>









; Note: this is just modified parts--the rest of the design--sig, purpose,
; tests remain exactly as-is

;(define (short-msgs los)
 ; (keep-if los short?))

;(define (polite-msgs los)
 ; (keep-if los polite?))


; I would claim this is more readable, more reusable, and much shorter!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; COLLAPSE

; One more exercise in designing a list abstraction:

; A [List-of Number] is one of
; - '()
; - (cons Number [List-of Number])
; Interpretation: ...
 
(define LON-0 '())
(define LON-1 (cons 2 LON-0))
(define LON-2 (cons 3 LON-1))
(define LON-3 (cons 4 LON-2))
 
(define (lon-temp lon)
  (...
   (cond [(empty? lon) ...]
         [(cons? lon) (... (first lon) ...
                           (lon-temp (rest lon)) ...)])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise:
; Group A:
;   Design find-sum that accepts a list of numbers and computes the sum.
;
; Group B:
;   Design find-product that accepts a list of numbers and computes the product.
 
; find-sum : [List-of Number] -> Number
; Finds the sum of the numbers in the list
 
(check-expect (find-sum LON-0) 0)
(check-expect (find-sum LON-3) 9)
 
;(define (find-sum lon)
  ;<DO NOW>

 ; )
 
; find-product : [List-of Number] -> Number
; Finds the product of the numbers in the list
 
;(check-expect (find-product LON-0) 1)
;(check-expect (find-product LON-3) 24)
 
;(define (find-product lon)
  ;<DO NOW>

  ;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 1: What are the differences?
;<DISCUSS>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 2: Parameterize the differences
;   (Let's call this list abstraction: collapse

; collapse : ??? <DO NOW><SCROLL>
; Collapses a list given a base-case and pairwise function







; collapse : (X) [List-of X] X [X X -> X] -> X
 
(check-expect (collapse LON-0 0 +) 0)
(check-expect (collapse LON-3 0 +) 9)
(check-expect (collapse LON-0 1 *) 1)
(check-expect (collapse LON-3 1 *) 24)
 
(define (collapse lon base f)
  ;<DO NOW> Start from what?







  
  (cond
    [(empty? lon) base]
    [(cons? lon)
     (f
      (first lon)
      (collapse (rest lon) base f))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 3: Reimplement originals in terms of new abstraction

(define (find-sum lon)
  (collapse lon 0 +))
 
(define (find-product lon)
  (collapse lon 1 *))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Are we fully utilizing the power of collapse ?
; Consider that we can actually write the following use of collapse

; total-length : [List-of String] -> Number
; Returns the total length of all strings
 
(check-expect (total-length '()) 0)
(check-expect (total-length (cons "hi" (cons "there" '()))) 7)
 
(define (total-length los)
  (collapse los 0 add-string-to-sum))
 
; add-string-to-sum : String Number -> Number
; Adds the length of the String to the passed-in number
 
(check-expect (add-string-to-sum "hi" 0) 2)
(check-expect (add-string-to-sum "there" 2) 7)
 
(define (add-string-to-sum str num)
  (+ (string-length str) num))

; What does this imply about our signature?
; It was too restrictive - so our final signature...

; collapse : (X Y) [List-of X] Y [X Y -> Y] -> Y
