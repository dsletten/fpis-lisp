;;;;   Hey, Emacs, this is a -*- Mode: Lisp; Syntax: Common-Lisp -*- file!
;;;;
;;;;   Programming should be fun. Programs should be beautiful.
;;;;   -- Paul Graham
;;;;
;;;;   Name:               cafe2.lisp
;;;;
;;;;   Started:            Thu Aug 22 22:44:21 2024
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

(defpackage :cafe2 (:use :common-lisp :core :test))

(in-package :cafe2)

(defclass cafe () () (:documentation "A coffee shop"))

(defclass credit-card () () (:documentation "A credit card"))

(defclass payments () () (:documentation "A 'trait'"))

(defclass simulated-payments (payments) () (:documentation "Implements PAYMENTS trait."))

(defclass coffee ()
  ((price :reader price :initform 2d0)))

(defgeneric buy-coffee (cafe credit-card payments)
  (:documentation "Purchase a single coffee and charge credit card."))
(defmethod buy-coffee ((shop cafe) (cc credit-card) (p payments))
  (declare (ignore shop))
  (let ((cup (make-instance 'coffee)))
    (charge p cc (price cup))
    cup))

(defgeneric charge (payments credit-card price)
  (:documentation "Charge PRICE dollars to CREDIT-CARD."))
(defmethod charge ((p simulated-payments) (cc credit-card) (price number))
  (declare (ignore p))
  (format t "Pretending to contact issuing bank...~%")
  (format t "Charging: ~,2F~% to ~A" price cc))

(let ((cc (make-instance 'credit-card))
      (p (make-instance 'simulated-payments))
      (cafe (make-instance 'cafe)))
  (buy-coffee cafe cc p))

  
