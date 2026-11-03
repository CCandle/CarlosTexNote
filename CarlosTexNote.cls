% -----------------------------------------------------------------------------
% CarlosTexNote.cls — Chinese XeLaTeX study-note class by Carlos QU
%
% Visual language follows CarlosTexRpt; theorem environments and callout boxes
% follow the semantic-box approach of carlosreport.cls and markdown callouts.
% XeLaTeX only.
% -----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CarlosTexNote}[2026/11/03 v0.1.0 Study notes class by Carlos QU]

\RequirePackage{iftex}
\RequireXeTeX

% -----------------------------------------------------------------------------
% Options
% -----------------------------------------------------------------------------
\newif\ifcarlostexnote@circuit
\carlostexnote@circuitfalse
\DeclareOption{circuit}{\carlostexnote@circuittrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexrep}}
\ProcessOptions\relax

\LoadClass[UTF8,zihao=-4,twoside,openany]{ctexrep}

% -----------------------------------------------------------------------------
% Page geometry and body typography
% -----------------------------------------------------------------------------
\RequirePackage[a4paper,twoside,inner=3cm,outer=2.5cm,top=2.2cm,bottom=2.2cm,headheight=24pt,headsep=6mm,footskip=10mm]{geometry}
\RequirePackage{setspace}
\setstretch{1.35}
\setlength{\parindent}{2em}
\setlength{\parskip}{0.10em}
\setlength{\emergencystretch}{1.5em}
\raggedbottom
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{2}
\everymath{\displaystyle}

% -----------------------------------------------------------------------------
% Packages
% -----------------------------------------------------------------------------
\RequirePackage{amsmath,amssymb,mathtools,bm}
\allowdisplaybreaks[4]
\RequirePackage{graphicx}
\graphicspath{{img/}{fig/}{pic/}}
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{enumitem}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage{needspace}
\RequirePackage{etoolbox}
\RequirePackage{xpatch}
\RequirePackage[skins,breakable]{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{xurl}
\RequirePackage{siunitx}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,calc,angles,quotes}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\ifcarlostexnote@circuit
  \RequirePackage[europeanresistors,cuteinductors]{circuitikz}
\fi
\RequirePackage[unicode,colorlinks=true,linkcolor=black,anchorcolor=black,citecolor=black,urlcolor=black,pdfborder={0 0 0},bookmarksnumbered=true]{hyperref}
\RequirePackage{bookmark}

% Suppress the noisy fontspec/xeCJK script warnings (same trick as CarlosTexArt).
\ExplSyntaxOn
\xpatchcmd\__xeCJK_check_family:n{\__xeCJK_warning:nxx}{\__xeCJK_info:nxx}{}{}
\xpatchcmd\fontspec_new_script:nn
  {\__fontspec_warning:nxx}
  {\__fontspec_info:nxx}
  {}{}
\newfontscript{CJK}{hani}
\ExplSyntaxOff

% -----------------------------------------------------------------------------
% Palette
% -----------------------------------------------------------------------------
\definecolor{CarlosNavy}{HTML}{18384F}
\definecolor{CarlosBlue}{HTML}{236A91}
\definecolor{CarlosTeal}{HTML}{2A9D8F}
\definecolor{CarlosGold}{HTML}{E9A23B}
\definecolor{CarlosWarm}{HTML}{B7792B}
\definecolor{CarlosRed}{HTML}{A84C4C}
\definecolor{CarlosInk}{HTML}{26323B}
\definecolor{CarlosMuted}{HTML}{667681}
\definecolor{CarlosRule}{HTML}{D7E0E5}
\definecolor{CarlosPanel}{HTML}{F3F7F8}
\color{CarlosInk}

