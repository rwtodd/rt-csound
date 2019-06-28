;;;; package.lisp

(defpackage "RT-CSOUND"
  (:use "COMMON-LISP")
  (:local-nicknames ("FFI" "CFFI"))
  (:export "INITIALIZE"
	   "DESTROY"
	   "GET-VERSION"
	   "SET-OPTIONS"
	   "START"
	   "STOP"
	   "COMPILE-CSD"
	   "COMPILE-ORC"
	   "COMPILE-SCO"
	   "PERFORM"
	   "CLEANUP"
	   "RESET"
   )
  )
	   
