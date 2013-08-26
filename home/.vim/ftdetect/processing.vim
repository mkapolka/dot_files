au BufRead,BufNewFile *.pde		set filetype=java
"Makeprg + run
au BufRead,BufNewFile *.pde		set makeprg=C:/applications/processing/processing-java.exe\ --sketch=%:p:h\ --output=%:p:h/build/\ --force\ --run
"Makeprg - run
"au BufRead,BufNewFile *.pde		set makeprg=C:/applications/processing/processing-java.exe\ --sketch=%:p:h\ --output=%:p:h/build/\ --force\ --build
"au BufRead,BufNewFile *.pde		noremap <F5> :!C:/applications/processing/processing-java.exe --sketch=%:p:h --output=%:p:h/build/ --force --run<Cr>