% -----------------------------------------------------------------------------
% Captions, tables, lists, units
% -----------------------------------------------------------------------------
\captionsetup{font=small,labelfont={bf,color=CarlosBlue},textfont={color=CarlosInk},labelsep=quad,skip=5pt}
\renewcommand{\arraystretch}{1.15}
\AtBeginEnvironment{table}{\small}
\AtBeginEnvironment{longtable}{\small}
\setlist[itemize,1]{label=\textcolor{CarlosTeal}{\small$\blacktriangleright$},leftmargin=1.75em,topsep=0.28em,itemsep=0.12em,parsep=0pt,partopsep=0pt}
\setlist[itemize,2]{label=\textcolor{CarlosGold}{\scriptsize$\blacktriangleright$},leftmargin=1.55em,topsep=0.2em,itemsep=0.08em,parsep=0pt}
\setlist[enumerate,1]{label=\textcolor{CarlosBlue}{\bfseries\arabic*.},leftmargin=2em,topsep=0.28em,itemsep=0.12em,parsep=0pt,partopsep=0pt}
\sisetup{detect-all,per-mode=symbol,range-phrase=--,range-units=single}

% -----------------------------------------------------------------------------
% Headings
% -----------------------------------------------------------------------------
\ctexset{
  chapter = {name={},number=\arabic{chapter},afterindent=true},
  appendix = {name={附录\ },number=\Alph{chapter}},
  section = {afterindent=true},
  subsection = {afterindent=true},
  subsubsection = {afterindent=true},
  paragraph = {
    format = \zihao{-4}\heiti,
    name = {},
    number = \arabic{paragraph},
    aftername = .\hspace{0.5em},
    runin = true,
    indent = 2em,
    beforeskip = 0.7em,
    afterskip = 0.35em,
  },
}

\titleformat{\chapter}[block]
  {\normalfont\sffamily\bfseries\color{CarlosNavy}\LARGE}
  {\colorbox{CarlosTeal}{\color{white}\strut\hspace{0.25em}\thechapter\hspace{0.25em}}}
  {0.7em}
  {}
  [\vspace{0.25em}{\color{CarlosRule}\titlerule[0.8pt]}]
\titlespacing{\chapter}{0pt}{1.3em}{0.8em}

\titleformat{\section}[hang]
  {\normalfont\sffamily\bfseries\color{CarlosBlue}\large}
  {\thesection}{0.7em}{}
\titlespacing{\section}{0pt}{1.05em}{0.38em}

\titleformat{\subsection}[hang]
  {\normalfont\sffamily\bfseries\color{CarlosNavy}\normalsize}
  {\thesubsection}{0.65em}{}
\titlespacing{\subsection}{0pt}{0.85em}{0.25em}

\titleformat{\subsubsection}[hang]
  {\normalfont\sffamily\bfseries\color{CarlosMuted}\normalsize}
  {\thesubsubsection}{0.6em}{}
\titlespacing{\subsubsection}{0pt}{0.7em}{0.2em}

\pretocmd{\section}{\Needspace{4\baselineskip}}{}{}
\pretocmd{\subsection}{\Needspace{3\baselineskip}}{}{}

% Compact table of contents
\titlecontents{chapter}
  [2.6em]
  {\addvspace{0.35em}\sffamily\bfseries\color{CarlosNavy}}
  {\contentslabel{2.6em}}
  {}
  {\titlerule*[0.55pc]{.}\contentspage}
\titlecontents{section}
  [2.2em]
  {\small\color{CarlosInk}}
  {\contentslabel{2.7em}}
  {}
  {\titlerule*[0.55pc]{.}\contentspage}

