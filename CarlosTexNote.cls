% -----------------------------------------------------------------------------
% CarlosTexNote.cls — Chinese XeLaTeX study-note class
% Compact, review-oriented layout with selectable semantic color themes.
% Usage: \documentclass[circuit,theme=ocean]{CarlosTexNote}
% XeLaTeX only. Self-contained: no companion .sty file is required.
% -----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CarlosTexNote}[2026/11/10 v0.2.0 Compact study notes with themes]

\RequirePackage{iftex}
\RequireXeTeX
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=carlosnote,prefix=carlosnote@}
\DeclareStringOption[classic]{theme}
\DeclareBoolOption[false]{circuit}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexrep}}
\ProcessKeyvalOptions*

\LoadClass[UTF8,zihao=-4,twoside,openany]{ctexrep}


\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage[table]{xcolor}
\RequirePackage{amsmath,amssymb,mathtools,bm}
\allowdisplaybreaks[4]
\RequirePackage{graphicx}\graphicspath{{img/}{fig/}{pic/}}
\RequirePackage{booktabs,longtable,tabularx,array,multirow,makecell,float}
\RequirePackage{enumitem}
\RequirePackage{needspace}
\RequirePackage{etoolbox}\RequirePackage{xpatch}
\RequirePackage[skins,breakable]{tcolorbox}
\RequirePackage{fancyhdr}
\RequirePackage{caption,subcaption}
\RequirePackage{siunitx}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,calc,angles,quotes}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\ifcarlosnote@circuit
  \RequirePackage[europeanresistors,cuteinductors]{circuitikz}
\fi
\sisetup{detect-all,per-mode=symbol,range-phrase=--,range-units=single}
\RequirePackage{xurl}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\hypersetup{hidelinks}

% -----------------------------------------------------------------------------
% Theme selection. All semantic roles keep the same meaning across palettes:
% Navy = chapter / theorem, Blue = section / definition, Teal = keyword / property,
% Gold = example / summary, Red = warning. Accent colors are contrast-checked.
% -----------------------------------------------------------------------------

\def\carlosnote@palette@classic{%
  \definecolor{NoteInk}{HTML}{26343D}%
  \definecolor{NoteNavy}{HTML}{203B55}%
  \definecolor{NoteBlue}{HTML}{2C6F91}%
  \definecolor{NoteTeal}{HTML}{1F7771}%
  \definecolor{NoteGold}{HTML}{93611F}%
  \definecolor{NoteRed}{HTML}{A34E4E}%
  \definecolor{NoteMuted}{HTML}{687783}%
  \definecolor{NoteRule}{HTML}{D8E0E5}%
  \definecolor{NoteBlueBg}{HTML}{F6F9FB}%
  \definecolor{NoteTealBg}{HTML}{F2F8F7}%
  \definecolor{NoteGoldBg}{HTML}{FBF7EF}%
  \definecolor{NoteRedBg}{HTML}{FCF7F6}%
}

\def\carlosnote@palette@ocean{%
  \definecolor{NoteInk}{HTML}{1D2B36}%
  \definecolor{NoteNavy}{HTML}{17324D}%
  \definecolor{NoteBlue}{HTML}{1769AA}%
  \definecolor{NoteTeal}{HTML}{087F8C}%
  \definecolor{NoteGold}{HTML}{946200}%
  \definecolor{NoteRed}{HTML}{B93838}%
  \definecolor{NoteMuted}{HTML}{526B7A}%
  \definecolor{NoteRule}{HTML}{CFDCE5}%
  \definecolor{NoteBlueBg}{HTML}{EEF5FC}%
  \definecolor{NoteTealBg}{HTML}{E9F7F7}%
  \definecolor{NoteGoldBg}{HTML}{FBF4E5}%
  \definecolor{NoteRedBg}{HTML}{FCEEEE}%
}

\def\carlosnote@palette@forest{%
  \definecolor{NoteInk}{HTML}{26362D}%
  \definecolor{NoteNavy}{HTML}{1F3B2D}%
  \definecolor{NoteBlue}{HTML}{28734A}%
  \definecolor{NoteTeal}{HTML}{087F65}%
  \definecolor{NoteGold}{HTML}{8F650F}%
  \definecolor{NoteRed}{HTML}{A93232}%
  \definecolor{NoteMuted}{HTML}{627269}%
  \definecolor{NoteRule}{HTML}{D7E1D9}%
  \definecolor{NoteBlueBg}{HTML}{EFF6F0}%
  \definecolor{NoteTealBg}{HTML}{EAF6F0}%
  \definecolor{NoteGoldBg}{HTML}{FAF5E9}%
  \definecolor{NoteRedBg}{HTML}{FBEEEE}%
}

