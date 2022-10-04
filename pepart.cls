%%%%%%%%%
% Template for article-style documents
% Based on the acp class by Alex Povel
%%%%%%%%%

% Class Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pepart}[peparticle class]

% Fail early and give useful information on the required engine.
% This helps users who do not read the documentation beforehand, by promoting the
% requirement from some statement in the docs to actual code that errors out.
\RequirePackage{iftex}
\RequireLuaTeX{}

\newcommand*{\@baseclass}{scrartcl}% Name of class this one is based on


% If option 'language' is not given at all, use initialization 'english' as a fallback.
% If it is called without a value, use default (or throw error of no default given)
% This method was chosen to have the language available in a macro, so it may be passed
% to polyglossia.
% This approach messes with the forwarding of the language and raises a warning
% 'Unused global options'; we can probably ignore that for now
% (https://tex.stackexchange.com/a/278172/120853).
\RequirePackage{kvoptions}
    %[default]{language} % If no default entered: option requires a value:
    \DeclareStringOption[english]{language}
    \DeclareStringOption{titlestyle}
    \DeclareBoolOption{censoring}% Initially false by default
    \ProcessKeyvalOptions*

\PassOptionsToClass{%
    \pepart@language,% Scheme: \filename@keyoption
    listof=totoc,
    bibliography=totoc,
    chapterprefix=true,% Print 'Chapter' etc. label in front of number
    numbers=noenddot,% https://tex.stackexchange.com/a/102305/120853
}{\@baseclass}


% Bundle 'a5' to not only have a5paper but also decrease font size.
% https://tex.stackexchange.com/a/418947/120853
% https://tex.stackexchange.com/a/27149/120853
\DeclareOption{a4}{%
    % Not forwarded to typearea package if passed as class option: do it manually here:
    \PassOptionsToPackage{paper=a5}{typearea}
    \PassOptionsToClass{fontsize=10pt}{\@baseclass}%
}%

% Forward all other options given to \documentclass[] to base class:
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}}

\ProcessOptions\relax% Execute these options

\LoadClass{\@baseclass}% Finally, load the base class

\RequirePackage[\pepart@language]{tracklang}% Language Tracking

% Typography and Misc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{scrhack}% Fixes for packages incompatible with KOMA features

\RequirePackage{import}% Relative path imports

\RequirePackage[super]{nth}% For ordinal numbers, like \nth{1} -> 1^{st}

\RequirePackage{etoolbox}% Programming facilities

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Providing localization that are not automatically covered by polyglossia.
% The commands are provided by KOMAscript.
% Maintaining the list is not the easiest, but currently likely the best approach.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colophon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecaptionname{english}{\TransCompiledOn}{Compiled on}
\providecaptionname{german}{\TransCompiledOn}{Kompiliert am}

\providecaptionname{english}{\TransLatexClass}{Class}
\providecaptionname{german}{\TransLatexClass}{Klasse}

\providecaptionname{english}{\TransGenerator}{Generator}
\providecaptionname{german}{\TransGenerator}{Generiert durch}

\providecaptionname{english}{\TransCensorNotice}{CENSORED VERSION}
\providecaptionname{german}{\TransCensorNotice}{ZENSIERTE VERSION}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecaptionname{english}{\TransPlaceDate}{Place \& Date}
\providecaptionname{german}{\TransPlaceDate}{Ort \& Datum}

\providecaptionname{english}{\TransTopic}{Topic}
\providecaptionname{german}{\TransTopic}{Thema}

\providecaptionname{english}{\TransTask}{Task}
\providecaptionname{german}{\TransTask}{Problemstellung}

\providecaptionname{english}{\TransFor}{For}
\providecaptionname{german}{\TransFor}{Für}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tweaks and improvements for amsmath; also loads amsmath.
% Needs to be loaded before unicode-math!
\RequirePackage{mathtools}
    % We want to be cool, so standard parantheses don't cut it:
    \newtagform{brackets}{[}{]}
    \usetagform{brackets}

    % Allow multi-line environments to break across pages.
    % While it makes sense to disallow it, not doing so can produce big spacing issues.
    % Usually, any such environment will require manual attention.
    % Number from 1 to 4 as optional argument:
    % [1]: allow pagebreaks, but avoid as much as possible.
    % [4]: maximum permissiveness
    \allowdisplaybreaks[2]

    % Automatic macro for delimiters (parentheses, brackets, ...)
    % Using the starred variant of the created command (like \parens*{<content>})
    % also scales the delimiters automatically, using \left and \right.
    \DeclarePairedDelimiter{\parens}{(}{)}
    \DeclarePairedDelimiter{\brackets}{[}{]}
    \DeclarePairedDelimiter{\braces}{\{}{\}}

