;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exam review notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design Recipe for Data:
; Definition - describe what the data is
; - "... is one of ..." -- enumeration
; - structure data "(define-struct ... [... ...])"
;   -... is a (make-etc.)
; Interpretation
; Examples
; Template


; DIET

; Enumeration Data:

; An MCAnswer is one of:
; - "A"
; - "B"
; - "c"
; Interpretation: Options for multiple choice

; EXAMPLES:
(define MC-A  "A")
(define MC-B  "B")
(define MC-C  "C")

; TEMPLATE
; mc-ans-temp : MCAnswer -> ???

(define (mc-ans-temp mc)
  (...
   (cond
     [(string=? MC-A mca)...]
     [(string=? MC-B mca)...]
     [(string=? MC-C mca)...])))

; A TFAnswer is one of:
; - 1
; - 0
; Interpretation: Options for answers of a true/false question
; where 1 is true and 0 is false

; EXAMPLES:
(define TF-1 1)
(define TF-0 0)

; TEMPLATE:
; tf-ans-temp : TFAnswer -> ???
(define (tf-ans-temp tfa)
  (...
   (cond
     [(= TF-1 tfa) ...]
     [(= TF-0 tfa) ...])))

; An ExamAnswer is one of:
; - MCAnswer
; - TFAnswer
; Interpretation: representing the potential answers for an exam.

; EXAMPLES:
(define EA-MC-A MC-A)
(define EA-TF-1 TF-1)
(define EA-TF-0 TF-0)
(define EA-MC-B MC-B)

; TEMPLATE:
; ex-ans-temp : ExamAnswer -> ???
(define (ex-ans-temp ans)
  (...
   (cond
     [(string? ans) (... (mc-ans-temp ans) ...)]
     [(number? ans) (... (tf-ans-temp ans) ...)])))

(define-struct exam-question [question answer points])
; An ExamQuestion is a (make-exam-question String ExamAnswer Nat]
; - question : the question of this particular exam question
; - answer: the answer of this particular exam quesiton
; - points: the point value assigned to this particular exam question
; Interpretation: representing a single question on an exam

; EXAMPLES:
(define EQ-1 (make-exam-question "I attended the Fundies 1 Review Session"
                                 EA-TF-0
                                 5))

(define EQ-2 (make-exam-question "2+2= A) 8 B) 10 C) 4"
                                 EA-MC-B
                                 10))

; TEMPLATE:
(define (ex-q-temp q)
 (... (exam-question-question q) ...
      (ex-ans-temp (exam-question-answer q)) ...
      (exam-question-points q) ...))

(define-struct exam [q next-q])
; An Exam is one of:
; - #false
; - (make-exam ExamQuestion Exam)
; Interpretation: Represents a set of questions on an exam.

; EXAMPLES:
(define EX-EMPTY #false)
(define EX-1 (make-exam EQ-1 EX-EMPTY))
(define EX-2 (make-exam EQ-2 EX-1))

; TEMPLATE
; exam-temp : Exam -> ???
(define (exam-temp ex)
  (...
   (cond
     [(boolean? ex) ...]
     [(exam? ex)
      (... (ex-q-temp (exam-q ex)) ...
           (exam-temp (exam-next-q ex)) ...)])))



; Function Design Recipe: 
; Signature
; - function-name : ... -> ...
; Purpose Statement
; - specific and simple

; Tests
; - examples, check-expects 
; Code






  





  
  



 





