#lang racket/base

(require syntax/parse
         "../utils/utils.rkt"
         (for-template racket/base racket/unsafe/ops)
         (optimizer utils logging))

(provide box-opt-expr)

(define-unsafe-syntax-class unbox)
(define-unsafe-syntax-class set-box!)

(define-merged-syntax-class box-op (unbox^ set-box!^))

(define-syntax-class box-opt-expr
  #:commit
  #:literal-sets (kernel-literals)
  (pattern (#%plain-app op:box-op b:opt-expr new:opt-expr ...)
    #:do [(log-opt "box" "Box check elimination.")]
    #:with opt #`(op.unsafe b.opt new.opt ...)))
