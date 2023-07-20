;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |foldr notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(foldr string-append " " (list "a" "b" "c"))
  (string-append "a" (foldr string-append "" (list "b" "c"))
                 (string-append "b" (foldr string-append "" (list "c"))
                                (string-append "c" (foldr string-append "" (list)))
                                "")
                 "c"
                 "bc"
                 "abc")



       
