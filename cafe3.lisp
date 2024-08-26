;;;;   Hey, Emacs, this is a -*- Mode: Lisp; Syntax: Common-Lisp -*- file!
;;;;
;;;;   Programming should be fun. Programs should be beautiful.
;;;;   -- Paul Graham
;;;;
;;;;   Name:               cafe3.lisp
;;;;
;;;;   Started:            Thu Aug 22 22:44:23 2024
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

(defpackage :cafe3 (:use :common-lisp :core :test))

(in-package :cafe3)

(defclass cafe () () (:documentation "A coffee shop"))

(defclass credit-card () () (:documentation "A credit card"))

(defclass coffee ()
  ((price :reader price :initform 2d0)))

(defclass charge ()
  ((credit-card :reader cc :initarg :cc)
   (amount :reader amount :initarg :amount)))

(defgeneric buy-coffee (cafe credit-card)
  (:documentation "Purchase a single coffee and charge credit card."))
(defmethod buy-coffee ((shop cafe) (cc credit-card))
  (declare (ignore shop))
  (let ((cup (make-instance 'coffee)))
    (values cup (make-instance 'charge :cc cc :amount (price cup)))) )

(defun unzip (purchases)
  (loop for purchase in purchases
        collect (first purchase) into coffees
        collect (second purchase) into charges
        finally (return (values coffees charges))))

(defgeneric buy-coffees (cafe credit-card n)
  (:documentation "Purchase N coffees and charge credit card."))
(defmethod buy-coffees ((shop cafe) (cc credit-card) (n number))
  (declare (ignore shop))
  (let* ((purchases (loop repeat n
                          collect (multiple-value-list (buy-coffee shop cc)))) )
    (multiple-value-bind (coffees charges) (unzip purchases)
      (values coffees (reduce #'combine charges)))) )

(defgeneric combine (charge other)
  (:documentation "Combine two charges on the same credit card."))
(defmethod combine ((charge charge) (other charge))
  (if (eq (cc charge) (cc other))
      (make-instance 'charge :cc (cc charge) :amount (+ (amount charge) (amount other)))
      (error "Can't combine charges with different cards.")))

(let ((cc (make-instance 'credit-card))
      (cafe (make-instance 'cafe)))
  (buy-coffees cafe cc 5))


  
