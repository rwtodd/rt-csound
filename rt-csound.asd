;;;; rt-lazygen.asd

(asdf:defsystem "rt-csound"
  :description "cffi interface to csound"
  :author "Richard Todd <richard.wesley.todd@gmail.com>"
  :license "GPL V3"
  :serial t
  :depends-on ("cffi")
  :components ((:file "package")
               (:file "csound")))