\def\carlosnote@palette@sunset{%
  \definecolor{NoteInk}{HTML}{3C2B30}%
  \definecolor{NoteNavy}{HTML}{512B3A}%
  \definecolor{NoteBlue}{HTML}{A43A59}%
  \definecolor{NoteTeal}{HTML}{087A74}%
  \definecolor{NoteGold}{HTML}{95620A}%
  \definecolor{NoteRed}{HTML}{AD303E}%
  \definecolor{NoteMuted}{HTML}{78616A}%
  \definecolor{NoteRule}{HTML}{E7D6DA}%
  \definecolor{NoteBlueBg}{HTML}{FBF0F3}%
  \definecolor{NoteTealBg}{HTML}{EDF7F5}%
  \definecolor{NoteGoldBg}{HTML}{FCF5E8}%
  \definecolor{NoteRedBg}{HTML}{FCEEEF}%
}

\def\carlosnote@palette@violet{%
  \definecolor{NoteInk}{HTML}{302A3B}%
  \definecolor{NoteNavy}{HTML}{39295F}%
  \definecolor{NoteBlue}{HTML}{6546A5}%
  \definecolor{NoteTeal}{HTML}{087D89}%
  \definecolor{NoteGold}{HTML}{8C6108}%
  \definecolor{NoteRed}{HTML}{AE355B}%
  \definecolor{NoteMuted}{HTML}{6D647B}%
  \definecolor{NoteRule}{HTML}{DED7E8}%
  \definecolor{NoteBlueBg}{HTML}{F4F0FB}%
  \definecolor{NoteTealBg}{HTML}{EDF7F8}%
  \definecolor{NoteGoldBg}{HTML}{FBF5E8}%
  \definecolor{NoteRedBg}{HTML}{FBEFF3}%
}

\@ifundefined{carlosnote@palette@\carlosnote@theme}{%
  \ClassError{CarlosTexNote}{Unknown theme '\carlosnote@theme'}{%
    Choose one of: classic, ocean, forest, sunset, violet.}%
  \def\carlosnote@theme{classic}%
  \carlosnote@palette@classic
}{%
  \csname carlosnote@palette@\carlosnote@theme\endcsname
}
\newcommand{\NoteThemeName}{\carlosnote@theme}
\color{NoteInk}

% -----------------------------------------------------------------------------
% Page grid and vertical rhythm
% -----------------------------------------------------------------------------
\geometry{a4paper,twoside,inner=2.45cm,outer=2.05cm,top=1.85cm,bottom=1.9cm,
  headheight=24pt,headsep=4.5mm,footskip=8mm}
\setstretch{1.18}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.22em}
\setlength{\emergencystretch}{1.2em}
\raggedbottom
\setlength{\abovedisplayskip}{0.58em plus 0.16em minus 0.12em}
\setlength{\belowdisplayskip}{0.58em plus 0.16em minus 0.12em}
\setlength{\abovedisplayshortskip}{0.28em plus 0.12em}
\setlength{\belowdisplayshortskip}{0.38em plus 0.12em}
\setlength{\jot}{2.5pt}
% Deliberately do NOT force \displaystyle in inline math.

\setlist[itemize]{leftmargin=1.65em,label=\textcolor{NoteTeal}{\small$\blacktriangleright$},
  topsep=0.18em,itemsep=0.04em,parsep=0pt,partopsep=0pt}
\setlist[enumerate]{leftmargin=1.8em,label=\textcolor{NoteBlue}{\bfseries\arabic*.},
  topsep=0.18em,itemsep=0.05em,parsep=0pt,partopsep=0pt}
\setlength{\tabcolsep}{5pt}
\renewcommand{\arraystretch}{1.08}
\captionsetup{font=small,labelfont={bf,color=NoteBlue},textfont={color=NoteInk},
  labelsep=quad,skip=3pt}
\AtBeginEnvironment{table}{\small}
\AtBeginEnvironment{longtable}{\small}

