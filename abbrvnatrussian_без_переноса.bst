%% abbrvnatrussian-titleitalic.bst -- Russian author-year BibTeX style with title on new line in italics
%% Compatible with natbib. Public-domain/minimal custom style.
%% Features: Russian "и" in citation labels, "и др." for 3+ authors,
%% Russian-style bibliography punctuation with em-dashes, URL/DOI support,
%% and sorting by language so language={russian} entries come first.

ENTRY
  { address
    author
    booktitle
    chapter
    doi
    edition
    editor
    howpublished
    institution
    isbn
    journal
    key
    language
    lastchecked
    month
    note
    number
    organization
    pages
    pagetotal
    publisher
    school
    series
    title
    type
    url
    urldate
    volume
    year
  }
  {}
  { label sort.label }

INTEGERS { nameptr namesleft numnames }
STRINGS  { s t u name }

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block}
{ ".~---~" write$ }

FUNCTION {write.nonempty}
{ duplicate$ empty$
    { pop$ }
    { write$ }
  if$
}

FUNCTION {write.title.italic}
{ title empty$
    { }
    { "\emph{" write$ title write$ "}" write$ }
  if$
}

FUNCTION {fin.entry}
{ "." write$ newline$ }

FUNCTION {bbl.and}
{ " и " }

FUNCTION {bbl.etal}
{ " и~др." }

FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 =
    { s #1 "{vv~}{ll}" format.name$ }
    { numnames #2 =
        { s #1 "{vv~}{ll}" format.name$ bbl.and *
          s #2 "{vv~}{ll}" format.name$ *
        }
        { s #1 "{vv~}{ll}" format.name$ bbl.etal * }
      if$
    }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { title empty$ { "Без автора" } { title } if$ }
            { key }
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {calc.label}
{ author.editor.key.label
  "(" *
  year empty$ { "б. г." } { year } if$
  * ")" *
  'label :=
}

FUNCTION {language.sort.prefix}
{ language empty$
    { "1 " }
    { language "russian" =
        { "0 " }
        { language "русский" =
            { "0 " }
            { "1 " }
          if$
        }
      if$
    }
  if$
}

FUNCTION {presort}
{ calc.label
  language.sort.prefix
  author empty$
    { editor empty$
        { key empty$ { title } { key } if$ }
        { editor #1 "{vv~}{ll}" format.name$ }
      if$
    }
    { author #1 "{vv~}{ll}" format.name$ }
  if$
  *
  " " *
  year empty$ { "0000" } { year } if$ *
  " " *
  title *
  'sort.key$ :=
}

FUNCTION {format.first.author.inverted}
{ author empty$
    { editor empty$
        { "" }
        { editor #1 "{vv~}{ll}{, jj}{, f.}" format.name$ }
      if$
    }
    { author #1 "{vv~}{ll}{, jj}{, f.}" format.name$ }
  if$
}

FUNCTION {format.names.direct}
{ 's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  { namesleft #0 > }
  { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 'name :=
    nameptr #1 >
      { t ", " * name * 't := }
      { name 't := }
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  }
  while$
  t
}

FUNCTION {format.responsibility}
{ author empty$
    { "" }
    { author format.names.direct }
  if$
}

FUNCTION {format.editors.resp}
{ editor empty$
    { "" }
    { " / под ред. " editor format.names.direct * }
  if$
}

FUNCTION {format.pubinfo}
{ "" 't :=
  address empty$
    { }
    { address 't := }
  if$
  publisher empty$
    { }
    { t empty$
        { publisher 't := }
        { t " : " * publisher * 't := }
      if$
    }
  if$
  year empty$
    { }
    { t empty$
        { year 't := }
        { t ", " * year * 't := }
      if$
    }
  if$
  t
}

FUNCTION {format.pages.range}
{ pages empty$
    { "" }
    { "С.~" pages * }
  if$
}

FUNCTION {format.book.pages}
{ pagetotal empty$
    { pages empty$
        { "" }
        { pages "~с" * }
      if$
    }
    { pagetotal "~с" * }
  if$
}

FUNCTION {format.urldate}
{ urldate empty$
    { lastchecked empty$ { "" } { lastchecked } if$ }
    { urldate }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "URL: \url{" url * "}" *
      format.urldate 'u :=
      u empty$
        { }
        { " (дата обращения: " * u * ")" * }
      if$
    }
  if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { "DOI: " doi * }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
}

FUNCTION {article}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  format.responsibility 't :=
  t empty$ not { " / " write$ t write$ } { } if$
  journal empty$ not { " // " write$ journal write$ } { } if$
  year empty$ not { new.block year write$ } { } if$
  volume empty$ not { new.block "Т.~" write$ volume write$ } { } if$
  number empty$ not { new.block "№~" write$ number write$ } { } if$
  pages empty$ not { new.block "С.~" write$ pages write$ } { } if$
  format.doi 't := t empty$ not { new.block t write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  volume empty$ not { ". Т.~" write$ volume write$ } { } if$
  edition empty$ not { ". " write$ edition write$ } { } if$
  format.pubinfo 't := t empty$ not { new.block t write$ } { } if$
  format.book.pages 't := t empty$ not { new.block t write$ } { } if$
  format.doi 't := t empty$ not { new.block t write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  format.responsibility 't :=
  t empty$ not { " / " write$ t write$ } { } if$
  booktitle empty$ not { " // " write$ booktitle write$ } { } if$
  format.editors.resp 't := t empty$ not { t write$ } { } if$
  format.pubinfo 't := t empty$ not { new.block t write$ } { } if$
  pages empty$ not { new.block "С.~" write$ pages write$ } { } if$
  format.doi 't := t empty$ not { new.block t write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {inproceedings} { incollection }
FUNCTION {conference} { incollection }

FUNCTION {proceedings}
{ output.bibitem
  write.title.italic
  editor empty$ not { format.editors.resp write$ } { } if$
  format.pubinfo 't := t empty$ not { new.block t write$ } { } if$
  format.book.pages 't := t empty$ not { new.block t write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  howpublished empty$ not { new.block howpublished write$ } { } if$
  year empty$ not { new.block year write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  format.doi 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {online} { misc }
FUNCTION {webpage} { misc }
FUNCTION {manual} { misc }

FUNCTION {techreport}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  type empty$ not { new.block type write$ } { } if$
  institution empty$ not { new.block institution write$ } { } if$
  format.pubinfo 't := t empty$ not { new.block t write$ } { } if$
  pages empty$ not { new.block pages write$ "~с" write$ } { } if$
  format.url 't := t empty$ not { new.block t write$ } { } if$
  note empty$ not { new.block note write$ } { } if$
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.first.author.inverted 't :=
  t empty$ not { t write$ " " write$ } { } if$
  write.title.italic
  new.block "дис. ... канд./д-ра наук" write$
  school empty$ not { new.block school write$ } { } if$
  format.pubinfo 't := t empty$ not { new.block t write$ } { } if$
  pages empty$ not { new.block pages write$ "~с" write$ } { } if$
  fin.entry
}

FUNCTION {mastersthesis} { phdthesis }
FUNCTION {unpublished} { misc }

FUNCTION {default.type} { misc }

FUNCTION {begin.bib}
{ preamble$ empty$ not { preamble$ write$ newline$ } { } if$
  "\begin{thebibliography}{}" write$ newline$
  "\providecommand{\url}[1]{#1}" write$ newline$
  "\makeatletter\renewcommand{\@biblabel}[1]{}\@ifundefined{NAT@biblabel}{}{\renewcommand{\NAT@biblabel}[1]{}}\makeatother" write$ newline$
}

FUNCTION {end.bib}
{ "\end{thebibliography}" write$ newline$ }

READ
ITERATE {presort}
SORT
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
