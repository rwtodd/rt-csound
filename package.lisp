;;;; package.lisp

(defpackage "RT-CSOUND"
  (:use "COMMON-LISP")
  (:local-nicknames ("FFI" "CFFI"))
  (:export "INITIALIZE"
	   "DESTROY"
	   "GET-VERSION"
	   "SET-OPTIONS"
	   "START"
	   "COMPILE-CSD"
	   "PERFORM"
	   "CLEANUP"
	   "RESET"
   )
  )
	   
