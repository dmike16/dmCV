\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dmCV}[2014/10/30 v1.0h CurriculumVitae Template]
\RequirePackage{xcolor,color,graphicx}%,comfortaa,graphicx}
\newcommand\@ptsize{}
\newcommand\@ptemplatetitle{}
\newif\if@personaldata
\@personaldatatrue
\DeclareOption{a4paper}{%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth {210mm}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}%
  \renewcommand\@ptemplatetitle{79.5}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}%
  \renewcommand\@ptemplatetitle{93.5}}
\DeclareOption{facsimile}{\@personaldatafalse}
\DeclareOption*{%
  \ClassWarning{dmCV}{Unknow option '\CurrentOption'}}
\ExecuteOptions{a4paper,11pt}
\ProcessOptions\relax


\input{size1\@ptsize.clo}
\input{materialColor.def}

\AtBeginDocument{%
      \@makecvheadings

}

\def\@makecvheadings{%
  \let\@oddfoot\@empty
  \def\@oddfoot{%
    \reset@font
    \color{materialBlack}
    \raisebox{-1.8ex}{{\scriptsize 
        @cv}}\hspace{1\p@} \hfill \raisebox{-1.5ex}{{
        \scriptsize \thepage}}}
  \null
  \smallskip%
 \begingroup\parindent \z@ \raggedright \normalfont %
\def\c@boxaddpt{-13.71}
\def\height@portion{6}
\newdimen\pic@width
\newdimen\pic@height
\pic@width=\textwidth
\advance\pic@width\c@boxaddpt\p@

\pic@height=\textheight
\divide\pic@height\height@portion
\fboxrule1.5pt
\fcolorbox{materialShadow}{materialBlue}{
\makebox[\pic@width]{%
    \rule[\pic@height]{0\p@}{1.0\p@}
    \raisebox{6em}{\centering
      \color{materialWhite}
      %\fcofamily
        \parbox[b]{\@ptemplatetitle\p@}{{\Large  \bfseries Curriculum
            Vitae }}
        {\large et}
        \parbox[t]{\@ptemplatetitle\p@}{\null{\Large \bfseries Studiorum}}
    }}}\par\nobreak
\endgroup
\null
\smallskip
}

\setlength\leftmargini  {6.4em}
\leftmargin \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {2.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\itemsep{2.5ex}


\newcommand\name[1]{\renewcommand\@name{#1}}
\newcommand\surname[1]{\renewcommand\@surname{#1}}
\newcommand\birth[1]{\renewcommand\@birth{#1}}
\newcommand\email[1]{\renewcommand\@email{#1}}
\newcommand\address[1]{\renewcommand\@address{#1}}
\newcommand\photo[1]{\renewcommand\@photo{#1}}
\def\@myempty{\empty}
\def\@photo{\empty}
\if@personaldata
\def\@name{\ClassError{dmCV}{No \noexpand\name given}{What's your name}}
\def\@surname{\ClassError{dmCV}{No \noexpand\surname given}{What's your surname}}
\def\@birth{\ClassError{dmCV}{No \noexpand\birth given}{When were you born}}
\def\@email{\ClassError{dmCV}{No \noexpand\email given}{What's your email}}
\def\@address{\ClassError{dmCV}{No \noexpand\address given}{What's your address}}
\else
\def\@name{\hfil }
\def\@surname{\hfil}
\def\@birth{\hfil}
\def\@email{\hfil}
\def\@address{\hfil}
\fi

\newcommand\personaldata{%
\begingroup
\newbox\pd@title
\setbox\pd@title\hbox to \textwidth{\hbox{{\bfseries Personal Data}}\hfil}
\setbox5=\vtop{\halign{##\hfil&\quad##\hfil\cr
  \hbox{{\bfseries Name}:}&\hbox{\@name}\cr
  \hbox{{\bfseries Surname}:}&\hbox{\@surname}\cr
  \hbox{{\bfseries Birth Date}:}&\hbox{\@birth}\cr
  \hbox{{\bfseries E-mail}:}&\hbox{\@email}\cr
  \hbox{{\bfseries Address}:}&\hbox{\@address}\cr
}}
\def\@tempdim{\wd5}
\newlength\pos@photo
\setlength\pos@photo\textwidth
\addtolength\pos@photo{-\@tempdim}
\newbox\photo@box
\ifx\@photo\@myempty
\setbox\photo@box\hbox{\framebox[101pt]{\rule[10pt]{0pt}{131pt}%
    \raisebox{2cm}{\hbox{No Photo}}}}
\else
\setbox\photo@box\hbox{\framebox{\includegraphics[width=101pt,height=130pt]{\@photo}}}
\fi
\def\@tempdim{\wd\photo@box}
\addtolength\pos@photo{-\@tempdim}
\setbox6=\vbox{\moveright\pos@photo\box\photo@box}
\null\smallskip
\vbox{\box\pd@title\null\smallskip
    {\color{materialShadow}\hrule height1.5\p@}}
\null
\hbox{\raisebox{4cm}{\box5}\hfil\box6}\null\vskip 1ex
\par\nobreak\null\smallskip
\endgroup
}

\newcommand\event[1]{%
  \item[{\bfseries\small #1}]}
\newcounter{target}
\newenvironment{eventlist}[1]{%
  \par\null
  \begingroup
  \setbox0=\hbox to \textwidth{\hbox{{\bfseries #1}}\hfil}
  \vbox{\box0\null\smallskip
    {\color{materialShadow}\hrule height1.5\p@}}
  \endgroup
  \begin{list}
    {{\small [\arabic{target}]}}{\usecounter{target}%
      \setlength{\rightmargin}{\leftmargin}}}{\end{list}}
\pagestyle{plain}
\pagenumbering{arabic}