% -----------------------------------------------------------------------------
% Heading hierarchy: preserve the user's chapter/section/paragraph model.
% paragraph = a numbered topic heading; subparagraph = a run-in cue keyword.
% -----------------------------------------------------------------------------
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{2}
\ctexset{appendix={name={附录\ },number=\Alph{chapter}}}
\titleformat{\chapter}[block]
  {\normalfont\sffamily\bfseries\color{NoteNavy}\LARGE}
  {\colorbox{NoteTeal}{\color{white}\strut\hspace{0.28em}\thechapter\hspace{0.28em}}}
  {0.65em}{}
  [\vspace{0.18em}{\color{NoteRule}\titlerule[0.7pt]}]
\titlespacing*{\chapter}{0pt}{0.55em}{0.55em}
\titleformat{\section}[hang]
  {\normalfont\sffamily\bfseries\color{NoteBlue}\large}
  {\thesection}{0.55em}{}
\titlespacing*{\section}{0pt}{0.78em}{0.22em}
\titleformat{\subsection}[hang]
  {\normalfont\sffamily\bfseries\color{NoteNavy}\normalsize}
  {\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{0.56em}{0.12em}
\titleformat{\subsubsection}[hang]
  {\normalfont\sffamily\bfseries\color{NoteMuted}\normalsize}
  {\thesubsubsection}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{0.48em}{0.10em}
\renewcommand{\theparagraph}{\arabic{paragraph}}
\titleformat{\paragraph}[block]
  {\normalfont\sffamily\bfseries\color{NoteInk}\normalsize}
  {\theparagraph.}{0.45em}{}
\titlespacing*{\paragraph}{0pt}{0.48em}{0.08em}
\titleformat{\subparagraph}[runin]
  {\normalfont\sffamily\bfseries\color{NoteTeal}}
  {}{0pt}{}
\titlespacing*{\subparagraph}{0pt}{0.10em}{0.55em}
\pretocmd{\section}{\Needspace{3.5\baselineskip}}{}{}
\pretocmd{\subsection}{\Needspace{2.8\baselineskip}}{}{}
\pretocmd{\paragraph}{\Needspace{5\baselineskip}}{}{}

% -----------------------------------------------------------------------------
% Page furniture: restrained running head, outside page number.
% -----------------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\small\sffamily\color{NoteMuted}\leftmark}
\fancyhead[RO]{\small\sffamily\color{NoteMuted}\rightmark}
\fancyfoot[LE,RO]{\small\sffamily\bfseries\color{NoteTeal}\thepage}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrule}{\hbox to\headwidth{\color{NoteRule}\leaders\hrule height \headrulewidth\hfill}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[LE,RO]{\small\sffamily\bfseries\color{NoteTeal}\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}


% Compact title banner, matching the existing CarlosTexNote visual identity.
\newcommand{\cnoteheader}{学习笔记}
\renewcommand{\maketitle}{%
  \thispagestyle{empty}%
  \begin{tcolorbox}[enhanced,colback=NoteNavy,colframe=NoteNavy,boxrule=0pt,
    arc=1.8mm,left=7mm,right=7mm,top=5.5mm,bottom=5mm,
    borderline west={2.5mm}{0pt}{NoteTeal},before skip=0pt,after skip=0.8em]
    {\color{white}\sffamily\bfseries\small\cnoteheader\hfill
      \color{white!78}\normalfont\@date\par}
    \vspace{2.5mm}
    {\color{white}\sffamily\bfseries\fontsize{22}{27}\selectfont\@title\par}
    \vspace{2.5mm}
    {\color{white!80}\sffamily\large\@author\par}
  \end{tcolorbox}%
}

% The existing \tableofcontents remains available; its hierarchy is simply tighter.
\titlecontents{chapter}
  [3.8em]
  {\addvspace{0.28em}\sffamily\bfseries\color{NoteNavy}}
  {\contentslabel{3.8em}}
  {}
  {\titlerule*[0.55pc]{.}\contentspage}
\titlecontents{section}
  [2.7em]
  {\small\color{NoteInk}}
  {\contentslabel{2.7em}}
  {}
  {\titlerule*[0.55pc]{.}\contentspage}


% Optional one-page front matter: title banner + compact contents, then content.
% This avoids spending one full page on the title and another on a short ToC.
\newcommand{\cnotecontents}{%
  \par\vspace{0.45em}%
  {\sffamily\bfseries\large\color{NoteNavy}目录\par}%
  \vspace{0.28em}%
  \@starttoc{toc}%
}
\newcommand{\notefrontmatter}{%
  \maketitle
  \cnotecontents
  \thispagestyle{empty}%
  \clearpage
}

% -----------------------------------------------------------------------------
% Compact left-rail blocks. Avoid a full rounded card around every item.
% -----------------------------------------------------------------------------
\tcbset{
  note base/.style={
    enhanced,breakable,frame hidden,boxrule=0pt,sharp corners,
    left=3mm,right=2.2mm,top=1.35mm,bottom=1.45mm,boxsep=0pt,
    before skip=0.42em,after skip=0.42em,
    before upper={\setlength{\parindent}{0pt}\setlength{\parskip}{0.14em}},
  },
}
\newcommand{\note@badge}[2]{%
  {\setlength{\fboxsep}{1.7pt}\colorbox{#1}{\color{white}\sffamily\bfseries\small #2}}}
\newcommand{\note@head}[4]{%
  {\sffamily\bfseries\color{#1}#2}\hspace{0.35em}\note@badge{#1}{#3}%
  \ifstrempty{#4}{}{\hspace{0.5em}{\sffamily\bfseries\color{#1}#4}}%
  \par\vspace{0.16em}\noindent\ignorespaces}
\newcommand{\note@headplain}[3]{%
  {\sffamily\bfseries\color{#1}#2}%
  \ifstrempty{#3}{}{\hspace{0.55em}{\sffamily\bfseries\color{#1}#3}}%
  \par\vspace{0.12em}\noindent\ignorespaces}
\newcommand{\note@newcounter}[1]{%
  \newcounter{#1}[chapter]%
  \expandafter\renewcommand\csname the#1\endcsname{\thechapter.\arabic{#1}}}

\note@newcounter{definition}
\NewDocumentEnvironment{definition}{O{}}{%
  \Needspace{5\baselineskip}%
  \refstepcounter{definition}%
  \begin{tcolorbox}[note base,colback=NoteBlueBg,borderline west={1.15mm}{0pt}{NoteBlue}]
  \note@head{NoteBlue}{定义}{\thedefinition}{#1}%
}{\end{tcolorbox}}

\note@newcounter{theorem}
\NewDocumentEnvironment{theorem}{O{}}{%
  \Needspace{4\baselineskip}%
  \refstepcounter{theorem}%
  \begin{tcolorbox}[note base,colback=NoteBlueBg,borderline west={1.15mm}{0pt}{NoteNavy}]
  \note@head{NoteNavy}{定理}{\thetheorem}{#1}%
}{\end{tcolorbox}}

\note@newcounter{property}
\NewDocumentEnvironment{property}{O{}}{%
  \Needspace{3\baselineskip}%
  \refstepcounter{property}%
  \par\addvspace{0.26em}\noindent
  \note@head{NoteTeal}{性质}{\theproperty}{#1}%
}{\par\addvspace{0.18em}}

\note@newcounter{corollary}
\NewDocumentEnvironment{corollary}{O{}}{%
  \Needspace{3\baselineskip}%
  \refstepcounter{corollary}%
  \par\addvspace{0.22em}\noindent
  \note@head{NoteTeal}{推论}{\thecorollary}{#1}%
}{\par\addvspace{0.16em}}

\note@newcounter{lemma}
\NewDocumentEnvironment{lemma}{O{}}{%
  \Needspace{4\baselineskip}%
  \refstepcounter{lemma}%
  \begin{tcolorbox}[note base,colback=NoteTealBg,borderline west={1.05mm}{0pt}{NoteTeal}]
  \note@head{NoteTeal}{引理}{\thelemma}{#1}%
}{\end{tcolorbox}}

\note@newcounter{proposition}
\NewDocumentEnvironment{proposition}{O{}}{%
  \Needspace{4\baselineskip}%
  \refstepcounter{proposition}%
  \begin{tcolorbox}[note base,colback=NoteTealBg,borderline west={1.05mm}{0pt}{NoteTeal}]
  \note@head{NoteTeal}{命题}{\theproposition}{#1}%
}{\end{tcolorbox}}

\note@newcounter{example}
\NewDocumentEnvironment{example}{O{}}{%
  \Needspace{5\baselineskip}%
  \refstepcounter{example}%
  \begin{tcolorbox}[note base,colback=NoteGoldBg,borderline west={1.15mm}{0pt}{NoteGold},before skip=0.36em,after skip=0.20em]
  \note@head{NoteGold}{例题}{\theexample}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{solution}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[enhanced,breakable,blanker,borderline west={0.75pt}{0pt}{NoteRule},
    left=3mm,right=1mm,top=0.3mm,bottom=0.3mm,boxsep=0pt,
    before skip=0.18em,after skip=0.42em,
    before upper={\setlength{\parindent}{0pt}\setlength{\parskip}{0.14em}}]
  \note@headplain{NoteMuted}{解}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{remark}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[enhanced,breakable,blanker,borderline west={0.75pt}{0pt}{NoteMuted},
    left=3mm,right=1mm,top=0.3mm,bottom=0.3mm,boxsep=0pt,
    before skip=0.28em,after skip=0.36em]
  \note@headplain{NoteMuted}{注}{#1}%
}{\end{tcolorbox}}

\newcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\NewDocumentEnvironment{proof}{O{}}{%
  \par\Needspace{2.5\baselineskip}\noindent
  {\sffamily\bfseries\color{NoteInk}证明}%
  \ifstrempty{#1}{}{\hspace{0.45em}{\sffamily\color{NoteMuted}#1}}%
  \hspace{0.35em}\ignorespaces
}{\hfill\qedsymbol\par}

\NewDocumentEnvironment{keybox}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[note base,breakable,colback=NoteTealBg,borderline west={1.1mm}{0pt}{NoteTeal}]
  \note@headplain{NoteTeal}{重点}{#1}%
}{\end{tcolorbox}}
\NewDocumentEnvironment{warningbox}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[note base,breakable,colback=NoteRedBg,borderline west={1.1mm}{0pt}{NoteRed}]
  \note@headplain{NoteRed}{易错}{#1}%
}{\end{tcolorbox}}
\NewDocumentEnvironment{methodbox}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[note base,breakable,colback=NoteBlueBg,borderline west={1.1mm}{0pt}{NoteBlue}]
  \note@headplain{NoteBlue}{方法}{#1}%
}{\end{tcolorbox}}
\NewDocumentEnvironment{summarybox}{O{}}{%
  \Needspace{3\baselineskip}%
  \begin{tcolorbox}[note base,breakable,colback=NoteGoldBg,borderline west={1.1mm}{0pt}{NoteGold}]
  \note@headplain{NoteGold}{小结}{#1}%
}{\end{tcolorbox}}
\NewDocumentEnvironment{recallbox}{O{}}{%
  \Needspace{4\baselineskip}%
  \begin{tcolorbox}[note base,breakable,colback=NoteGoldBg,borderline west={1.1mm}{0pt}{NoteGold},
    before skip=0.5em,after skip=0.5em]
  \note@headplain{NoteGold}{闭卷提取}{#1}%
}{\end{tcolorbox}}

\NewDocumentCommand{\keyword}{m}{\textcolor{NoteTeal}{\bfseries #1}}
\NewDocumentCommand{\cue}{m}{\textcolor{NoteMuted}{\sffamily\bfseries #1}}

% Chinese autoref names and math macros retained from CarlosTexNote.
\def\chapterautorefname{章}
\def\sectionautorefname{节}
\def\subsectionautorefname{小节}
\def\equationautorefname{式}
\def\figureautorefname{图}
\def\tableautorefname{表}
\def\definitionautorefname{定义}
\def\theoremautorefname{定理}
\def\propertyautorefname{性质}
\def\corollaryautorefname{推论}
\def\lemmaautorefname{引理}
\def\propositionautorefname{命题}
\def\exampleautorefname{例题}
\numberwithin{equation}{chapter}\numberwithin{figure}{chapter}\numberwithin{table}{chapter}
% Upright differential d, compatible with the original CarlosTexNote class.
\def\dif{\mathop{}\hphantom{\mskip-\thinmuskip}\mathrm{d}}%
\let\daccent\d
\let\d\relax
\newcommand\d{\ifmmode\dif\else\expandafter\daccent\fi}
\providecommand{\rank}{\operatorname{rank}}
\providecommand{\diag}{\operatorname{diag}}
\newcommand{\R}{\ensuremath{\mathbb{R}}}
\newcommand{\N}{\ensuremath{\mathbb{N}}}
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}
\newcommand{\C}{\ensuremath{\mathbb{C}}}
\renewcommand{\O}{\ensuremath{\varnothing}}

\endinput