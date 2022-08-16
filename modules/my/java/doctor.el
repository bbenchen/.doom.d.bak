;;; my/java/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +google-java-format))
             (modulep! :editor format))
         "This module requires (:editor format)")

(when (and (modulep! +google-java-format)
           (not (executable-find "google-java-format")))
  (warn! "Couldn't find google-java-format. Code-formatting will be unavailable"))
