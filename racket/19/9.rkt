#lang racket

(require "intcode.rkt")

(define program
  (with-input-from-file "../../input/19/9.in" parse-intcode))

(define (partA)
  (run-intcode program 1))

(define (partB)
  (run-intcode program 2))
