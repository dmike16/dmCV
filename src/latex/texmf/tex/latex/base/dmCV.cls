\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dmCV}[2014/10/30 v1.0h CurriculumVitae Template]
\RequirePackage{xcolor,color,graphicx,kvoptions}%,comfortaa
\newcommand\@ptsize{}
\newcommand\@ptemplatetitle{}
\newif\if@personaldata
\@personaldatatrue

\SetupKeyvalOptions{
  family=dmCV,
  prefix=dmCV@
}
\DeclareVoidOption{a4paper}{%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth {210mm}}
\DeclareVoidOption{11pt}{\renewcommand\@ptsize{1}%
  \renewcommand\@ptemplatetitle{79.5}}
\DeclareVoidOption{12pt}{\renewcommand\@ptsize{2}%
  \renewcommand\@ptemplatetitle{93.5}}
\DeclareVoidOption{facsimile}{\@personaldatafalse}
\DeclareBoolOption{noweblinkbox}
\DeclareStringOption[materialGreen]{weblinkcolor}
\DeclareDefaultOption{%
  \ClassWarning{dmCV}{Unknow option '\CurrentOption'}}
\ExecuteOptions{a4paper,11pt}
\ProcessKeyvalOptions{dmCV}
\ifdmCV@noweblinkbox
\PassOptionsToPackage{colorlinks=true}{hyperref}
\fi
\PassOptionsToPackage{urlcolor=\dmCV@weblinkcolor}{hyperref}
\relax

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
        @cv}}\hspace{1\p@} \hfil \raisebox{-1.5ex}{{
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
    \raisebox{4em}{\centering
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

\def\@myempty{\empty}
\newcommand\name[1]{\renewcommand\@name{#1}}
\newcommand\surname[1]{\renewcommand\@surname{#1}}
\newcommand\birth[1]{\renewcommand\@birth{#1}}
\newcommand\email[1]{\renewcommand\@email{#1}}
\newcommand\address[1]{\renewcommand\@address{#1}}
\newcommand\photo[1]{\renewcommand\@photo{#1}}
\def\@photo{\empty}
\newcommand\nationality[1]{\renewcommand\@nationality{#1}}
\if@personaldata
\def\@name{\ClassError{dmCV}{No \noexpand\name given}{What's your name}}
\def\@surname{\ClassError{dmCV}{No \noexpand\surname given}{What's your surname}}
\def\@birth{\ClassError{dmCV}{No \noexpand\birth given}{When were you born}}
\def\@email{\ClassError{dmCV}{No \noexpand\email given}{What's your email}}
\def\@address{\ClassError{dmCV}{No \noexpand\address given}{What's
    your address}}
\def\@nationality{\ClassError{dmCV}{No \noexpand\nationality given}{What's
    your nationality}}
\else
\def\@name{\hfil }
\def\@surname{\hfil}
\def\@birth{\hfil}
\def\@email{\hfil}
\def\@address{\hfil}
\def\@nationality{\hfil}
\fi

\def\when{\my@empty}
\def\where{\hbox}
\let\when\where
\newcommand\colordata[1]{\renewcommand\@colordata{#1}}
\def\@colordata{materialViolet}

\newcommand\personaldata{%
\begingroup
\newbox\pd@title
\setbox\pd@title\hbox to \textwidth{\hbox{{\color{materialBlue}\bfseries Personal Data}}\hfil}
\setbox5=\vtop{\halign{##\hfil&\quad##\hfil\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries Name}:}&\hbox{\@name}\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries Surname}:}&\hbox{\@surname}\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries Birth}:}&\vtop{\@birth\null}\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries Nationality}:}&\hbox{\@nationality}\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries E-mail}:}&\hbox{\@email}\cr
  \hbox{{\color{\@colordata}\scriptsize\bfseries Address}:}&\hbox{\@address}\cr
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
\setbox\photo@box\hbox{\framebox{\includegraphics[width=101\p@,height=130\p@]{\@photo}}}
\fi
\def\@tempdim{\wd\photo@box}
\addtolength\pos@photo{-\@tempdim}
\setbox6=\vbox{\moveright\pos@photo\box\photo@box}
\null\smallskip
\vbox{\box\pd@title\null\smallskip}
\null
\hbox{\raisebox{4cm}{\box5}\hfil\box6}\null\vskip 1ex
{\color{materialShadow}\hrule height1.5\p@}
\par\nobreak\null\smallskip
\endgroup
}

\newcommand\colorevent[1]{\renewcommand\@colorevent{#1}}
\let\@colorevent\@colordata

\newlength\@itembody
\setlength\@itembody{\textwidth}
\addtolength\@itembody{-\leftmargin}
\addtolength\@itembody{-\leftmargin}

\newcommand\eventfull[2]{%
  \item[{\color{\@colorevent}\scriptsize\bfseries
      #1}]\hskip0.1\p@\hbox to
    \@itembody{\vbox{\hsize\@itembody{\bfseries #2}}}}

\newcommand\event[1]{%
  \item[{\color{\@colorevent}\scriptsize\bfseries #1}]}
\newcounter{target}
\newenvironment{eventlist}[1]{%
  \par\null
  \begingroup
  \setbox0=\hbox to \textwidth{\hbox{{\color{materialBlue}\bfseries #1}}\hfil}
  \vbox{\box0\null}
  \endgroup
  \begin{list}
    {{\color{\@colorevent}\scriptsize\bfseries [\arabic{target}]}}{\usecounter{target}%
      \setlength{\rightmargin}{\leftmargin}}}{\end{list}%
{\color{materialShadow}\hrule height1.5\p@}\null\smallskip}
\RequirePackage[pdfpagelabels=false]{hyperref}
\pagestyle{plain}
\pagenumbering{arabic}

