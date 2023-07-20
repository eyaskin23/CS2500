;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |foldr notes1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ; (X Y) [X Y -> Y] [List-of X] -> Y
; applies f from right to left to each item in lx and b
; (foldr f b (list x1 ... xn)) == (f x1 ... (f xn b))

;(fold? string-append "" (list "a" "b" "c" "d"))
; (fold? string-append "" (cons "a"
;                            (cons "b"
;                                 (cons "c"
;                                     (cons "d" '()))))


; foldr:
(string-append
 "a"
 (string-append
  "b"
  (string-append
   "c"
   (string-append "d" ""))))


; foldl:
(string-append
 "d"
(string-append
 "c"
(string-append
 "b" 
 (string-append "a" "")))) 








 