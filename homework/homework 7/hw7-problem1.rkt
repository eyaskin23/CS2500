;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hw7-problem1_1_2_8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This problem asks you to design several functions that employ the
; following data definitions. The functions that you design *must* use
; list abstraction(s) when appropriate; you MAY NOT use recursion: doing
; so will lead you to get no code credit for the function :(
;
; NOTE #1: Part of the credit for each problem will be based on the choice
; of list abstractions, so make sure that they are a good match for the
; problem.
;
; NOTE #2: For certain problems, you will have to design helper functions
; that do not use list abstractions. You should follow the full design
; recipe (including appropriate use of templates) for all problems. Be sure
; to do this, even if it feels a bit tedious - listen to your templates!!
;
; Data Definitions (do not modify these)


; A Weekday is one of:
; - "Monday"
; - "Tuesday"
; - "Wednesday"
; - "Thursday"
; - "Friday"
; Interpretation: a day that excludes the weekend

(define WEEKDAY-M "Monday")
(define WEEKDAY-T "Tuesday")
(define WEEKDAY-W "Wednesday")
(define WEEKDAY-R "Thursday")
(define WEEKDAY-F "Friday")

(define (weekday-temp w)
  (...
   (cond
     [(string=? w WEEKDAY-M) ...]
     [(string=? w WEEKDAY-T) ...]
     [(string=? w WEEKDAY-W) ...]
     [(string=? w WEEKDAY-R) ...]
     [(string=? w WEEKDAY-F) ...])))


(define-struct meeting [day bname rnum hstart mstart duration])

; A ClassMeeting is a (make-meeting Weekday String String PosInt[8, 18] NonNegInt[0, 59] PosInt)
; Interpretation: when a class is scheduled to meet weekly
; - day: which day of the week
; - bname: name of the building
; - rnum: room number
; - hstart: starting hour (24hr)
; - mstart: starting minute
; - duration: length of the class (in minutes)

(define CM-FUNDIES-M (make-meeting WEEKDAY-M "WVH" "210A" 10 30 65))
(define CM-FUNDIES-W (make-meeting WEEKDAY-W "WVH" "210A" 10 30 65))
(define CM-FUNDIES-R (make-meeting WEEKDAY-R "WVH" "210A" 10 30 65))
;
(define CM-FUNDIES-LAB (make-meeting WEEKDAY-T "WVH" "212" 8 0 100)) 
;
(define CM-DISCRETE-T (make-meeting WEEKDAY-T "ISEC" "102" 13 35 100))
(define CM-DISCRETE-F (make-meeting WEEKDAY-F "ISEC" "102" 13 35 100))
;
(define CM-DISCRETE-SEM (make-meeting WEEKDAY-W "Hastings" "110" 16 35 65))
;
(define CM-CREATURES-T (make-meeting WEEKDAY-T "Forbidden Forest" "Hut" 13 0 200))
(define CM-POTIONS-R (make-meeting WEEKDAY-R "Hogwarts" "Dungeon" 13 0 200))

(define (classmeeting-temp cm)
  (... (weekday-temp (meeting-day cm)) ...
       (meeting-bname cm) ...
       (meeting-rnum cm) ...
       (meeting-hstart cm) ...
       (meeting-mstart cm) ...
       (meeting-duration cm) ...)) 


(define-struct course [prefix num name prof meetings])

; A Course is a (make-course String String String String [List-of ClassMeeting])
; Interpretation: a weekly class
; - prefix: the course prefix
; - num: the course number
; - name: the course name
; - prof: name of the professor
; - meetings: weekly meeting times

(define COURSE-EASY-A
  (make-course "SCHED" "101" "Easy A" "Lazy"
               '()))

(define COURSE-FUNDIES-LECTURE
  (make-course "CS" "2500" "Fundies" "Howdy"
               (list CM-FUNDIES-M CM-FUNDIES-W CM-FUNDIES-R))) 

(define COURSE-FUNDIES-LAB
  (make-course "CS" "2501" "Fundies Lab" "Awesome TAs"
               (list CM-FUNDIES-LAB)))

(define COURSE-DISCRETE-LECTURE
  (make-course "CS" "1800" "Discrete Structures" "Dr Strange"
               (list CM-DISCRETE-T CM-DISCRETE-F)))

(define COURSE-DISCRETE-SEM
  (make-course "CS" "1802" "Seminar for CS 1800" "Park"
               (list CM-DISCRETE-SEM)))

(define COURSE-CREATURES
  (make-course "HPTR" "2000" "Care of Magical Creatures" "Hagrid"
               (list CM-CREATURES-T)))

(define COURSE-POTIONS
  (make-course "HPTR" "2650" "Potions" "Snape"
               (list CM-POTIONS-R)))

(define (course-temp c)
  (... (course-prefix c) ...
       (course-num c) ...
       (course-name c) ...
       (course-prof c) ...
       (locm-temp (course-meetings c)) ...))


; A CourseSchedule is a [List-of Course]
; Interpretation: a list of weekly courses!

(define SCHEDULE-OOPS '())

(define SCHEDULE-KHOURY
  (list COURSE-FUNDIES-LECTURE
        COURSE-FUNDIES-LAB
        COURSE-DISCRETE-LECTURE
        COURSE-DISCRETE-SEM))

(define SCHEDULE-MAGIC
  (list COURSE-CREATURES
        COURSE-POTIONS))

(define SCHEDULE-CS+MAGIC
  (list COURSE-FUNDIES-LECTURE
        COURSE-FUNDIES-LAB
        COURSE-CREATURES
        COURSE-POTIONS))


; TODO 1/8: Part of healthy course scheduling is making sure to build in time for
;           food, and so you are to design the function lunch-course that produces
;           a "Lunch" course!
;
;           The function should take in a prefix & number (e.g., "FOOD" "101"),
;           a name & professor (e.g., "Exciting Baking" with "Alderton"), as
;           well as a list of weekdays. The function will then makes sure that
;           déjeuner occurs on all of those days at noon (for one hour) in a
;           single location of your choice (e.g., Hogwarts Great Hall).
;
;           Note: make sure to test your function on at least two sets of inputs!


; lunch-course : String String String String [List-of Weekday] -> Course
; returns a lunch course including the given information that occurs on the given days

(check-expect (lunch-course "LT" "101" "Exciting Baking" "Alderton"
                            (list WEEKDAY-M WEEKDAY-T WEEKDAY-W WEEKDAY-R WEEKDAY-F))
              (make-course "LT" "101" "Exciting Baking" "Alderton" (list
                                                                    (make-meeting WEEKDAY-M
                                                                                  "Hayden Hall" "101"
                                                                                  "12" "0" "60")
                                                                    (make-meeting WEEKDAY-T
                                                                                  "Hayden Hall" "101"
                                                                                  "12" "0" "60")
                                                                    (make-meeting WEEKDAY-W
                                                                                  "Hayden Hall" "101"
                                                                                  "12" "0" "60")
                                                                    (make-meeting WEEKDAY-R
                                                                                  "Hayden Hall" "101"
                                                                                  "12" "0" "60")
                                                                    (make-meeting WEEKDAY-F
                                                                                  "Hayden Hall" "101"
                                                                                  "12" "0" "60"))))

(check-expect (lunch-course "LT" "101" "Exciting Baking" "Alderton" '())
              (make-course "LT" "101" "Exciting Baking" "Alderton" '()))
                                                                       
(define (lunch-course prefix classnum name prof list-of-weekdays)
  (make-course 
   prefix
   classnum
   name
   prof
   (map lunch-every-day list-of-weekdays))) 

; lunch-every-day : Weekday -> ClassMeeting
; creates a meeting for lunch on the given day
(check-expect (lunch-every-day WEEKDAY-M)
              (make-meeting "Monday"
                            "Hayden Hall"
                            "101"
                            "12"
                            "0"
                            "60"))
(check-expect (lunch-every-day WEEKDAY-R)
              (make-meeting "Thursday"
                            "Hayden Hall"
                            "101"
                            "12"
                            "0"
                            "60"))

(define (lunch-every-day m)
  (make-meeting m
                "Hayden Hall"
                "101"
                "12"
                "0"
                "60"))   

; TODO 2/8: Design the function long-weekend? that determines if a
;           course schedule avoids all classes on Mondays & Fridays.
;           In the examples above, this is true of OOPS and MAGIC.
;           Note: make sure to follow all the templates and
;           sufficiently test all your functions!

; long-weekend? CourseSchedule -> Boolean
; Determines if the course schedule avoids all classes on Mondays & Fridays
(check-expect (long-weekend? SCHEDULE-MAGIC) #true)  
(check-expect (long-weekend? SCHEDULE-OOPS) #true)
(check-expect (long-weekend? SCHEDULE-KHOURY) #false)

(define (long-weekend? loc)
  (andmap string-does-not-contain-mf loc))
         
; string-does-not-contain-mf : Course -> Boolean
; Determines if course has any meetings on monday or friday
(check-expect (string-does-not-contain-mf COURSE-FUNDIES-LECTURE) #false)
(check-expect (string-does-not-contain-mf COURSE-FUNDIES-LAB) #true)
(check-expect (string-does-not-contain-mf COURSE-POTIONS) #true)
(check-expect (string-does-not-contain-mf COURSE-CREATURES) #true) 
  
(define (string-does-not-contain-mf c)
  (andmap dont-meet-on-monday-friday (course-meetings c)))

; dont-meet-on-monday-friday : ClassMeeting -> Boolean
; Does the class meet on monday or friday?
(check-expect (dont-meet-on-monday-friday CM-FUNDIES-LAB) #true)
(check-expect (dont-meet-on-monday-friday CM-DISCRETE-T) #true)
(check-expect (dont-meet-on-monday-friday CM-DISCRETE-F) #false)

(define (dont-meet-on-monday-friday cm)
  (not (or (string=? (meeting-day cm) "Monday")
           (string=? (meeting-day cm) "Friday"))))       

; TODO 3/8: Design the function only-khoury that takes a course schedule
;           and produces a new schedule only containing classes that
;           have the prefix "CS", "DS", or "CY". So supplying OOPS and
;           KHOURY would result in unaffected schedules, but MAGIC would
;           result in an empty schedule and CS+MAGIC would result in a
;           schedule with only Fundies :)
;
;           Note: since we didn't include any DS/CY courses in the
;           examples, make may need to create example courses to properly
;           test your helper function(s)! Some course suggestions include
;           DS2000 (Programming with Data) and CY2550 (Foundations of
;           Cybersecurity).

(define COURSE-DS (make-course "DS" "2000" "Programming with Data" "DS Prof"
                               (list CM-CREATURES-T CM-POTIONS-R)))
(define COURSE-CY (make-course "CY" "2550" "Foundations of Cybersecurity" "CY Prof"
                               (list CM-CREATURES-T CM-POTIONS-R)))

(define SCHEDULE-NERD (list COURSE-DS COURSE-CY))
(define SCHEDULE-MAGIC-NERD (list COURSE-CREATURES COURSE-POTIONS COURSE-DS COURSE-CY))

; only-khoury: CourseSchedule -> CourseSchedule
; removes classes with a prefix other than CS, DS, or CY from the schedule

(check-expect (only-khoury SCHEDULE-KHOURY) SCHEDULE-KHOURY)
(check-expect (only-khoury SCHEDULE-MAGIC) '())
(check-expect (only-khoury SCHEDULE-CS+MAGIC)
              (list COURSE-FUNDIES-LECTURE COURSE-FUNDIES-LAB))
(check-expect (only-khoury SCHEDULE-NERD) SCHEDULE-NERD)
(check-expect (only-khoury SCHEDULE-MAGIC-NERD) SCHEDULE-NERD)

(define (only-khoury sched)
  (filter khoury? sched))

; khoury?: Course -> Boolean
; is the class' prefix CS, DS, or CY?

(check-expect (khoury? COURSE-DS) #true)
(check-expect (khoury? COURSE-CREATURES) #false)
(check-expect (khoury? COURSE-POTIONS) #false)
(check-expect (khoury? COURSE-CY) #true) 
              
(define (khoury? course)
  (or (string=? "CS" (course-prefix course))
      (string=? "DS" (course-prefix course))
      (string=? "CY" (course-prefix course))))


; TODO 4/8: Design the function time-in-class that calculates total
;           time spent in class (in minutes each week) for a supplied
;           course schedule. For example, OOPS requires 0 minutes and
;           KHOURY is 560.


; time-in-class : CourseSchedule -> Nat
; Returns the number of minutes in class for the given schedule

(check-expect (time-in-class SCHEDULE-OOPS) 0)
(check-expect (time-in-class SCHEDULE-KHOURY) 560)
(check-expect (time-in-class SCHEDULE-MAGIC) 400)

(define (time-in-class sched)
  (+ (foldr course-time 0 sched)))

; course-time : Course Nat -> Nat
; takes in a course and its starting time and adds the duration
; of the course to the time

(check-expect (course-time COURSE-FUNDIES-LAB 0) 100)
(check-expect (course-time COURSE-CREATURES 0) 200)

(define (course-time course n)
  (+ (foldr meeting-length 0 (course-meetings course)) n))

; meeting-length : ClassMeeting Nat -> Nat
; takes in a meeting and a starting time and adds the duration
; of the meeting to the time

(check-expect (meeting-length CM-FUNDIES-M 0) 65)
(check-expect (meeting-length CM-CREATURES-T 0) 200)
(check-expect (meeting-length CM-POTIONS-R 0) 200)

(define (meeting-length cm n)
  (+ (meeting-duration cm) n))
            

; TODO 5/8: Design the function bring-water? that takes a course schedule
;           and determines if any course has even a single meeting that
;           lasts for longer than two hours. For example, this is true
;           for either of the magic schedules, but none of the others.

; bring-water? : CourseSchedule -> Boolean
; determines if any course has a single meeting lasting more than 120 minutes
(check-expect (bring-water? SCHEDULE-MAGIC) #true) 
(check-expect (bring-water? SCHEDULE-CS+MAGIC) #true)
(check-expect (bring-water? SCHEDULE-KHOURY) #false)

(define (bring-water? cs)
  (ormap longerthan2hours? cs))

; longerthan2hours? : Course -> Boolean
; determines if any course supplied in a schedule lasts more than 120 minutes
(check-expect (longerthan2hours? COURSE-FUNDIES-LAB) #false)
(check-expect (longerthan2hours? COURSE-DISCRETE-LECTURE) #false)
(check-expect (longerthan2hours? COURSE-DISCRETE-SEM) #false)
(check-expect (longerthan2hours? COURSE-CREATURES) #true)
(check-expect (longerthan2hours? COURSE-POTIONS) #true)

(define (longerthan2hours? course)
  (ormap long? (course-meetings course)))

; long? : ClassMeeting -> Boolean
; is the meeting longer than 2 hours? 
(check-expect (long? CM-FUNDIES-M) #f)
(check-expect (long? CM-FUNDIES-LAB) #f)
(check-expect (long? CM-DISCRETE-SEM) #f)
(check-expect (long? CM-CREATURES-T) #t)
(check-expect (long? CM-POTIONS-R) #t)

(define (long? cm)
  (> (meeting-duration cm) 120))

; TODO 6/8: Design the function course->days-abbrev that takes a course
;           and produces a single string that has abbreviations of all
;           days of the week that course meets. For instance, Fundies
;           lecture would produce "MWR", Fundies lab would produce "T",
;           Discrete lecture would be "TF", and the "easy A" class would
;           produce "" (since the lazy prof never wants to meet!).

; course->days-abbrev : Course -> String
; produces an abbreviated version of the days that each course meets
(check-expect (course->days-abbrev COURSE-FUNDIES-LAB) "T")
(check-expect (course->days-abbrev COURSE-DISCRETE-LECTURE) "TF")
(check-expect (course->days-abbrev COURSE-FUNDIES-LECTURE) "MWR")
(check-expect (course->days-abbrev COURSE-EASY-A) "") 

(define (course->days-abbrev c)
  (foldr string-append "" (map day->string (course-meetings c))))

; day->string: ClassMeeting -> String
; produces a string that states one day that the course meets
(check-expect (day->string CM-FUNDIES-M) "M")
(check-expect (day->string CM-FUNDIES-W) "W")
(check-expect (day->string CM-FUNDIES-R) "R")

(define (day->string cm)
  (weekday->string (meeting-day cm)))

; weekday->string : Weekday -> String
; returns the designated letter that represents each day
; given a weekday
(check-expect (weekday->string WEEKDAY-M) "M")
(check-expect (weekday->string WEEKDAY-T) "T")
(check-expect (weekday->string WEEKDAY-W) "W")
(check-expect (weekday->string WEEKDAY-R) "R")
(check-expect (weekday->string WEEKDAY-F) "F")

(define (weekday->string w)
  (cond
    [(string=? w WEEKDAY-M) "M"]
    [(string=? w WEEKDAY-T) "T"]
    [(string=? w WEEKDAY-W) "W"]
    [(string=? w WEEKDAY-R) "R"]
    [(string=? w WEEKDAY-F) "F"])) 
  

; TODO 7/8: Design the functions stack/h and stack/v, to stack a supplied
;           list of images horizontally and vertically, with a bit of buffer
;           between each image (see the GAP we've defined for you). You have
;           been supplied tests for clarity.

(define GAP (square 5 "solid" "white"))

(check-expect
 (stack/h '())
 GAP)

(check-expect
 (stack/h
  (list
   (text "A" 5 "black")
   (text "B" 10 "black")
   (text "C" 50 "black")))
 (beside
  GAP
  (text "A" 5 "black")
  GAP
  (text "B" 10 "black")
  GAP
  (text "C" 50 "black")
  GAP))
 
(check-expect
 (stack/v '())
 GAP)

(check-expect
 (stack/v
  (list
   (text "A" 5 "black")
   (text "B" 10 "black")
   (text "C" 50 "black")))
 (above
  GAP
  (text "A" 5 "black")
  GAP
  (text "B" 10 "black")
  GAP
  (text "C" 50 "black")
  GAP))

; above-base : Image Image -> Image
; places the first image above the second
(check-expect (above-base (text "A" 5 "black") (text "B" 10 "black"))
              (above GAP (text "A" 5 "black") (text "B" 10 "black")))
(check-expect (above-base (text "B" 10 "black") (text "C" 50 "black"))
              (above GAP (text "B" 10 "black") (text "C" 50 "black")))
(define (above-base im1 im2)
  (above GAP im1 im2))

; stack/v : [List-of Images] -> Image
; stacks the images in the given list vertically, with blank space between them
(check-expect
 (stack/v
  (list
   (text "A" 5 "black")
   (text "B" 10 "black")))
 (above
  GAP
  (text "A" 5 "black")
  GAP
  (text "B" 10 "black")
  GAP))
(define (stack/v loi)
  (foldr above-base GAP loi))

; beside-base : Image Image -> Image
; places the first image to the left of the second
(check-expect (beside-base (text "A" 5 "black") (text "B" 10 "black"))
              (beside GAP (text "A" 5 "black") (text "B" 10 "black")))
(check-expect (beside-base (text "B" 10 "black") (text "C" 50 "black"))
              (beside GAP (text "B" 10 "black") (text "C" 50 "black")))

(define (beside-base im1 im2)
  (beside GAP im1 im2))

; stack/h : [List-of Images] -> Image
; stacks the images in the given list horizontally, with blank space between them
(check-expect
 (stack/h
  (list
   (text "A" 5 "black")
   (text "B" 10 "black")))
 (beside
  GAP
  (text "A" 5 "black")
  GAP
  (text "B" 10 "black")
  GAP))
(define (stack/h loi)
  (foldr beside-base GAP loi)) 

; TODO 8/8: Now using your solutions to the previous two parts, design the
;           function viz-schedule, which produces a visual representation
;           of a supplied course schedule, such that each course is a row
;           (with the prefix, num, name, prof, and day abbreviations) and
;           the rows are vertically stacked. You have been supplied tests
;           for clarity.

; viz-schedule : CourseSchedule -> Image
; produces a visual representation of the given schedule
(check-expect (viz-schedule SCHEDULE-OOPS) GAP)
(check-expect (viz-schedule SCHEDULE-KHOURY)
              (above GAP
                     (text "CS 2500 (Fundies, Howdy): MWR" 50 "black")
                     GAP
                     (text "CS 2501 (Fundies Lab, Awesome TAs): T" 50 "black")
                     GAP
                     (text "CS 1800 (Discrete Structures, Dr Strange): TF" 50 "black")
                     GAP
                     (text "CS 1802 (Seminar for CS 1800, Park): W" 50 "black")
                     GAP))
(check-expect (viz-schedule SCHEDULE-MAGIC)
              (above GAP
                     (text "HPTR 2000 (Care of Magical Creatures, Hagrid): T" 50 "black")
                     GAP
                     (text "HPTR 2650 (Potions, Snape): R" 50 "black")
                     GAP))

(check-expect (viz-schedule SCHEDULE-MAGIC-NERD)
              (above GAP
                     (text "HPTR 2000 (Care of Magical Creatures, Hagrid): T" 50 "black")
                     GAP
                     (text "HPTR 2650 (Potions, Snape): R" 50 "black")
                     GAP
                     (text "DS 2000 (Programming with Data, DS Prof): TR" 50 "black")
                     GAP
                     (text "CY 2550 (Foundations of Cybersecurity, CY Prof): TR" 50 "black")
                     GAP))

(define (viz-schedule cs)
  (stack/v (map course->image cs)))

; course->image : Course -> Image
; produces a visual representation of the given course
(check-expect (course->image COURSE-EASY-A) (text "SCHED 101 (Easy A, Lazy): " 50 "black"))
(check-expect (course->image COURSE-FUNDIES-LECTURE)
              (text "CS 2500 (Fundies, Howdy): MWR" 50 "black"))
(check-expect (course->image COURSE-DISCRETE-SEM)
              (text "CS 1802 (Seminar for CS 1800, Park): W" 50 "black"))
(check-expect (course->image COURSE-POTIONS)
              (text "HPTR 2650 (Potions, Snape): R" 50 "black"))
(define (course->image cm)
  (combine-text (string-append (course-prefix cm) " " (course-num cm) " (" (course-name cm) ", "
                               (course-prof cm) "): "
                               (course->days-abbrev cm))))

; combine-text : String -> Image
; converts the string to an image
(check-expect (combine-text "Hello") (text "Hello" 50 "black"))
(check-expect (combine-text "") (text "" 50 "black"))
(check-expect (combine-text "Fundies is Fun") (text "Fundies is Fun" 50 "black"))
(define (combine-text s)
  (text s 50 "black"))

