(import (scheme base) (scheme char) (scheme file) (scheme write))
(import (srfi 13) (srfi 180))

(define (disp . xs) (for-each display xs) (newline))

(define (string-blank? s)
  (string-every char-whitespace? s))

(define (whitespace->space s)
  (let loop ((i 0) (space? #f) (chars '()))
    (if (= i (string-length s)) (list->string (reverse chars))
        (let ((char (string-ref s i)))
          (loop (+ i 1) (char-whitespace? char)
                (if (char-whitespace? char) chars
                    (cons char (if (and space? (not (null? chars)))
                                   (cons #\space chars)
                                   chars))))))))

(define (alist-ref/default alist key default)
  (let ((pair (assoc key alist)))
    (if pair (cdr pair) default)))

(vector-for-each (lambda (elem)
                   (let ((text (alist-ref/default elem 'text ""))
                         (href (alist-ref/default elem 'href "")))
                     (when (string-prefix-ci? "http" href)
                       (unless (string-blank? text)
                         (disp (whitespace->space text)))
                       (disp (whitespace->space href))
                       (newline))))
                 (json-read))
