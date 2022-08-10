;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(setq package-archives '(("gnu"   . "https://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "https://mirrors.cloud.tencent.com/elpa/melpa/")
                         ("org"   . "https://mirrors.cloud.tencent.com/elpa/org/")))

(setq org-directory "~/Documents/org/")

(doom! :input

       :completion
       (company +childframe)            ; the ultimate code completion backend
       ;;helm                           ; the *other* search engine for love and life
       ;;ido                            ; the other *other* search engine...
       ;; (ivy                          ; a search engine for love and life
       ;; +prescient
       ;; ;; +fuzzy
       ;; ;; +childframe
       ;; +icons)
       (vertico +icons +childframe)     ; the search engine of the future

       :ui
       ;;deft                           ; notational velocity for Emacs
       doom                             ; what makes DOOM look the way it does
       ;;doom-dashboard                 ; a nifty splash screen for Emacs
       ;;doom-quit                      ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)                 ; 🙂
       hl-todo                          ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       ;;indent-guides                  ; highlighted indent columns
       ;;ligatures                      ; ligatures and symbols to make your code pretty again
       ;;minimap                        ; show a map of the code on the side
       modeline                         ; snazzy, Atom-inspired modeline, plus API
       nav-flash                        ; blink cursor line after big motions
       ;;neotree                        ; a project drawer, like NERDTree for vim
       ophints                          ; highlight the region an operation acts on
       (popup +defaults)                ; tame sudden yet inevitable temporary windows
       ;;tabs                           ; a tab bar for Emacs
       (treemacs +lsp)                  ; a project drawer, like neotree but cooler
       ;;unicode                        ; extended unicode support for various languages
       vc-gutter                        ; vcs diff in the fringe
       ;;vi-tilde-fringe                ; fringe tildes to mark beyond EOB
       window-select                    ; visually switch windows
       workspaces                       ; tab emulation, persistence & separate workspaces
       zen                              ; distraction-free coding or writing

       :editor
       ;;(evil +everywhere)             ; come to the dark side, we have cookies
       file-templates                   ; auto-snippets for empty files
       fold                             ; (nigh) universal code folding
       format                           ; automated prettiness
       ;;lispy                          ; vim for lisp, for people who dont like vim
       multiple-cursors                 ; editing in many places at once
       ;;objed                          ; text object editing for the innocent
       ;;parinfer                       ; turn lisp into python, sort of
       ;;rotate-text                    ; cycle region at point between text candidates
       snippets                         ; my elves. They type so I don't have to
       word-wrap                        ; soft wrapping with language-aware indent

       :emacs
       (dired +dirvish)                 ; making dired pretty [functional]
       electric                         ; smarter, keyword-based electric-indent
       (ibuffer +icons)                 ; interactive buffer management
       undo                             ; persistent, smarter undo for your inevitable mistakes
       vc                               ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell      ; a consistent, cross-platform shell (WIP)
       ;;shell                          ; a terminal REPL for Emacs
       ;;term                           ; terminals in Emacs
       vterm                            ; another terminals in Emacs

       :checkers
       (syntax +childframe)             ; tasing you for every semicolon you forget
       (spell +flyspell +hunspell)      ; tasing you for misspelling mispelling
       ;;grammar                        ; tasing grammar mistake every you make

       :tools
       ;;ansible
       (debugger +lsp)                  ; FIXME stepping through code, to help you add bugs
       ;;direnv
       docker
       editorconfig                     ; let someone else argue about tabs vs spaces
       ;;ein                            ; tame Jupyter notebooks with emacs
       (eval +overlay)                  ; run code, run (also, repls)
       ;;gist                           ; interacting with github gists
       (lookup +dictionary)             ; helps you navigate your code and documentation
       (lsp +peek)
       (magit +forge)                   ; a git porcelain for Emacs
       make                             ; run make tasks from Emacs
       ;;pass                           ; password manager for nerds
       (:if IS-MAC pdf)                 ; pdf enhancements
       ;;prodigy                        ; FIXME managing external services & code builders
       rgb                              ; creating color strings
       ;;terraform                      ; infrastructure as code
       ;;tmux                           ; an API for interacting with tmux
       tree-sitter                      ; syntax and parsing, sitting in a tree...
       ;;upload                         ; map local to remote projects via ssh/ftp
       ;;wakatime

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       ;;tty               ; improve the terminal Emacs experience

       :lang
       ;;agda                           ; types of types of types of types...
       ;;cc                             ; C/C++/Obj-C madness
       ;;clojure                        ; java with a lisp
       ;;common-lisp                    ; if you've seen one lisp, you've seen them all
       ;;coq                            ; proofs-as-programs
       ;;crystal                        ; ruby at the speed of c
       ;;csharp                         ; unity, .NET, and mono shenanigans
       data                             ; config/data formats
       ;;erlang                         ; an elegant language for a more civilized age
       ;;elixir                         ; erlang done right
       ;;elm                            ; care for a cup of TEA?
       emacs-lisp                       ; drown in parentheses
       ;;ess                            ; emacs speaks statistics
       ;;fsharp                         ; ML stands for Microsoft's Language
       (go +lsp +tree-sitter)           ; the hipster dialect
       ;;(haskell +intero)              ; a language that's lazier than I am
       ;;hy                             ; readability of scheme w/ speed of python
       ;;idris                          ;
       (json +tree-sitter)              ; At least it ain't XML
       (java +lsp +tree-sitter)         ; the poster child for carpal tunnel syndrome
       (javascript +lsp +tree-sitter)   ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia                          ; a better, faster MATLAB
       ;;(kotlin +lsp)                  ; a better, slicker Java(Script)
       ;;latex                          ; writing papers in Emacs has never been so fun
       ;;ledger                         ; an accounting system in Emacs
       lua                              ; one-based indices? one-based indices
       (markdown +grip)                 ; writing docs for people to ignore
       ;;nim                            ; python + lisp at the speed of c
       ;;nix                            ; I hereby declare "nix geht mehr!"
       ;;ocaml                          ; an objective camel
       (org                             ; organize your plain life in plain text
        +dragndrop                      ; drag & drop files/images into org buffers
        +noter
        ;;+hugo                         ; use Emacs for hugo blogging
        ;;+jupyter                      ; ipython/jupyter support for babel
        +pandoc                         ; export-with-pandoc support
        ;;+present                      ; using Emacs for presentations
        ;;+pomodoro                     ; be fruitful with the tomato technique
        ;;+journal                      ; using org-mode for presentations
        +pretty)
       ;;perl                           ; write code no one else can comprehend
       ;;php                            ; perl's insecure younger brother
       plantuml                         ; diagrams for confusing people more
       ;;purescript                     ; javascript, but functional
       ;;(python +lsp +pyright)         ; beautiful is better than ugly
       ;;qt                             ; the 'cutest' gui framework ever
       ;;racket                         ; a DSL for DSLs
       (rest +jq)                       ; Emacs as a REST client
       ;;ruby                           ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;rust                           ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (scala +lsp +tree-sitter)        ; java, but good
       ;;scheme                         ; a fully conniving family of lisps
       (sh +tree-sitter)                ; she sells {ba,z,fi}sh shells on the C xor
       ;;solidity                       ; do you need a blockchain? No.
       ;;swift                          ; who asked for emoji variables?
       ;;terra                          ; Earth and Moon in alignment for performance.
       (web +lsp +tree-sitter)          ; the tubes
       yaml                             ; JSON, but readable

       :email
       (mu4e +org)                      ; WIP
       ;;notmuch                        ; WIP
       ;;(wanderlust +gmail)            ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;calendar
       ;;irc                            ; how neckbeards socialize
       ;;(rss +org)                     ; emacs as an RSS reader
       ;;twitter                        ; twitter client https://twitter.com/vnought
       ;;(write                         ; emacs for writers (fiction, notes, papers, etc.)
       ;; +wordnut                      ; wordnet (wn) search
       ;; +langtool)                    ; a proofreader (grammar/style check) for Emacs

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; config. Use it as a reference for your own modules.
       (default +bindings +smartparens)

       :my
       chinese
       company
       ui
       editor
       spell
       calendar
       dired
       magit
       translate
       email
       tools
       debugger
       lsp
       markdown
       org
       plantuml
       protobuf
       go
       (java +google-java-format)
       scala
       sql
       web
       pkgbuild
       keybindings)
