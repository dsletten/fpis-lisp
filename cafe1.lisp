;;;;   Hey, Emacs, this is a -*- Mode: Lisp; Syntax: Common-Lisp -*- file!
;;;;
;;;;   APL is like a perfect diamond: if you add anything to it, it becomes flawed. In contrast, Lisp is like a ball of mud--if you add more to it, you get a bigger ball of mud.
;;;;   -- Joel Moses (attributed)
;;;;
;;;;   Name:               cafe1.lisp
;;;;
;;;;   Started:            Thu Aug 22 22:44:19 2024
;;;;   Modifications:
;;;;
;;;;   Purpose:
;;;;
;;;;
;;;;
;;;;   Calling Sequence:
;;;;
;;;;
;;;;   Inputs:
;;;;
;;;;   Outputs:
;;;;
;;;;   Example:
;;;;
;;;;   Notes:
;;;;
;;;;
(load "/home/slytobias/lisp/packages/core.lisp")
(load "/home/slytobias/lisp/packages/test.lisp")

(defpackage :cafe1 (:use :common-lisp :core :test))

(in-package :cafe1)

(defclass cafe () () (:documentation "A coffee shop"))

(defclass credit-card () () (:documentation "A credit card"))

(defclass coffee ()
  ((price :reader price :initform 2d0)))

(defgeneric buy-coffee (cafe credit-card)
  (:documentation "Purchase a single coffee and charge credit card."))
(defmethod buy-coffee ((shop cafe) (cc credit-card))
  (declare (ignore shop))
  (let ((cup (make-instance 'coffee)))
    (charge cc (price cup))
    cup))

(defgeneric charge (credit-card price)
  (:documentation "Charge PRICE dollars to CREDIT-CARD."))
(defmethod charge ((cc credit-card) (price number))
  (declare (ignore cc))
  (format t "Contacting issuing bank...~%")
  (format t "Charging: ~,2F~%" price))

(let ((cc (make-instance 'credit-card))
      (cafe (make-instance 'cafe)))
  (buy-coffee cafe cc))

  
