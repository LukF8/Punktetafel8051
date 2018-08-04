%% hgbthesis.cls
%% Autor: Wilhelm Burger (wilhelm.burger@fh-hagenberg.at)
%% Diese Datei ist Teil des hagenberg-Package zur Erstellung von 
%% Bachelor- und Diplomarbeiten.

\NeedsTeXFormat{LaTeX2e}
\newcommand{\hgbthesisDate}{2018/03/23} %Versionsdatum
\ProvidesClass{hgbthesis}[\hgbthesisDate\space LaTeX-Vorlage fuer Diplomarbeiten, Masterarbeiten, Bachelorarbeiten etc.]

\RequirePackage{ifthen}

\newcommand{\hgb@MainLanguage}{german}	% also referenced in hgb.sty
\newcommand{\@adaseiten}{} 
\newcommand{\@maketitlepages}{\@adaseiten}  %default: Masterarbeit


%% begin class options ---------------------------------------------
\DeclareOption{ada}{\renewcommand{\@maketitlepages}{\@adaseiten}} 
\DeclareOption{english}{\renewcommand{\hgb@MainLanguage}{english}}
\DeclareOption{german}{\renewcommand{\hgb@MainLanguage}{german}}
\DeclareOption*{\ClassWarning{hgbthesis}{Unknown document option "\CurrentOption"}}
\ProcessOptions
%% end class options ---------------------------------------------
 
\LoadClass[a4paper,11pt,oneside]{book}
 
\RequirePackage{hgb}	% load associated style file hgb.sty


%-------------- Setup für Seiten im Front-Teil --------------------

