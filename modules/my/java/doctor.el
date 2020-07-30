;;; my/java/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (featurep! +google-java-format))
             (featurep! :editor format))
         "This module requires (:editor format)")

(when (and (featurep! +google-java-format)
           (not (executable-find "google-java-format")))
  (warn! "Couldn't find google-java-format. Code-formatting will be unavailable"))
