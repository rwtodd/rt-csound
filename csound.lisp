(in-package "RT-CSOUND")

;; useful references:  ---------------------------------------
;; https://csound.com/docs/api/index.html
;; c:/Program Files/Csound6_x64/include/csound/csound.h
;; -----------------------------------------------------------


(ffi:define-foreign-library csound (t (:default "csound64")))
(pushnew #P"/Program Files/Csound6_x64/bin/"
	 ffi:*foreign-library-directories* :test #'equal)
(ffi:use-foreign-library csound)

(defparameter *csound-instance* nil)
(defconstant +success+ 0) ;; used throughout the library

(defun initialize ()
  "Set up our instance of csound"
  ;; TODO: signal error on bad returns...
  ;; 3 == CSOUNDINIT_NO_SIGNAL_HANDLER | NO_ATEXIT
  (ffi:foreign-funcall "csoundInitialize" :int 3 :int)
  (setq *csound-instance* (ffi:foreign-funcall "csoundCreate"
					       :pointer (ffi:null-pointer)
					       :pointer)))


(defun destroy ()
  "close down the csound instance"
  (ffi:foreign-funcall "csoundDestroy" :pointer *csound-instance* :void)
  (setq *csound-instance* nil))

(defun get-version ()
  "Determine the csound version"
  (ffi:foreign-funcall "csoundGetVersion" :int))

(defun set-options (opts)
  "Set the options given in OPTS, a list of strings"
  ;; TODO: identify non-+success+ returns and raise errors...
  (dolist (opt opts t)
    (ffi:foreign-funcall "csoundSetOption" :pointer *csound-instance* :string opt :int)))


(defun start ()
  "Call start after compiling ORC file"
  (= +success+ (ffi:foreign-funcall "csoundStart" :pointer *csound-instance* :int)))

(defun compile-csd (csd)
  "If CSD is a pathname, compile the .csd file. If CSD is a string,
compile it as a CSD file."
  (= +success+
     (typecase csd
       (pathname (ffi:foreign-funcall "csoundCompileCsd" :pointer *csound-instance* :string (namestring csd) :int))
       (string (ffi:foreign-funcall "csoundCompileCsdText" :pointer *csound-instance* :string csd :int))
       (t -1))))

(defun perform ()
  "Perform the currently-loaded score... returns:
 positive: finished, zero: stopped and can re-call this func to
continue, negative: error.  For all cases, you must call (reset)
when done."
  (ffi:foreign-funcall "csoundPerform" :pointer *csound-instance* :int))

(defun reset ()
  "Prepare for another performance without reloading csound"
  (ffi:foreign-funcall "csoundReset" :pointer *csound-instance* :void)
  t)

(defun cleanup ()
  "Clean up after a performance"
  (= +success+
     (ffi:foreign-funcall "csoundCleanup" :pointer *csound-instance* :int)))

;; TESTING ...
;; (defparameter *csdf* #P"/Users/richa/Documents/csd/buzz.csd")
;; (initialize)
;; *csound-instance*
;; (set-options '("-odac" "-d"))
;; (compile-csd *csdf*)
;; (start)
;; (perform)
;; (cleanup)
;; (reset)