\newcommand{\@studiengang}{\@MissingArg{Studiengang??}}
\newcommand{\studiengang}[1]{%
	\renewcommand{\@studiengang}{#1}
}

\newcommand{\@studienort}{\@MissingArg{Studienort??}}
\newcommand{\studienort}[1]{%
	\renewcommand{\@studienort}{#1}
}

\newcommand{\@studienuni}{\@MissingArg{Studienuni??}}
\newcommand{\studienuni}[1]{%
    \renewcommand{\@studienuni}{#1}
}

 
\newcommand{\@kontaktpersonName}{Kontaktperson ????}

\newcommand{\kontaktperson}[1]{% 
    \renewcommand{\@kontaktpersonName}{#1}
}

 

\newcommand{\@betreuerBABez}{????}
\newcommand{\@betreuerBAName}{\@MissingArg{Gutachter der Studienakademie??}}


\newcommand{\@betreuerBez}{????}
\newcommand{\@betreuerName}{\@MissingArg{Betreuer??}}


\newcommand{\@betreuerBezTec}{????}
\newcommand{\@betreuerNameTec}{\@MissingArg{Betreuer??}}

\newcommand{\betreuer}[1]{%
  \renewcommand{\@betreuerBez}{Betreuer}
	\renewcommand{\@betreuerName}{#1}
}

\newcommand{\betreuerTec}[1]{%
    \renewcommand{\@betreuerBezTec}{Technischer Betreuer}
    \renewcommand{\@betreuerNameTec}{#1}
}


\newcommand{\betreuerBA}[1]{%
    \renewcommand{\@betreuerBABez}{Gutachter der Studienakademie}
    \renewcommand{\@betreuerBAName}{#1}
}
 
\newcommand{\betreuerin}[1]{%
  \renewcommand{\@betreuerBez}{Betreuerin}
	\renewcommand{\@betreuerName}{#1}
}

\newcommand{\betreuerinTec}[1]{%
    \renewcommand{\@betreueBezTec}{Technische Betreuerin}
    \renewcommand{\@betreuerNameTec}{#1}
}


\newcommand{\betreuerinBA}[1]{%
    \renewcommand{\@betreuerBABez}{Gutachterin der Studienakademie}
    \renewcommand{\@betreuerBAName}{#1}
}


\newcommand{\@nummer}{\@MissingArg{Arbeit Nummer??}}
\newcommand{\nummer}[1]{%
	\renewcommand{\@nummer}{#1}
}

\newcommand{\@gegenstand}{\@MissingArg{Gegenstand??}}
\newcommand{\gegenstand}[1]{%
	\renewcommand{\@gegenstand}{#1}
}

\newcommand{\@semester}{\@MissingArg{Semester??}}
\newcommand{\semester}[1]{%
	\renewcommand{\@semester}{#1}
}

%% -------------------------------------------------

\newcounter{@abgabetag}
\newcounter{@abgabemonat}
\newcounter{@abgabejahr}

\setcounter{@abgabetag}{\the\day}
\setcounter{@abgabemonat}{\the\month}
\setcounter{@abgabejahr}{\the\year}

\newcommand{\abgabedatum}[3]{%	%\abgabedatum{yyyy}{mm}{dd}
	\setcounter{@abgabejahr}{#1}
	\setcounter{@abgabemonat}{#2}
	\setcounter{@abgabetag}{#3}
}

\newcommand{\abgabemonat}[1]{%
	\ClassWarning{hgbthesis}{\noexpand\abgabemonat is deprecated - 
	use \noexpand\abgabedatum instead!}
}

\newcommand{\abgabejahr}[1]{%
	\ClassWarning{hgbthesis}{\noexpand\abgabejahr is deprecated - 
	use \noexpand\abgabedatum instead!}
}

%% ----------------------------------------------------------

\newcommand{\@firma}{\@MissingArg{Firma??}}
\newcommand{\firma}[1]{%
\renewcommand{\@firma}{#1}
}


\newcommand{\@firmaAbt}{\@MissingArg{Firma Abteilung??}}
\newcommand{\firmaAbt}[1]{%
    \renewcommand{\@firmaAbt}{#1}
}


\newcommand{\@firmaAdr}{\@MissingArg{Firma Adresse??}}
\newcommand{\firmaAdr}[1]{%
    \renewcommand{\@firmaAdr}{#1}
}

\newcommand{\@firmenUrl}{\@MissingArg{www.???}}
\newcommand{\firmenUrl}[1]{%
\renewcommand{\@firmenUrl}{#1}
}

\newcommand{\@firmenTel}{\@MissingArg{Tel??}}
\newcommand{\firmenTel}[1]{%
\renewcommand{\@firmenTel}{#1}
}

\newcommand{\@license}{\@MissingArg{Lizenztext??}}
\newcommand{\license}[1]{%
\renewcommand{\@license}{#1}
}


%------------------ Titelseiten -------------------

%% deprecated - use \maketitle instead!
\newcommand{\titelseite}{ 
  \ClassWarning{hgbthesis}{\noexpand\titelseite is deprecated - use \noexpand\maketitle instead}
  \maketitle
} 
 
 

\newcommand{\@adatitel}{%
    \begin{titlepage}%
        \rule{0mm}{1mm}
        \vspace*{20mm}
        %\noindent Left side \hfill right side\\
        \begin{center}%
            \setlength{\unitlength}{1cm}
            \begin{picture}(12,4)
            %\thinlines\put(0,0){\framebox(12,4){}}
            \put(0,1.8){\parbox{12cm}{\centering\LARGE\bf%
                    \setlength{\baselineskip}{20pt}%
                    
                     \@title}}
            \end{picture}
            \vskip 10mm%
            {\large\sc\@author}
            \vskip 4mm%
            {\large\sf Matrikelnummer~\@nummer}
            \vskip 40mm%
            {\Large Dokumentation eines 8051 Projekts}%
            \vskip 8mm%
            {\large eingereicht im Rahmen der} \vskip 1mm {Vorlesung \textit{Systemnahe Programmierung}}%
            \vskip 1mm {des Studiengangs}%
            \vskip 4mm%
            {\large\sc\@studiengang}%
            \vskip 4mm%
            {\large an der \@studienuni}%
            \vskip 16mm%
            {\large im \monthname[\value{@abgabemonat}] \arabic{@abgabejahr}}%
        \end{center}\par
        \vfil\null
    \end{titlepage}%
}

%------------------ Copyright-Seite -------------------

\newcommand{\strictlicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\license{Alle Rechte vorbehalten}}%
	{\license{All Rights Reserved}}
}

\newcommand{\@ccLicenseAt}{%
Dieses Werk ist lizenziert unter einer  \textsl{Creative Commons Lizenz} \emph{Namensnennung - Nicht-kommerziell - Keine Bearbeitung 3.0 Deutschland} (CC BY-NC-ND) veröffentlicht --
siehe \url{http://creativecommons.org/licenses/by-nc-nd/3.0/de/}.}

\newcommand{\@ccLicenseEn}{%
This work is published under the conditions of the 
\textsl{Creative Commons License Attribution--Non\-Commercial--No\-Derivatives} 
(CC BY-NC-ND)---see
\url{http://creativecommons.org/licenses/by-nc-nd/3.0/}.}

\newcommand{\cclicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
{\license{\@ccLicenseAt}} % german CC license text
{\license{\@ccLicenseEn}} % english CC license text (default)
}
	
%\strictlicense
\cclicense	% Creative Commons License (default)

\newcommand{\@makelicense}{ 
  \sbox\@tempboxa{\@license}%
  \ifdim \wd\@tempboxa >\hsize
    \begin{sloppypar}\noindent\@license\end{sloppypar}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
} 

\newcommand{\@copyrightseite}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\vspace*{75mm}
\begin{center}
\copyright\ Copyright\ \arabic{@abgabejahr}\ \@author
\end{center}
\vspace{8mm}
\@makelicense
%\begin{center}
%\includegraphics[width=2.0cm]{images/by-nc-nd-eu}
%\end{center}
}
 
 
%------------------ Betreuer-Seite -------------------
 

%% -------------- Erklärung / Declaration ---------

\newcommand{\@erklaerungsseiteDe}{%
\begin{german}
\chapter{Erklärung}
\noindent
%Standardfassung der FH-OÖ ab 04.04.2012:
Ich erkläre eidesstattlich, dass ich die vorliegende Arbeit selbstständig und ohne fremde Hilfe verfasst, 
andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als 
solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder ähnlicher Form keiner anderen 
Prüfungsbehörde vorgelegt. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt.
\par
\vspace{10mm}
\noindent
\@studienort, am \formatdate{\value{@abgabetag}}{\value{@abgabemonat}}{\value{@abgabejahr}}
\par
\vspace{12mm}
\noindent
\@author
\end{german}
}

\newcommand{\leadingzero}[1]{\ifnum #1<10 0\the#1\else\the#1\fi}

\newcommand{\@erklaerungsseiteEn}{%
\begin{english}
\chapter{Declaration}
\noindent
I hereby declare and confirm that this thesis is entirely the result of my own original work. 
Where other sources of information have been used, they have been indicated as such and properly 
acknowledged. I further declare that this or similar work has not been submitted for credit elsewhere.
\par
\vspace{10mm}
\noindent
%\@studienort, \the\year-\leadingzero{\month}-\leadingzero{\day} %http://de.wikibooks.org/wiki/LaTeX-W%F6rterbuch:_today 
\@studienort, {\usdate\formatdate{\value{@abgabetag}}{\value{@abgabemonat}}{\value{@abgabejahr}}}
\par
\vspace{12mm}
\noindent
\@author
\end{english}
}

\newcommand{\@erklaerungsseite}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\@erklaerungsseiteDe}%
	{\@erklaerungsseiteEn}
}


%------------ Struktur der Frontseiten -------------------
 


\renewcommand{\@adaseiten}{
    \@adatitel
    \@copyrightseite
    \@erklaerungsseite
}

%------------ Automatischer Eintrag der PDF Metadaten ------------

\renewcommand{\maketitle}{	%replace standard LaTeX-command
\hypersetup{
		pdftitle={\@title},
		pdfauthor={\@author},
		pdfsubject={\@studiengang, \@studienort},
		pdfcreator={LaTeX using class hgbthesis},
		pdfproducer={},
		pdfkeywords={}
}%
\@maketitlepages
}

%%-------------------------------------------------------------

\usepackage{hgbheadings}
\usepackage{hgbbib}

%%-------------------------------------------------------------

\endinput

