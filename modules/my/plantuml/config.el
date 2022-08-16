;;; my/plantuml/config.el -*- lexical-binding: t; -*-

(setq plantuml-jar-path (expand-file-name "plantuml.jar" doom-user-dir)
      plantuml-output-type "png"
      org-plantuml-jar-path plantuml-jar-path)