% For a 'cases' environment that also supports equation numbering,
% https://tex.stackexchange.com/a/180910/120853
\RequirePackage{empheq}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colour
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load this before unicode-math font specifications to make colors available there
\RequirePackage[x11names]{xcolor}% x11names provides some usable default names
    % Shades of grey (we don't need 50 though)
    % This is nice to have consistent color shading.
    \colorlet{g1}{black!70}
    \colorlet{g2}{black!55}
    \colorlet{g3}{black!40}
    \colorlet{g4}{black!20}
    \colorlet{g5}{black!10}
    \colorlet{g6}{black!05}

    % Different fluids/materials.
    \definecolor{Glass}{RGB}{170, 238, 255}% Very light blue
    \definecolor{Air}{RGB}{213, 246, 255}% Light blue
    \definecolor{LightFluid}{RGB}{148, 224, 255}
    \definecolor{MediumFluid}{RGB}{135, 178, 232}
    \definecolor{DarkFluid}{RGB}{119, 151, 197}
    \definecolor{HotFluid}{RGB}{255, 128, 128}% 255/128/128 is same as 'red!50'

    % Dark blue link color:
    \definecolor{darklink}{RGB}{48, 62, 116}%

    % From colorbrewer's RdYlBu: from red (1) to blue (6)
    \definecolor{rdylbu1}{RGB}{215,  48,  39}%
    \definecolor{rdylbu2}{RGB}{252, 141,  89}%
    \definecolor{rdylbu3}{RGB}{254, 224, 144}%
    \definecolor{rdylbu4}{RGB}{224, 243, 248}%
    \definecolor{rdylbu5}{RGB}{145, 191, 219}%
    \definecolor{rdylbu6}{RGB}{ 69, 117, 180}%

    % From colorbrewer's Set2 for qualitative data/color discernibility
    \definecolor{Set2A}{RGB}{102, 194, 165}%
    \definecolor{Set2B}{RGB}{252, 141,  98}%
    \definecolor{Set2C}{RGB}{141, 160, 203}%
    \definecolor{Set2D}{RGB}{231, 138, 195}%
    \definecolor{Set2E}{RGB}{166, 216,  84}%
    \definecolor{Set2F}{RGB}{255, 217,  47}%
    \definecolor{Set2G}{RGB}{229, 196, 148}%
    \definecolor{Set2H}{RGB}{179, 179, 179}%

    % Matlab colours:
    \definecolor{mBlue}{HTML}{0072BD}
    \definecolor{mOrange}{HTML}{D95319}
    \definecolor{mYellow}{HTML}{EDB120}
    \definecolor{mPurple}{HTML}{7E2F8E}
    \definecolor{mGreen}{HTML}{77AC30}
    \definecolor{mSky}{HTML}{4DBEEE}
    \definecolor{mRed}{HTML}{A2142F}

    % Code annotations:
    \definecolor{cRed}{RGB}{209,0,86}%
    \definecolor{cBlue}{RGB}{0, 130, 185}%
    \definecolor{cGreen}{RGB}{0, 128, 63}%
    \definecolor{cOrange}{RGB}{244, 131, 66}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typeset code snippets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% minted is a Python-based syntax highlighter and therefore much, much more powerful
% than anything LaTeX-built-in
\RequirePackage[%
    % `minted` uses the `float` package to provide the `[H]` float position specifier.
    % Sadly, the `float` package is incompatible with `floatrow`, which we make heavy
    % use of. Luckily, we can use `minted` with the `newfloat` package instead, fixing
    % all those otherwise breaking issues.
    % See https://tex.stackexchange.com/a/378588/120853
    newfloat=true,%
]{minted}

    \setminted{% Global `minted` aka code syntax highlighting options
        % If code is indented in the LaTeX source, this is reflected in the print.
        % This option automatically removes as much whitespace as the first line of a listing
        % is indented by (note: requires `python` to be available, not only `pygmentize`)
        autogobble=true,
        %
        % Assuming the code to be displayed is written at 80-90 characters per line,
        % \footnotesize makes sure it fits onto one line (roughly).
        fontsize=\footnotesize,
        %
        breaklines=true,
        breakanywhere=false, % default "false"; could be ugly, only use if required
        breakbytokenanywhere=true, % Breaks tokens on non-spaces too
        %
        % Regular LaTeX can occur in these (on UK Keyboard: SHIFT+`).
        % Otherwise, you'll have to copy-paste this whenever needed.
        % The problem is that the escapechar has to be quite exotic so it never occurs
        % in source code.
        escapeinside=¬¬,
        %
        frame=leftline, % leftline pulls it together visually quite nicely
        framerule=1pt, % default is 0.4pt
        rulecolor=\color{g3},
        %
        numbers=left,
        numberfirstline=true, % Always color the first line despite `stepnumber` setting
        stepnumber=5, % Interval of line numbering
        numbersep=2pt, % Horizontal distance between line number and line
        %
        % Used highlighting style, see https://pygments.org/demo/#try or `python -m pygments -L`
        % For colorful output, I like:
        % `paraiso-light` (prob. too light for print), `manni`, `tango`, `lovelace`
        % For grayscale:
        % `algol`
        style=manni,
    }

    \setmintedinline{% Overwrite `\setminted` settings
        fontsize=auto,% Reset to surrounding font size so its fits into the text flow
    }

    % Set up the floating environment, e.g. what is says in the caption of floats:
    \SetupFloatingEnvironment{listing}{% Requires `newfloat` usage
        name=\TransListing{},
        listname=\TransListOfListings{},
    }
    % Create a new environment for breaking code listings across pages.
    \newenvironment{longlisting}{\captionsetup{type=listing}}{}
    % Setup for referencing the floats correctly is done in `cleveref` settings!

    % In code environments, to be able to copy from the PDF (despite that not being a good
    % idea usually), we want the line numbers to not be part of the selection.
    % This command prints them, but renders the actual copied content empty,
    % on supported readers like Adobe Acrobat.
    \RequirePackage{accsupp}% https://tex.stackexchange.com/a/57160/120853

    \newcommand*{\emptyaccsupp}[1]{%
        \BeginAccSupp{ActualText={}}#1\EndAccSupp{}%
    }%

    \renewcommand*{\theFancyVerbLine}{ % Redefine how line numbers are printed
        \textcolor{g3}{\ttfamily\tiny\emptyaccsupp{\arabic{FancyVerbLine}}}
    }

    % Colors for escaped, normal LaTeX in code environments
    \newcommand*{\phstring}[1]{%
        \textcolor{cRed}{#1}%
    }%
    \newcommand*{\phnum}[1]{%
        \textcolor{cBlue}{#1}%
    }%
    \newcommand*{\phother}[1]{%
        \textcolor{cGreen}{#1}%
    }%
    \newcommand*{\phnote}[1]{%
        {%
            \hypersetup{allcolors=cOrange}% If references occur in here
            \textbf{\textcolor{cOrange}{#1}}%
        }%
    }%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO notes in the PDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{todonotes}% TODO-notes in the margins
    \setuptodonotes{fancyline}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[
    warnings-off={
        % Unicode overwrites colon-commands but uses over/underbracket from mathtools
        % and warns us; suppress this:
        mathtools-colon,%
        mathtools-overbracket,%
    }
]{unicode-math}% Builds onto fontspec and loads it automatically

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts shipped with TeXLive from here: https://tug.org/FontCatalogue/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setmainfont[%
    Numbers=Lowercase,% Hanging/OldStyle numbers through Lowercase numbers
    % Color=Orange2,% Toggle color for debugging (should be xcolor name)
]{TeX Gyre Pagella}% Load existing fond, see also https://tex.stackexchange.com/a/351100/120853
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source: https://fonts.google.com/specimen/Inconsolata
% (Consolas is considered better but is not free (?))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setmonofont[%
    % Inconsolata doesn't have italics font, so fake it. Discouraged but should
    % only occur in a few places in code and not be noticable there. Inconsolata
    % is too nice to give up on it for lack of italics. See also
    % https://tex.stackexchange.com/a/183220/120853
    AutoFakeSlant,
    Scale=MatchLowercase,% Prettier when using inline-code alongside our main font
    % Color=DodgerBlue3,% Toggle color for debugging (should be xcolor name)
]{inconsolata}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source: https://www.exljbris.com/fontinsans.html
% Viable alternative: https://fonts.google.com/specimen/Fira+Sans
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setsansfont[%
    % Color=Red3,% Toggle color for debugging (should be xcolor name)
]{Merriweather Sans}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source: https://ctan.org/texarchive/fonts/tex-gyre-math/opentype
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setmathfont[%
    %Set math-font-commands to new versions; use \symbf{} instead of \mathbf{} etc:
    mathrm=sym,%
    mathit=sym,%
    mathsf=sym,%
    mathbf=sym,%
    mathtt=sym,%
    % 'tpgl': 'TexGyrePagellaLining'.
    % This 'NFSS' style is required for \fontfamily{nfss-code}\selectfont to work,
    % e.g. in package chemmacros/chemformula
    NFSSFamily=tgpl,%
    % Color=Green4,% Toggle color for debugging (should be xcolor name)
]{TeX Gyre Pagella Math}% Load existing fond, see also https://tex.stackexchange.com/a/351100/120853

% Provide a new font family for siunitx to work.
% See: https://tex.stackexchange.com/a/468031/120853.
% \newfontfamily is used similarly to \setmainfont etc,
% see: https://tex.stackexchange.com/a/12568/120853
\newfontfamily{\unitnumberfont}[
    % New font family for typesetting units.
    % Required since otherwise, numbers typeset with \qty/\num etc. from siunitx
    % might be hanging if that feature is turned on in the main font (OldStyle numbers).
    % To ensure these physical numbers are always upright, set Numbers:
    Numbers=Uppercase,
    % Color=LightCyan4,% Toggle color for debugging (should be xcolor name)
]{TeX Gyre Pagella}% Load existing fond, see also https://tex.stackexchange.com/a/351100/120853

% Looking at CTAN, `fontawesome5' looks much more recent and packs many more symbols
% in comparison to `fontawesome'.
% It ships with its own font files, so no need to specify here.
\RequirePackage{fontawesome5}% High-quality Unicode vector web symbols

% Wrapper for "i.e.", "e.g.", "c.f.", "etc.", etc.
% Call this command as "The animals, \iecfeg{e.g.}\ an elephant, are..."
% to get a small space after the ending period.
% We do not define dedicated commands here (like \eg or \etc) to print that stuff
% automatically, since there are way too many exceptions and caveats.
% Such macros are not worth it because the requirements change too much from use to use
%  (different languages, capitalisation, ending dot if abbreviation is at end of
% sentence, ...).
% It is left to the user to do the specifics.
% This macro just makes sure it is all in italics.
\newcommand*{\iecfeg}[1]{\textit{#1}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typesetting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Using 'shortcuts' package option, do e.g. 'fast\-/paced' to get a breakable
% 'fast-pace' word in print.
% Otherwise, LaTeX does not hyphenate/linebreak words that already come with a hyphen,
% since that could be ambiguous
\RequirePackage[shortcuts]{extdash}

\RequirePackage{microtype}% Advanced typesetting for kerning etc.

% Dummy text in readable English (Other languages are also detected)
% Provides a more realistic preview than Lorem Ipsum
\RequirePackage{blindtext}

\RequirePackage{pdflscape}% Pages in landscape format

\RequirePackage{url}% Escaping special chars as URL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language Support
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{polyglossia}% Language rules. Replacement for babel in lualatex
    % Expand this properly; the version without \expandsafters does not work fully.
    % It works this way:
    % The first \expandafter is seen, so the following \setdefaultlanguage is not
    % expanded and skipped.
    % Next, the second \expandafter is looked at. It sees the token { next, saving it
    % for later.
    % \pepart@language is then expanded fully, to the current language.
    % What is left is a properly working string, \setdefaultlanguage{<language string>}
    \expandafter\setdefaultlanguage\expandafter{\pepart@language }

    % Whatever main language (setmainlanguage = setdefaultlanguage) was loaded, we want
    % the "other" one (since we expect only English and German) to be available as a
    % secondary language. This is very convenient if for example a thesis is in English,
    % but certain parts have to be in German, e.g. for legal reasons. A simple switch
    % \begin{german} ... \end{german} would then achieve that.
    \setotherlanguages{german,english}

% Proper quotation support, mainly through \enquote
\RequirePackage[
    autostyle=true,% true always adapts quotes to current language
]
{csquotes}
    % Add itshape to beginning (beg) of display quote environments:
    \renewcommand*{\mkbegdispquote}[2]{\itshape}

\RequirePackage[inline]{enumitem}% Custom list environments
    \setlist{noitemsep}% No vertical spacing in lists
    \setlist[1]{labelindent=\parindent}% Indent lists by paragraph indent
    % Refer to unimath_symbols.pdf for source of \smblksquare etc.:
    % https://ctan.org/texarchive/macros/latex/contrib/unicode-math
    \setlist[itemize,1]{label=\smblksquare}%
    \setlist[enumerate]{font=\sffamily\bfseries}

    % For compact itemize lists within table cells:
    \newlist{tabitemize}{itemize}{1}% Second argument is max. depth
    \setlist[tabitemize]{%
        label=\smblksquare,%
        nosep,% nosep kills all vertical spacing
        align=parleft,
        leftmargin=*,
        % https://tex.stackexchange.com/a/443573/120853,
        % but before=\compress didn't work:
        after=\vspace{-\baselineskip},
        before=\vspace{-0.75\baselineskip},% Hacky manual parameter
    }

    % For compact enumerations lists within table cells:
    \newlist{tabenum}{enumerate}{1}% Second argument is max. depth
    \setlist[tabenum]{
        label={\arabic*.},
        font=\sffamily\bfseries,
        leftmargin=*,
        nosep,% nosep kills all vertical spacing
        align=parleft,
        % https://tex.stackexchange.com/a/443573/120853,
        % but before=\compress didn't work:
        after=\vspace{-\baselineskip},
        before=\vspace{-0.75\baselineskip},% Hacky manual parameter
    }

    % An enumerated description list:
    % https://tex.stackexchange.com/a/30035/120853
    \newcounter{descriptcount}
    \newlist{enumdescript}{description}{2}% Derive from existing description env.
    \setlist[enumdescript, 1]{% Set first level action
        before={%
            \setcounter{descriptcount}{0}%
            % \renewcommand*\thedescriptcount{\alph{descriptcount}}%
        },
        font={\bfseries\stepcounter{descriptcount}\thedescriptcount.~}
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Floats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Does \centering automatically, provides side captions (fcapside) and much more.
\RequirePackage{floatrow}

\floatsetup{footposition=bottom}% For all floats

\floatsetup[longtable]{LTcapwidth=table}% https://tex.stackexchange.com/a/345772/120853

\floatsetup[table]{%
    style=plaintop,% Always above, no matter where \caption is called
    footnoterule=none,%
    footskip=.35\skip\footins,%
}%

\floatsetup[figure]{%
    capbesideposition=right,%
    capbesidesep=quad,%
}%

\floatsetup[subfigure]{style=plain}% Plain style, so no rules

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Float Captions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{caption}

% Will be printed between 'Figure/Table/... XYZ' and the caption text:
\DeclareCaptionLabelSeparator{slash}{\ /\ }% `\ ' (backslash+space) is a short space

\DeclareCaptionFont{ftfont}{%
    \scriptsize%
    \color{g3}%
    \hypersetup{hidelinks}%
    \sffamily\raggedleft%
}%

\captionsetup{% All captions
    format=plain,%
    textformat=period,% Always print period at end
    font=small,% All fonts
    labelfont={sf,bf},%
    labelsep=slash,%
    labelformat=simple,% Just Name/Number, no period or similar
    indention=1em,%
}%

\captionsetup[floatfoot]{%
    footfont=ftfont,% https://tex.stackexchange.com/q/9547/120853
}%

\captionsetup[capbesidefigure]{
    % When using sidecaptions, the linewidth can be rather small and awkward breaks and
    % many underfull hboxes occur. Therefore, raggedright.
    justification=raggedright,
}

\captionsetup[subfigure]{%
    labelformat=simple,% 'parens' uses parantheses, 'brace' just the right one
    labelsep=slash,%
    labelfont={sf,bf},%
    list=off,% list=off removes subfigures from LoF
}%

\captionsetup[subtable]{%
    labelformat=simple,% 'parens' uses parantheses, 'brace' just the right one
    labelsep=slash,%
    labelfont={sf,bf},%
    list=off,% list=off removes subfigures from LoF
}%

% Change counter from Arabic number to letter:
\renewcommand*{\theContinuedFloat}{\alph{ContinuedFloat}}

% Make this new length and indent, same length as regular caption indent:
\newlength{\floatfootruleindent}
\setlength{\floatfootruleindent}{\caption@indent}% Set the new length

% A bit hacky; introduce a rule underneath caption if \floatfoot is called:
\renewcommand*{\floatfootskip}{2pt\hspace{\floatfootruleindent}\hrulefill}%

\RequirePackage{subcaption}% For subfloats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[% Default back-end: biber
    % short style is 'alphabetic' (like [AB99]);
    % longer: 'authoryear' (like (Einstein, 1940)):
    style=authoryear,
    autocite=footnote,% Control what \autocite does
    %
    sortcites=true,% Apply what is specified in sorting=
    % Introduce back references in bibliography:
    % https://tex.stackexchange.com/a/211631/120853
    % Do not use hyperref for this
    backref,
    url=false,% Still prints URL for @online, but nowhere else
    doi=false,%
    isbn=false,%
]{biblatex}%

% The `\addbibresource` command moved to the root *.tex file to work for VSCode's
% LaTeX Workshop extension.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arrays / Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{tabu}% For longtabu in the glossary

\RequirePackage{array}
    \newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}% Vert.+Hor. centered cells

    % A command to have a cell with vertical text as a multirow:
    \newcommand*{\multirotatecell}[2]{%
        \multirow{#1}{*}{%
            \begin{tabular}{@{}c@{}}%
                \rotatebox[origin=c]{90}{#2}%
            \end{tabular}%
        }%
    }%

\RequirePackage{tabularray}% Powerful, up and coming package
    \UseTblrLibrary{booktabs}% Get `\toprule` etc. for tabularrays
    \UseTblrLibrary{siunitx}% Get S column type

\RequirePackage{multirow}% Cells spanning multiple rows (like multicolumn)

\RequirePackage{booktabs}% Pretty tables; an absolute must

% More vertical stretch for more relaxed visuals in all tables (global setting)
\renewcommand*{\arraystretch}{1.3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Replaces datetime; use regional date format from document language
\RequirePackage[useregional]{datetime2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scientifics Typesetting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{siunitx}% Typesetting physical units correctly
    \sisetup{%
        % For siunitx v3, the following block replaces what used to be
        % `detect-all` (removed in that release, see
        % https://github.com/josephwright/siunitx/blob/main/CHANGELOG.md#v300 ).
        % It allows the `siunitx` output to match surrounding text/math (italics/bold/...,
        % roman/sans/... etc. as much as possible)
        mode=match,
        propagate-math-font=true,
        reset-math-version=false,
        reset-text-family=false,
        reset-text-series=false,
        reset-text-shape=false,% Not part of official fix, but still added (see https://collaborating.tuhh.de/alex/latex-cookbook/-/issues/8)
        text-family-to-math=true,
        text-series-to-math=true,
        %
        % Requires siunitx v3+, see also https://tex.stackexchange.com/a/468031/120853,
        % https://github.com/josephwright/siunitx/issues/532 :
        text-font-command=\unitnumberfont,
        %
        % Alternative range-phrase:
        % en-dash via '--', but inside \text{}, so it's not 'two minus signs'
        % range-phrase={\,\text{--}\,},
        range-units=single,% single: Print unit only once, at end
        per-mode=symbol,
    }%
    % Second setup step, with locales. See also
    % https://tex.stackexchange.com/a/46979/120853
    \gappto{\blockextras@german}{%
        \sisetup{locale=DE}
    }
    \gappto{\blockextras@english}{%
        \sisetup{locale=US}
    }

    % Declare units ourselves:
    % Set as text so it stays a hyphen in math mode, as opposed to minus sign
    \DeclareSIUnit{\volpercent}{Vol.\text{-}\%}
    \DeclareSIUnit{\watthour}{Wh}%
    \DeclareSIUnit{\annum}{a}%
    \DeclareSIUnit{\atmosphere}{atm}%
    \DeclareSIUnit{\partspermillion}{ppm}%
    \DeclareSIUnit{\bar}{bar}% https://tex.stackexchange.com/a/598473/120853

    % Unit qualifiers, i.e. subscripts.
    % We already have a dedicated system (bib file with glossaries-extra) for subscripts
    % for symbols, so use those (just format, don't index) also for units here.
    \DeclareSIQualifier{\dryair}{% for moist air context
        \glsfmtname{sub.dry}\glsfmtname{sub.air}%
    }
    \DeclareSIQualifier{\water}{%
        \glsfmtname{sub.water}%
    }
    \DeclareSIQualifier{\thermal}{%
        \glsfmtname{sub.thermal}%
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperref and PDFs appearance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[pdfusetitle]{hyperref}% Loads url-package internally
    \hypersetup{%
        % Unicode settings are automatically true for luatex engine,
        % don't specify manually
        colorlinks=true,% No ugly frames, but still colored
        allcolors=darklink,%
        % hidelinks,% Toggle here!
        plainpages=false,%
        pdfsubject={%
            Comprehensive LaTeX template with examples for theses, books
            and more, employing the 'latest and greatest'.
        },
        pdfkeywords={%
            latex,%
            template,%
            modern,%
            thesis,%
            phd,%
            master,%
            bachelor,%
            best practices,%
        },
        pdfcreator={%
            LaTeX with hyperref,
            glossaries-extra/bib2gls
            and biblatex/biber
        },
        bookmarksnumbered=true,%
        % Default opening of the document in supported PDF viewers:
        pdfpagelayout=TwoPageRight,
        pdfdisplaydoctitle,% https://tex.stackexchange.com/a/435434/120853
    }%

    % In order to translate, polyglossia wraps things into \text<language>, e.g.
    % \textenglish. If this is part of a PDF string, like when we do
    % \addchap{\glossaryname}, LaTeX/hyperref will complain that \textenglish is not a
    % PDF string and is dropped.
    % Therefore, disable commands of the form \text<language> in this document. Don't
    % use a static language but the current language from kvoptions.
    %
    % Expansion works as follows:
    % \expandafter is executed, causing \let to be saved for later.
    % \csname is then executed next. It scans ahead to its matching \endcsname,
    % "performing full expansion as it goes" (Quote from
    %  https://tex.stackexchange.com/a/430557/120853).
    % In that process, \pepart@language is expanded to the value it was given in the
    % document options through kvoptions.
    % Now, \csname finishes and presents a token \text<language>, e.g. \textenglish.
    % LaTeX starts over; \expandafter is now gone, so it reads \let\text<language> ...
    % In this case, ... is \relax, removing the macro definition.
    % It will no longer occur in PDF commands.
    % See also:
    % https://www.overleaf.com/learn/latex/Articles/How_does_%5Cexpandafter_work:_A_detailed_study_of_consecutive_%5Cexpandafter_commands
    % and
    % TUGboat, Volume 9, 1988, No. 1: Macros: A Tutorial on \expandafter by
    % Stephan v. Bechtolsheim.
    %
    % Idea from https://tex.stackexchange.com/a/230197/120853
    \pdfstringdefDisableCommands{%
        \expandafter\let\csname text\pepart@language\endcsname \relax%
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Should be loaded late, because it does a lot of redefinitions.
% With Polyglossia, cleveref recognizes what was passed in
% \setdefaultlanguage and uses it. It must come before cleveref is loaded.

\RequirePackage[
    % Always capitalise; still, use \Cref and \cref appropriately in case that changes!
    capitalise,
    nameinlink,% Name of reference is part of PDF hyperlink
    noabbrev,% Full expansion: Figure instead of Fig., etc.
]{cleveref}%
    \creflabelformat{equation}{#2#1#3}% No (1), but 1, aka remove parentheses

    % Syntax: \crefname{<counter>}{<singular>}{<plural>}
    % \Crefname (capitalised) is not required; when it is not present but \Cref{} is
    % called, it uses \MakeUppercase on \crefname definitions.
    % However, if LaTeX macros are used in the definition, it is required.
    % Code listings, see `minted` package.
    % Introduce a new <type> called `code`, then make the (existing) counter `listing`
    % use it by aliasing. Modifying `listing` directly with `\crefname{listing}...`
    % did not work! See also
    % https://tex.stackexchange.com/a/310355/120853
    \crefname{code}{\TransListing{}}{\TransListings{}}
    \Crefname{code}{\TransListing{}}{\TransListings{}}
    \crefalias{listing}{code}
