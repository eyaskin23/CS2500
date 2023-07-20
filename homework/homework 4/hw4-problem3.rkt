;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw4-problem3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Now let's think about what goes into making an app that works with purchase
; receipts.
;
; Consider the following data definition:


(define-struct item [desc qty unit sale? next])

; A ReceiptItem is one of:
; - "nothing"
; - (make-item String Nat PosReal Boolean ReceiptItem)
; Intepretation: either end of the receipt or
; an item's description, quantity purchased,
; unit price (in $), whether it was on sale,
; and the next item on the receipt


; TODO 1/4: Complete the data design recipe for ReceiptItem.
;           You *must* have examples that (at least) represent the following
;           three receipts...
;           - An empty receipt
;           - A grocery receipt...
;             (1 box of cereal, $4.28),
;             (2 apples on sale, $1.67 each)
;           - A computer invoice...
;             (2 RaspberryPi on sale, $32 each),
;             (1 monitor, $135),
;             (2 wireless touch keyboards, $27 each)




(define RECEIPTITEM1 "nothing")
(define RECEIPTITEM2 (make-item "box of cereal" 1 4.28 #false "nothing"))
(define RECEIPTITEM3 (make-item "apples" 2 1.67 #true RECEIPTITEM2))
(define RECEIPTITEM4 (make-item "RaspberryPi" 2 32 #true RECEIPTITEM1))
(define RECEIPTITEM5 (make-item "monitor" 1 135 #false RECEIPTITEM4))
(define RECEIPTITEM6 (make-item "wireless touch keyboard" 2 27 #false RECEIPTITEM5))
(define RECEIPTITEM7 (make-item "cheese" 1 200 #false RECEIPTITEM6))

(define (receiptitem-temp i)
  (...
   (cond [(string=? i) ...]
         [(item? i) ...(item-desc i)
                    ...(item-qty i)
                    ...(item-unit i)
                    ...(item-sale? i)
                    ...(receiptitem-temp (item-next i)) ...])))
        



; TODO 2/4: Design the function total-cost, which calculates the total cost
;           of a receipt. For instance, the empty receipt is 0; the grocery
;           is (1 x 4.28) + (2 x 1.67) = 7.62; and the computer receipt is
;           (2 x 32) + (1 x 135) + (2 x 27) = 253.

; total-cost: ReceiptItem -> Nat
; returns the total cost of the items of the given receipt
(check-expect (total-cost RECEIPTITEM1) 0 )
(check-expect (total-cost RECEIPTITEM3) 7.62)
(check-expect (total-cost RECEIPTITEM6) 253) 


(define (total-cost i)
  (cond [(string? i) 0]
        [(item? i) (+ (* (item-unit i) (item-qty i)) (total-cost (item-next i)))]))



; TODO 3/4: Design the function any-sale?, which determines if any item in the
;           receipt is on sale. For example, the empty receipt does not have
;           any sale items, but both other examples do.

(check-expect (anysale? RECEIPTITEM1) #false)
(check-expect (anysale? RECEIPTITEM3) #true)
(check-expect (anysale? RECEIPTITEM6) #true) 

(define (anysale? i)
  (cond [(string? i) #false]
        [(item? i) (if (item-sale? i)
                       #true
                       (anysale? (item-next i)))]))
 
; TODO 4/4: Design the function expensive, which produces a new receipt that only
;           contains items that are greater than $100 (unit cost). For example,
;           both the empty and grocery receipts would produce empty receipts,
;           whereas the computer receipt would produce a new list only containing
;           the monitor.

; expensive : ReceiptItem -> ReceiptItem
; returns only items that cost above $100 given any item
(check-expect (expensive RECEIPTITEM1) RECEIPTITEM1)
(check-expect (expensive RECEIPTITEM3) RECEIPTITEM1)
(check-expect (expensive RECEIPTITEM6) (make-item "monitor" 1 135 #false RECEIPTITEM1))
(check-expect (expensive RECEIPTITEM7) (make-item "cheese" 1 200 #false (make-item "monitor" 1 135 #false "nothing")))


(define (expensive i)
  (cond [(string? i) RECEIPTITEM1]
        [(item? i) (if (> (item-unit i) 100)
                       (make-item (item-desc i) (item-qty i) (item-unit i) (item-sale? i) (expensive (item-next i)))
                       (expensive (item-next i)))])) 




          
          