% -----------------------------------------------------------------------------
% Page furniture
% -----------------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\small\sffamily\color{CarlosMuted}\leftmark}
\fancyhead[RO]{\small\sffamily\color{CarlosMuted}\rightmark}
\fancyfoot[LE,RO]{\sffamily\bfseries\color{CarlosTeal}\thepage}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrule}{\hbox to\headwidth{\color{CarlosRule}\leaders\hrule height \headrulewidth\hfill}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[LE,RO]{\sffamily\bfseries\color{CarlosTeal}\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

% -----------------------------------------------------------------------------
% Title block (compact, no full cover page)
% -----------------------------------------------------------------------------
\makeatletter
\newcommand{\cnoteheader}{学习笔记}
\renewcommand{\maketitle}{%
  \thispagestyle{empty}%
  \begin{tcolorbox}[enhanced,colback=CarlosNavy,colframe=CarlosNavy,boxrule=0pt,arc=2.2mm,left=8mm,right=8mm,top=7mm,bottom=6.5mm,borderline west={3mm}{0pt}{CarlosTeal},before skip=0pt,after skip=1.1em]
    {\color{white}\sffamily\bfseries\small\cnoteheader\hfill\color{white!78}\normalfont\@date\par}
    \vspace{3.5mm}
    {\color{white}\sffamily\bfseries\fontsize{24}{30}\selectfont\@title\par}
    \vspace{4mm}
    {\color{white!80}\sffamily\large\@author\par}
  \end{tcolorbox}%
}

% -----------------------------------------------------------------------------
% Box infrastructure
% -----------------------------------------------------------------------------
\tcbset{
  carlos box/.style={
    enhanced,breakable,
    boxrule=0.45pt,arc=1.2mm,
    left=4mm,right=4mm,top=3mm,bottom=3mm,
    before skip=0.9em,after skip=0.85em,
  },
}

\newcommand{\carlos@badge}[2]{%
  \colorbox{#1}{\color{white}\sffamily\bfseries\small\,\strut #2\,}}
\newcommand{\carlos@label}[2]{{\sffamily\bfseries\color{#1}#2}}

% #1 colour, #2 label, #3 number, #4 optional title
\NewDocumentCommand{\carlos@head}{m m m m}{%
  \carlos@label{#1}{#2}\hspace{0.45em}\carlos@badge{#1}{#3}%
  \ifstrempty{#4}{}{\hspace{0.45em}{\sffamily\bfseries\color{#1}（#4）}}%
  \par\vspace{0.25em}\noindent\ignorespaces
}
% #1 colour, #2 label, #3 optional title
\NewDocumentCommand{\carlos@headplain}{m m m}{%
  \carlos@label{#1}{#2}%
  \ifstrempty{#3}{}{\hspace{0.45em}{\sffamily\bfseries\color{#1}（#3）}}%
  \par\vspace{0.25em}\noindent\ignorespaces
}

% -----------------------------------------------------------------------------
% Numbered theorem-like environments (independent counters, numbered per chapter)
% -----------------------------------------------------------------------------
\newcommand{\carlostex@newnumbered}[1]{%
  \newcounter{#1}[chapter]%
  \expandafter\renewcommand\csname the#1\endcsname{\thechapter.\arabic{#1}}%
}

\carlostex@newnumbered{definition}
\NewDocumentEnvironment{definition}{O{}}{%
  \refstepcounter{definition}%
  \begin{tcolorbox}[carlos box,colback=CarlosBlue!4!white,colframe=CarlosBlue!45!white,borderline west={1.4mm}{0pt}{CarlosBlue}]
  \carlos@head{CarlosBlue}{定义}{\thedefinition}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{theorem}
\NewDocumentEnvironment{theorem}{O{}}{%
  \refstepcounter{theorem}%
  \begin{tcolorbox}[carlos box,colback=CarlosNavy!4!white,colframe=CarlosNavy!45!white,borderline west={1.4mm}{0pt}{CarlosNavy}]
  \carlos@head{CarlosNavy}{定理}{\thetheorem}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{property}
\NewDocumentEnvironment{property}{O{}}{%
  \refstepcounter{property}%
  \begin{tcolorbox}[carlos box,colback=CarlosTeal!5!white,colframe=CarlosTeal!40!white,borderline west={1.4mm}{0pt}{CarlosTeal}]
  \carlos@head{CarlosTeal}{性质}{\theproperty}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{corollary}
\NewDocumentEnvironment{corollary}{O{}}{%
  \refstepcounter{corollary}%
  \begin{tcolorbox}[carlos box,colback=CarlosTeal!5!white,colframe=CarlosTeal!40!white,borderline west={1.4mm}{0pt}{CarlosTeal}]
  \carlos@head{CarlosTeal}{推论}{\thecorollary}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{lemma}
\NewDocumentEnvironment{lemma}{O{}}{%
  \refstepcounter{lemma}%
  \begin{tcolorbox}[carlos box,colback=CarlosTeal!5!white,colframe=CarlosTeal!40!white,borderline west={1.4mm}{0pt}{CarlosTeal}]
  \carlos@head{CarlosTeal}{引理}{\thelemma}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{proposition}
\NewDocumentEnvironment{proposition}{O{}}{%
  \refstepcounter{proposition}%
  \begin{tcolorbox}[carlos box,colback=CarlosTeal!5!white,colframe=CarlosTeal!40!white,borderline west={1.4mm}{0pt}{CarlosTeal}]
  \carlos@head{CarlosTeal}{命题}{\theproposition}{#1}%
}{\end{tcolorbox}}

\carlostex@newnumbered{example}
\NewDocumentEnvironment{example}{O{}}{%
  \refstepcounter{example}%
  \begin{tcolorbox}[carlos box,after skip=0.45em,colback=CarlosWarm!4!white,colframe=CarlosWarm!45!white,borderline west={1.4mm}{0pt}{CarlosWarm}]
  \carlos@head{CarlosWarm}{例题}{\theexample}{#1}%
}{\end{tcolorbox}}

% -----------------------------------------------------------------------------
% Unnumbered environments
% -----------------------------------------------------------------------------
\NewDocumentEnvironment{remark}{O{}}{%
  \begin{tcolorbox}[carlos box,colback=CarlosMuted!5!white,colframe=CarlosMuted!40!white,borderline west={1.4mm}{0pt}{CarlosMuted}]
  \carlos@headplain{CarlosMuted}{注}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{solution}{O{}}{%
  \begin{tcolorbox}[enhanced,breakable,boxrule=0.4pt,arc=1.2mm,
    colback=CarlosPanel,colframe=CarlosRule,
    left=4mm,right=4mm,top=2.8mm,bottom=2.8mm,
    before skip=0pt,after skip=0.85em,
    borderline west={1.4mm}{0pt}{CarlosMuted}]
  \carlos@headplain{CarlosMuted}{解}{#1}%
}{\end{tcolorbox}}

\newcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\NewDocumentEnvironment{proof}{O{}}{%
  \par\needspace{3\baselineskip}\noindent
  {\sffamily\bfseries\color{CarlosInk}证明}%
  \ifstrempty{#1}{}{\hspace{0.3em}{\sffamily\color{CarlosMuted}（#1）}}%
  \hspace{0.4em}\ignorespaces
}{\hfill\qedsymbol\par}

% -----------------------------------------------------------------------------
% Callout boxes (markdown-callout style)
% -----------------------------------------------------------------------------
\NewDocumentEnvironment{keybox}{O{}}{%
  \begin{tcolorbox}[carlos box,colback=CarlosTeal!5!white,colframe=CarlosTeal!40!white,borderline west={1.4mm}{0pt}{CarlosTeal}]
  \carlos@headplain{CarlosTeal}{重点}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{warningbox}{O{}}{%
  \begin{tcolorbox}[carlos box,colback=CarlosRed!5!white,colframe=CarlosRed!40!white,borderline west={1.4mm}{0pt}{CarlosRed}]
  \carlos@headplain{CarlosRed}{易错}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{methodbox}{O{}}{%
  \begin{tcolorbox}[carlos box,colback=CarlosBlue!5!white,colframe=CarlosBlue!40!white,borderline west={1.4mm}{0pt}{CarlosBlue}]
  \carlos@headplain{CarlosBlue}{方法}{#1}%
}{\end{tcolorbox}}

\NewDocumentEnvironment{summarybox}{O{}}{%
  \begin{tcolorbox}[carlos box,colback=CarlosWarm!5!white,colframe=CarlosWarm!40!white,borderline west={1.4mm}{0pt}{CarlosWarm}]
  \carlos@headplain{CarlosWarm}{小结}{#1}%
}{\end{tcolorbox}}

% -----------------------------------------------------------------------------
% Numbering and cross-references
% -----------------------------------------------------------------------------
\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
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

% -----------------------------------------------------------------------------
% Math macros expected by the shipped UltiSnips snippets
% -----------------------------------------------------------------------------
% Upright differential: \d works in math mode and keeps the original accent in text.
\def\dif{\mathop{}\hphantom{\mskip-\thinmuskip}\mathrm{d}}%
\let\daccent\d
\let\d\relax
\newcommand\d{\ifmmode\dif\else\expandafter\daccent\fi}
\newcommand{\R}{\ensuremath{\mathbb{R}}}
\newcommand{\N}{\ensuremath{\mathbb{N}}}
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}
\newcommand{\C}{\ensuremath{\mathbb{C}}}
% \O is the empty set in math mode (the text symbol Ø is not needed in notes).
\renewcommand{\O}{\ensuremath{\varnothing}}

\makeatother

\endinput
