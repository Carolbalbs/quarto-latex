
%%======== Pckage options and base class ========
%\newboolean{logo}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{externalized}
\LoadClassWithOptions{article}
\pdfoutput=1
\newif\ifthemetocloft

% Layout 
\RequirePackage[top=2.75cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\microtypesetup{expansion=false}
\IfFileExists{placeins.sty}{\RequirePackage{placeins}}{\newcommand{\FloatBarrier}{}}
\IfFileExists{hyphenat.sty}{\RequirePackage{hyphenat}}{\newcommand{\nohyphens}{}}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[english]{babel}
\IfFileExists{lipsum.sty}{\RequirePackage{lipsum}}{}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage[normalem]{ulem}
\DisableLigatures[f]{family=sf*} 
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\IfFileExists{fontawesome.sty}{\RequirePackage{fontawesome}}{
  \providecommand{\faCalendar}{}
  \providecommand{\faEnvelopeO}{}
  \providecommand{\faEnvelope}{}
  \providecommand{\faGithub}{}
}


\RequirePackage{booktabs}
\IfFileExists{nicematrix.sty}{\RequirePackage{nicematrix}}{}
\RequirePackage{multirow}
\RequirePackage{bm}
\newcommand{\nm}[1]{#1}
\RequirePackage[most]{tcolorbox}
\RequirePackage{xcolor}
\definecolor{themebg}{HTML}{004098}
\definecolor{themeaccent}{HTML}{004098}
\newcommand{\themeaccent}[1]{{\bfseries\color[HTML]{004098} #1}} 

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \RequirePackage[unsrtnat]{natbib}
% \bibliographystyle{abbrvnat}
\RequirePackage{hyperref}
\IfFileExists{cleveref.sty}{
  \RequirePackage[noabbrev,nameinlink]{cleveref}
}{
  \newcommand{\cref}[1]{\ref{##1}}
  \newcommand{\Cref}[1]{\ref{##1}}
  \newcommand{\crefrange}[2]{\ref{##1}--\ref{##2}}
  \newcommand{\Crefrange}[2]{\ref{##1}--\ref{##2}}
}
\hypersetup{
  colorlinks,
  linkcolor=themeaccent,
  citecolor=themeaccent,
  urlcolor=themeaccent
}


\RequirePackage[authoryear]{natbib}
\def\bibfont{\small}

%%========  Bibliography using bibtex ========
\addto{\captionsenglish}{\renewcommand{\refname}{References}}
\newcommand{\citeas}[1]{\Needspace*{8\baselineskip}\noindent\bibentry{#1}}



% Section and caption format 
\newcommand{\sectionfont}
{\fontsize{12}{10}\selectfont} 

\newcommand{\subsectionfont}
{\fontsize{11}{10}\selectfont} 

\RequirePackage{titlesec}
\titleformat*{\paragraph}{\bfseries\itshape}
\titleformat*{\section}{\sectionfont\sffamily\bfseries\themeaccent}
\titleformat*{\subsection}{\subsectionfont\sffamily\bfseries\themeaccent}


%一级二级三级标题用12 11 10
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries\themeaccent}


\newcommand{\bffont}
{\fontsize{8.8}{10}\selectfont} 

\DeclareTextFontCommand{\textbf}{\bffont\bfseries\sffamily}



\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=true,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}


\RequirePackage[T1]{fontenc}
\RequirePackage[scaled=0.95]{helvet}
\renewcommand{\sfdefault}{phv}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Authors, affiliations, infos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% [quarto-latex] \addtolist nao e definido por nenhum pacote base; declarado aqui
%% para a classe compilar de forma autonoma.
\providecommand\addtolist[5][]{}
\renewcommand\addtolist[5][]{
  \begingroup
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
    \let\protect\@unexpandable@protect 
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup
}

\newcommand{\authorfont}
{\fontsize{12}{14}\selectfont} 

\newcommand\authorlist{}
\newcommand\authorformat[2][]{\authorfont {\sffamily\bfseries #2$^{#1}$}}
\renewcommand\author[2][]{\addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}

%给affiliation换成medium字体

\newcommand{\affiliationfont}
{\fontsize{10}{12}\selectfont}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\affiliationfont {\sffamily\fontseries{sb}\selectfont $^{#1}$#2}}}
\newcommand\affiliation[2][]{\addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand{\contributionfont}
{\fontsize{10}{12}\selectfont}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\contributionfont $^{#1}$#2}}
\newcommand\contribution[2][]{\addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand{\checkdatafont}
{\fontsize{7.92}{10}\selectfont}

\newcommand\checkdatalist{}
\newcommand\checkdataformat[2][]{{\small {\checkdatafont\sffamily \bfseries #1:} #2}}
\newcommand\checkdata[2][]{\addtolist[#1]{#2}{\checkdatalist}{\checkdataformat}{\par}}


\newcommand{\abstractinfont}
{\fontsize{10}{12}\selectfont} 

\renewcommand{\abstract}[1]{\def\abstractlist{{\abstractinfont #1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}

\renewcommand\date[1]{\checkdata[\faCalendar\;Date]{#1}}
\newcommand\correspondence[1]{\checkdata[\faEnvelopeO\;Correspondence]{#1}}


\newcommand{\titlefont}
{\fontsize{17}{20}\selectfont} 

\renewcommand{\title}[1]{\newcommand{\titlelist}{\titlefont{\sffamily\bfseries #1}}}


\newcommand{\abstractfont}
{\fontsize{12}{12}\selectfont} 

\newcommand{\beginabstract}{\abstractfont{\sffamily\bfseries \themeaccent{Abstract}\par}}

\newcommand{\beginappendix}{\appendix{\titlefont\sffamily \themeaccent{Appendix}\par}}

\IfFileExists{tocloft.sty}{
  \themetoclofttrue
  \usepackage[subfigure]{tocloft}
}{
  \themetocloftfalse
}
\ifthemetocloft
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % 目录后一行连续的点
  \renewcommand{\cftsecfont}{\sffamily}
  %\renewcommand{\cftsubsecfont}{\sffamily\large}
  \renewcommand{\cftsecpagefont}{\sffamily}{\color{themeaccent}}
  \renewcommand{\cfttoctitlefont}
  {\sffamily\sectionfont\themeaccent}
\fi


%%======== Header and Footer Content ========
\fancypagestyle{firststyle}{
    \fancyhead[L]{}
    \fancyhead[R]{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

%去除页眉页脚横线
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}



% rules for title box at top of first page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%此处为标题两侧线段，0.5pt 长160mm
\newcommand{\@toptitlebar}{
  \themeaccent{\hrule height 0.5pt }
  \vskip 6mm
  %\vskip -\parskip%
}
\newcommand{\@bottomtitlebar}{
  \vskip 6mm
  %\vskip -\parskip
  \themeaccent{\hrule height 0.5pt}
  %\vskip 0.09in%
}


% Titlebox %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand{\mymaketitle}{%
  %\tcbset{enhanced,frame hidden}
  \tcbset{enhanced}
  \tcbset{left=8mm}
  \tcbset{right=8mm}
  \tcbset{top=6mm}
  \tcbset{bottom=6mm}
  \tcbset{colback=white}  
   % 框线颜色
  \tcbset{colframe=themebg} 
  % 调整框线粗细
  \tcbset{boxrule=0.5pt} 
  \tcbset{before skip=0pt}
  \tcbset{grow to left by=1.5pt}
  \tcbset{grow to right by=1.5pt}
  \tcbset{arc=2.5mm}
      {
      \setlength{\parskip}{0mm}
      \centering
      \nohyphens
      %
      
      {
      \@toptitlebar
        
        \titlelist\par
         \@bottomtitlebar
      }
      \vskip 6mm
      \authorlist
      \vskip 3mm
      %
      \affiliationlist\par
      \vskip 3mm
      %
      \contributionlist\par
    }
   \vskip 6mm   
   
  \begin{tcolorbox}
    \setlength{\parindent}{0cm}
    \setlength{\parskip}{0cm}

    %
    
    \begin{center}
        \beginabstract
        \vskip 3mm
    \end{center}
    
    \abstractlist\par
    %
    \vskip 3mm
    %
    {
      \setlength{\parskip}{0cm}
      \ifdefempty{\checkdatalist}{\vspace*{0.65cm}}{\checkdatalist\par}
    }
  \end{tcolorbox}
  \tcbset{reset}
  \FloatBarrier

  %加入页眉页脚
  \thispagestyle{firststyle}

}


\if@twocolumn%
\renewcommand{\maketitle}{
\twocolumn[%
 \vskip 3mm
  \mymaketitle
  \vskip 8mm
]
}%
\else%
\renewcommand{\maketitle}{
  \mymaketitle
  \vskip 8mm
  %\setlength{\parskip}{4mm}
}%
\fi
