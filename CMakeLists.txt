CMAKE_MINIMUM_REQUIRED(VERSION 3.7)
PROJECT(StoryVepsianChronicle NONE)
FIND_PACKAGE(LATEX)
SET(PDFLATEX_COMPILER xelatex)
SET(LATEX_DEFAULT_BUILD pdf)
INCLUDE(UseLATEX.cmake)
SET(parts
    coordsvalues.tex
    titlepage.tex
    thankyou.tex
    typograph.tex
    annotation.tex
    #
    prolog.tex
    epilog.tex
    #
    посвящается.tex
    суна2023/антарктида.tex
    суна2023/платье.tex
    суна2023/пивотека.tex
    суна2023/заброска.tex
    суна2023/ладога.tex
    суна2023/паджерик.tex
    суна2023/венеция.tex
    суна2023/мярандукса.tex
    суна2023/нурмис.tex
    суна2023/линдозеро.tex
    суна2023/пороги.tex
    суна2023/черанга.tex
    суна2023/лавалампи.tex
    суна2023/вмордувинд.tex
    суна2023/выброска.tex 
    #
    lastpage.tex
    coordinates.tex
)
ADD_LATEX_DOCUMENT(
	main.tex
	BIBFILES bibliography.bib
	IMAGE_DIRS pictures/disign pictures/linographs
	INPUTS ${parts}
)
# Команда копирует результирующий файл main.pdf в директорию /output с переименованием
add_custom_command(
        TARGET main
        COMMAND ${CMAKE_COMMAND} -E copy
                ${CMAKE_CURRENT_SOURCE_DIR}/build/main.pdf
                ${CMAKE_CURRENT_SOURCE_DIR}/output/StorySuna2023_Sobolev.pdf)
