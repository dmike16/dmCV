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
    \raisebox{-1.ex}{{\scriptsize 
        @cv}}\hspace{1\p@} \hrulefill \hspace{1\p@} \raisebox{-1.ex}{{
        \scriptsize \thepage}}}
  \null
  \smallskip%
 \begingroup\parindent \z@ \raggedright \normalfont %
\def\c@boxaddpt{-13.71}
\def\height@portion{5}
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

\setlength\leftmargini  {2.5em}
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}


\newcommand\name[1]{\renewcommand\@name{#1}}
\newcommand\surname[1]{\renewcommand\@surname{#1}}
\newcommand\birth[1]{\renewcommand\@birth{#1}}
\newcommand\email[1]{\renewcommand\@email{#1}}
\newcommand\address[1]{\renewcommand\@address{#1}}
\newcommand\photo[1]{\renewcommand\@photo{#1}}
\def\@photo{\empty}
\if@personaldata
\def\@name{\ClassError{dmCV}{No \noexpand\name given}{What's your name}}
\def\@surname{\ClassError{dmCV}{No \noexpand\surname given}{What's your surname}}
\def\@birth{\ClassError{dmCV}{No \noexpand\birth given}{When were you born}}
\def\@email{\ClassError{dmCV}{No \noexpand\email given}{What's your email}}
\def\@address{\ClassError{dmCV}{No \noexpand\address given}{What's your address}}
\else
\begingroup\color{materialWhite}
\def\@name{\hrulefill}
\def\@surname{\hrulefill}
\def\@birth{\hrulefill}
\def\@email{\hrulefill}
\def\@address{\hrulefill}
\endgroup
\fi

\newcommand\personaldata{%
\begingroup
\newbox\pd@title
\setbox\pd@title\vtop{\hbox{{\bfseries Personal Data}}\hfil}
\setbox0=\hbox{{\bfseries Name}: \@name}
\setbox1=\hbox{{\bfseries Surname}: \@surname}
\setbox2=\hbox{{\bfseries Birth Date}: \@birth}
\setbox3=\hbox{{\bfseries E-mail}: \@email}
\setbox4=\hbox{{\bfseries Address}: \@address}
\setbox5=\vtop{\box0\box1\box2\box3\box4}
\setbox6=\vbox{\moveright2.7in\hbox{\includegraphics[scale=0.1]{\@photo}}}
\null\smallskip
\box\pd@title
\null\smallskip
{\color{materialShadow}\hrule height1.5pt}
\null\vskip 1ex
\hbox{\raisebox{4cm}{\box5}\box6}\null\vskip 1em
\par\nobreak\null\smallskip
\endgroup
}

\pagestyle{plain}
\pagenumbering{arabic}
