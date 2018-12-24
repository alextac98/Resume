\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%% v1.4: Detect TL2018 to handle accented characters in class information
\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}

\ProvidesClass{Resume}[2018/12/01 Resume v1.0.0, Resume class for Alex Tacescu]

%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}

%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}

%% v1.1.5: added for convenience
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

%% Handle different versions of academicons
\if@academicons
  \ifxetexorluatex
    \RequirePackage{fontspec}
    %% academicons in TL2018 doesn't require
    %% Academicons to be installed in OS fonts
    %% so can be loaded directly
    \@ifl@t@r\fmtversion{2018/04/01}{%
      \RequirePackage{academicons}
    }{%
      % TL2017
      \@ifl@t@r\fmtversion{2017/04/01}{%
        \@ifpackagelater{academicons}{2018/03/01}{%
          \RequirePackage{academicons}
        }{%
          \let\ori@newfontfamily\newfontfamily%
          \renewcommand{\newfontfamily}[2]{}
          \RequirePackage{academicons}
          \let\newfontfamily\ori@newfontfamily
          \newfontfamily{\AI}{academicons.ttf}
        }
      }{% TL2016 requires the package to be loaded before
        % the version can be checked. Only added because
        % Overleaf v1 still runs TL2016; will be removed
        % when v1 is completely retired.
          \let\ori@newfontfamily\newfontfamily%
          \renewcommand{\newfontfamily}[2]{}
          \RequirePackage{academicons}
          \let\newfontfamily\ori@newfontfamily
          \newfontfamily{\AI}{academicons.ttf}
      }
    }
  \else
    \ClassError{Resume}{academicons unsupported by latex or pdflatex. Please compile with xelatex or lualatex}{Please compile with xelatex or lualatex to use the academicons option}
  \fi
\fi

\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\RequirePackage{calc}
\usetikzlibrary{arrows}
\RequirePackage[skins,breakable]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
\RequirePackage{hyperref}
\RequirePackage{paracol}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{heading}{\normalfont #1}\hspace{0.5em}#2}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\phone}[1]{\def\@phone{\printinfo{\phonesymbol}{#1}}}
\newcommand{\email}[1]{\def\@email{\href{mailto:#1}{\printinfo{\mailsymbol}{#1}}}}
\newcommand{\website}[1]{\def\@website{\href{https://#1}{\printinfo{\homepagesymbol}{#1}}}}

\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{#1}}
\newcommand{\github}[1]{\printinfo{\githubsymbol}{#1}}
\newcommand{\orcid}[1]{\printinfo{\orcidsymbol}{#1}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\newcommand{\makeheading}{
  \begingroup
    \color{heading}\huge\centering\bfseries\MakeUppercase{\@name} \\[-0.6\baselineskip]
    \color{heading}\rule{\linewidth}{2pt}\par
    \medskip
    \begin{minipage}{0.32\textwidth}
        \large\bfseries\centering{\@phone}
    \end{minipage}%
    \begin{minipage}{0.02\textwidth}
       \vline height 20pt depth 0pt width 2pt
    \end{minipage}%
    \begin{minipage}{0.34\textwidth}
        \large\bfseries\centering{\@email}
    \end{minipage}%
    \begin{minipage}{0.02\textwidth}
        \vline height 20pt depth 0pt width 2pt
    \end{minipage}%
    \begin{minipage}{0.31\textwidth}
        \large\bfseries\centering{\@website}
    \end{minipage}
  \endgroup
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\resumesection}[2]{
    \smallskip\noindent
    {\color{heading}\large\bfseries\MakeUppercase{#1} \hfill \color{heading}\normalsize\bfseries{#2}} \\[-0.6\baselineskip]
    {\color{heading}\rule{\linewidth}{1pt}}
}

\newcommand{\resumesubsection}[1]{%
	{\color{emphasis}\bfseries{#1}}
}

\newcommand{\skillsection}[2]{
    \resumesubsection{#1:} {#2}
}

% 1 = Degree | 2 = College | 3 = Dates | 4 = GPA
\newcommand{\school}[4]{
	{\large\color{emphasis}#1\par}
	\normalsize
	\ifstrequal{#2}{}{}{
		\textbf{\color{accent}#2}\par
		\smallskip}
	\ifstrequal{#3}{}{}{\small{Graduation: #3}} \hfill \ifstrequal{#4}{}{}{{\small{GPA: #4}}}\par
	\medskip\normalsize
	
	
}

% Skills Circle
\newlength{\outerskill}
\newlength{\innerskill}
\setlength{\outerskill}{0.9cm}
\setlength{\innerskill}{0.8cm}
\newcommand{\skillcircle}[2]{
  \begin{tikzpicture}
    \fill[black!80] (0,0) circle (\outerskill);
    \fill[accent!70,draw=white,line width=2pt] (0,0) -- (0, \outerskill+1pt)
      arc (90:90-3.6*#1:\outerskill+1pt) -- (0,0);
    \fill[white] (0,0) circle (\innerskill);
    \node[align=center, text width = 2*\innerskill] (0,0) { #2};
  \end{tikzpicture}
}

% 1 = Job Title | 2 = Company | 3 = Time | 4 = Location
\newcommand{\job}[4]{%
  {\large\color{emphasis}#1\par}
  \smallskip\normalsize
  \ifstrequal{#2}{}{}{
  \textbf{\color{accent}#2}\par
  \smallskip}
  \ifstrequal{#3}{}{}{{\small\makebox[0.5\linewidth][l]{\faCalendar\hspace{0.5em}#3}}}%
  \ifstrequal{#4}{}{}{{\small\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#4}}}\par
  \medskip\normalsize
}

\newcommand{\project}[3]{
	{\resumesubsection{#2: #1} \normalsize\color{body}#3}\\
}

\newcommand{\leadership}[2]{
	\resumesubsection{#1 } {#2}
}

\AtBeginDocument{%
  	\pagestyle{empty}
  	\color{body}
	\justify
}
