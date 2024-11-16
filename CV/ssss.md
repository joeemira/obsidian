\documentclass[10pt, letterpaper]{article}

% Packages:
\usepackage[
    ignoreheadfoot, % set margins without considering header and footer
    top=2 cm, % seperation between body and page edge from the top
    bottom=2 cm, % seperation between body and page edge from the bottom
    left=2 cm, % seperation between body and page edge from the left
    right=2 cm, % seperation between body and page edge from the right
    footskip=1.0 cm, % seperation between body and footer
    % showframe % for debugging 
]{geometry} % for adjusting page geometry
\usepackage{titlesec} % for customizing section titles
\usepackage{tabularx} % for making tables with fixed width columns
\usepackage{array} % tabularx requires this
\usepackage[dvipsnames]{xcolor} % for coloring text
\definecolor{primaryColor}{RGB}{0, 79, 144} % define primary color
\usepackage{enumitem} % for customizing lists
\usepackage{fontawesome5} % for using icons
\usepackage{amsmath} % for math
\usepackage[
    pdftitle={John Doe's CV},
    pdfauthor={John Doe},
    pdfcreator={LaTeX with RenderCV},
    colorlinks=true,
    urlcolor=primaryColor
]{hyperref} % for links, metadata and bookmarks
\usepackage[pscoord]{eso-pic} % for floating text on the page
\usepackage{calc} % for calculating lengths
\usepackage{bookmark} % for bookmarks
\usepackage{lastpage} % for getting the total number of pages
\usepackage{changepage} % for one column entries (adjustwidth environment)
\usepackage{paracol} % for two and three column entries
\usepackage{ifthen} % for conditional statements
\usepackage{needspace} % for avoiding page brake right after the section title
\usepackage{iftex} % check if engine is pdflatex, xetex or luatex

% Ensure that generate pdf is machine readable/ATS parsable:
\ifPDFTeX
    \input{glyphtounicode}
    \pdfgentounicode=1
    % \usepackage[T1]{fontenc} % this breaks sb2nov
    \usepackage[utf8]{inputenc}
    \usepackage{lmodern}
\fi



% Some settings:
\AtBeginEnvironment{adjustwidth}{\partopsep0pt} % remove space before adjustwidth environment
\pagestyle{empty} % no header or footer
\setcounter{secnumdepth}{0} % no section numbering
\setlength{\parindent}{0pt} % no indentation
\setlength{\topskip}{0pt} % no top skip
\setlength{\columnsep}{0cm} % set column seperation
\makeatletter
\let\ps@customFooterStyle\ps@plain % Copy the plain style to customFooterStyle
\patchcmd{\ps@customFooterStyle}{\thepage}{
    \color{gray}\textit{\small John Doe - Page \thepage{} of \pageref*{LastPage}}
}{}{} % replace number by desired string
\makeatother
\pagestyle{customFooterStyle}

\titleformat{\section}{\needspace{4\baselineskip}\bfseries\large}{}{0pt}{}[\vspace{1pt}\titlerule]

\titlespacing{\section}{
    % left space:
    -1pt
}{
    % top space:
    0.3 cm
}{
    % bottom space:
    0.2 cm
} % section title spacing

\renewcommand\labelitemi{$\circ$} % custom bullet points
\newenvironment{highlights}{
    \begin{itemize}[
        topsep=0.10 cm,
        parsep=0.10 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=0.4 cm + 10pt
    ]
}{
    \end{itemize}
} % new environment for highlights

\newenvironment{highlightsforbulletentries}{
    \begin{itemize}[
        topsep=0.10 cm,
        parsep=0.10 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=10pt
    ]
}{
    \end{itemize}
} % new environment for highlights for bullet entries


\newenvironment{onecolentry}{
    \begin{adjustwidth}{
        0.2 cm + 0.00001 cm
    }{
        0.2 cm + 0.00001 cm
    }
}{
    \end{adjustwidth}
} % new environment for one column entries

\newenvironment{twocolentry}[2][]{
    \onecolentry
    \def\secondColumn{#2}
    \setcolumnwidth{\fill, 4.5 cm}
    \begin{paracol}{2}
}{
    \switchcolumn \raggedleft \secondColumn
    \end{paracol}
    \endonecolentry
} % new environment for two column entries

\newenvironment{header}{
    \setlength{\topsep}{0pt}\par\kern\topsep\centering\linespread{1.5}
}{
    \par\kern\topsep
} % new environment for the header

\newcommand{\placelastupdatedtext}{% \placetextbox{<horizontal pos>}{<vertical pos>}{<stuff>}
  \AddToShipoutPictureFG*{% Add <stuff> to current page foreground
    \put(
        \LenToUnit{\paperwidth-2 cm-0.2 cm+0.05cm},
        \LenToUnit{\paperheight-1.0 cm}
    ){\vtop{{\null}\makebox[0pt][c]{
        \small\color{gray}\textit{Last updated in September 2024}\hspace{\widthof{Last updated in September 2024}}
    }}}%
  }%
}%

% save the original href command in a new command:
\let\hrefWithoutArrow\href

% new command for external links:
\renewcommand{\href}[2]{\hrefWithoutArrow{#1}{\ifthenelse{\equal{#2}{}}{ }{#2 }\raisebox{.15ex}{\footnotesize \faExternalLink*}}}


\begin{document}
    \newcommand{\AND}{\unskip
        \cleaders\copy\ANDbox\hskip\wd\ANDbox
        \ignorespaces
    }
    \newsavebox\ANDbox
    \sbox\ANDbox{}

    \placelastupdatedtext
    \begin{header}
        \textbf{\fontsize{24 pt}{24 pt}\selectfont Youssef Emira}

        \vspace{0.3 cm}

        \normalsize
        \mbox{{\color{black}\footnotesize\faMapMarker*}\hspace*{0.13cm}Cairo,Egypt}%
        \kern 0.25 cm%
        \AND%
        \kern 0.25 cm%
        \mbox{\hrefWithoutArrow{mailto:youssefemira1@gmail.com}{\color{black}{\footnotesize\faEnvelope[regular]}\hspace*{0.13cm}youssefemira1@gmail.com}}%
        \kern 0.25 cm%
        \AND%
        \kern 0.25 cm%
        \mbox{\hrefWithoutArrow{tel:+201100424180}{\color{black}{\footnotesize\faPhone*}\hspace*{0.13cm}01100424180}}%
        \kern 0.25 cm%
        \AND%
        \kern 0.25 cm%
        \mbox{\hrefWithoutArrow{https://medium.com/@youssefemira1}{\color{black}{\footnotesize\faLink}\hspace*{0.13cm}medium/youssefemira}}%
        \kern 0.25 cm%
        \AND%
        \kern 0.25 cm%
        \mbox{\hrefWithoutArrow{https://linkedin.com/in/youssef-emira}{\color{black}{\footnotesize\faLinkedinIn}\hspace*{0.13cm}youssef-emira}}%
        \kern 0.25 cm%
        \AND%
        \kern 0.25 cm%
        \mbox{\hrefWithoutArrow{https://github.com/joeemira}{\color{black}{\footnotesize\faGithub}\hspace*{0.13cm}joeemira}}%
         \vspace{0.5 cm - 0.0 cm}
    \end{header}
    Aspiring cybersecurity professional passionate about application, Android, and network penetration testing. Actively enhancing skills through labs and bug bounty programs, eager to gain practical experience and expand knowledge in real-world scenarios.

    \section{Education}



        
        \begin{twocolentry}{
            
            
        \textit{Jan 2021 - Sep 2026}}
            \textbf{University of Helwan}

            \textit{BS in communication and Computer Engineering}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item GPA: 3.0/4.0 
            \end{highlights}
        \end{onecolentry}



    
    \section{Experience}



        
        \begin{twocolentry}{
        \textit{Cairo,Egypt}    
            
        \textit{Julie 2024 – Aug 2024}}
            \textbf{Trainee - HCIA-Security -Full-time}
            
            \textit{NTI and Huawei}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item full-time training focused on network security, firewall technologies, intrusion detection, and security management.
                \item Achieved comprehensive understanding of enterprise-level security solutions by dedicating over 100 hours to HCIA-Security certification preparation, resulting in enhanced skills for identifying potential vulnerabilities within network infrastructures.
            \end{highlights}
        \end{onecolentry}


        \vspace{0.2 cm}

        \begin{twocolentry}{
        \textit{Cairo,Egypt}    
            
        \textit{Aug 2024 – Oct 2024}}
            \textbf{Application penetration tester intern – Full-time}
            
            \textit{We Innovate}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item Completed comprehensive training in application penetration testing, focusing on both web and Android platforms. Developed skills in identifying, analyzing, and mitigating security vulnerabilities.
                \item Web Application Security: Gained expertise in OWASP Top 10 vulnerabilities, including SQL Injection, XSS, CSRF, and broken authentication. Proficient in reconnaissance, vulnerability analysis, exploitation, and reporting.
                \itemAndroid Application Security: Acquired knowledge in static and dynamic analysis, reverse engineering, and identifying common Android-specific vulnerabilities such as insecure data storage and improper cryptography implementation. Hands-on experience with tools like APKTool, JADX, and Drozer.
                \item Tools & Techniques: Practical experience with security tools including Burp Suite, OWASP ZAP, Nmap, and SQLmap for web applications, and APKTool, JADX, and Drozer for Android applications.
            \end{highlights}
        \end{onecolentry}



    
    \section{Publications}



        
        \begin{samepage}
            \begin{twocolentry}{
                Jan 2004
            }
                \textbf{3D Finite Element Analysis of No-Insulation Coils}

                \vspace{0.10 cm}

                \mbox{Frodo Baggins}, \mbox{\textbf{\textit{John Doe}}}, \mbox{Samwise Gamgee}
            \end{twocolentry}


            \vspace{0.10 cm}

            \begin{onecolentry}
        \href{https://doi.org/10.1109/TASC.2023.3340648}{10.1109/TASC.2023.3340648}
            \end{onecolentry}
        \end{samepage}


    
    \section{Projects}



        
        \begin{twocolentry}{
            
            
        \textit{\href{https://github.com/sinaatalay/rendercv}{github.com/name/repo}}}
            \textbf{Multi-User Drawing Tool}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item Developed an electronic classroom where multiple users can simultaneously view and draw on a "chalkboard" with each person's edits synchronized
                \item Tools Used: C++, MFC
            \end{highlights}
        \end{onecolentry}


        \vspace{0.2 cm}

        \begin{twocolentry}{
            
            
        \textit{\href{https://github.com/sinaatalay/rendercv}{github.com/name/repo}}}
            \textbf{Synchronized Desktop Calendar}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item Developed a desktop calendar with globally shared and synchronized calendars, allowing users to schedule meetings with other users
                \item Tools Used: C\#, .NET, SQL, XML
            \end{highlights}
        \end{onecolentry}


        \vspace{0.2 cm}

        \begin{twocolentry}{
            
            
        \textit{2002}}
            \textbf{Custom Operating System}
        \end{twocolentry}

        \vspace{0.10 cm}
        \begin{onecolentry}
            \begin{highlights}
                \item Built a UNIX-style OS with a scheduler, file system, text editor, and calculator
                \item Tools Used: C
            \end{highlights}
        \end{onecolentry}



    
    \section{Technologies}



        
        \begin{onecolentry}
            \textbf{Languages:} C++, C, Java, Objective-C, C\#, SQL, JavaScript
        \end{onecolentry}

        \vspace{0.2 cm}

        \begin{onecolentry}
            \textbf{Technologies:} .NET, Microsoft SQL Server, XCode, Interface Builder
        \end{onecolentry}


    

\end{document}