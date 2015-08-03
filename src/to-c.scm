(display "#ifndef NAKED_VM\n")
(display "unsigned char *language = (unsigned char*) \"")

(for-each (lambda (x)
             (display "\\x")
             (display (string (ref "0123456789abcdef" (div x 16))))
             (display (string (ref "0123456789abcdef" (mod x 16)))))
          (file->list "repl"))

(display "\";")
(display "\n#endif")
