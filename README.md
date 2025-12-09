# Карельский дневник. Повесть о сплаве на байдарках в Карелии по маршруту "Сунская цепочка"

В повести рассказывается о первом сплаве автора в Карелии по маршруту "Сунская цепочка". Своеобразный "кольцевой" маршрут, замкнутый на посёлок Гирвас, состоит из двух частей: в первой путешественники побывают на череде озёр и небольших речушек, а во второй, начинающейся с Линдозера, предстоит штурм 14 порогов 2 категории сложности. Цепочка сменяющих друг друга рек и озёр приносит путешественникам массу впечатлений, приправленных переменчивой карельской погодой, а также местными ягодами, грибами и, конечно же, свежевыловленной рыбой. При заброске путешественники осмотрят крепость в Старой Ладоге, побывают на водопаде Кивач, а при выброске - на палеовулкане Гирвас.

# Необходимые пакеты livetex:

texlive-lang-cyrillic 
texlive-lang-english 
texlive-lang-german
texlive-pstricks
texlive-plain-generic
texlive-pictures
texlive-luatex
texlive-latex-recommended
texlive-latex-extra
texlive-latex-base
texlive-humanities
texlive-fonts-recommended
texlive-fonts-extra-links
texlive-fonts-extra
texlive-font-utils
texlive-extra-utils
texlive-binaries
texlive-base
texlive

# Build instructions

В терминале набрать:
```
mkdir build && cd build && cmake .. && make
```
После чего в директории /output появится конечный pdf файл.