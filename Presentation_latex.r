\documentclass{beamer}
\usetheme{Frankfurt}
\usecolortheme{dove}

\usepackage{graphicx}
\usepackage{listings}

\title{Amazon deforestation}
 \subtitle{Spatio-temporal analysis of land cover between 2001 and 2012}
 \author{Irene Cassinelli}
 \institute{Alma Mater Studiorum — Univerisity of Bologna}
 \bigskip

\begin{document}

\maketitle

\AtBeginSection[]
{
\begin{frame}
\frametitle{}
\tableofcontents[currentsection]
\end{frame}
}

\section{Introduction}

\begin{frame}{The Amazon}
\begin{itemize}
    \item\small Located in the north of South America, the Amazon covers much of Brazil, Bolivia, Peru, Ecuador, Colombia, Venezuela, Guyana, Suriname, and French Guyana.
    \smallskip
    \item\small It is the \textbf{largest tropical rainforest on Earth}, covering an area of over 6.5 million square kilometers, and it houses \textbf{ten percent of the world´s known species}, including endemic and endangered flora and fauna. 
    \smallskip
    \item\small It holds a crucial ecological and environmental value, influencing Earth's climatic balance: its trees absorb heat and carbon dioxide (CO2), thus creating a \textbf{"cooling effect"} on the planet. 
    \smallskip
    \item\small However, when trees are cut down and burned, the stored CO2 is released back into the atmosphere, contributing to global warming.
\end{itemize}
\end{frame}

\begin{frame}{The Amazon rainforest}
\begin{figure}
    \centering
    \includegraphics[width=0.4\linewidth]{Amazonforest.png}
    \caption{Map of the Amazon rainforest}
\end{figure}
\end{frame}

\begin{frame}{Amazon deforestation}
\begin{itemize}
    \item\small Over the last fifty years, the \textbf{deforestation of the Amazon} has turned this carbon sink (the so-called "green lung" of our planet) into a source of carbon emissions.
    \smallskip
    \item\small Mining, logging, farming, agriculture, and oil and gas extraction have put \textbf{unsustainable pressure} on this fragile forest.
    \smallskip
    \item\small According to several studies, the Amazon has lost one-fifth of its forest cover, its connectivity has been increasingly disrupted and many endemic species have been subjected to uncontrolled exploitation.
\end{itemize}
\end{frame}

\begin{frame}{Study aim}
\begin{itemize}
    \item\small The objective of this study was to assess the level of \textbf{deforestation of Rondônia}, a state located in the western part of Brazil. 
    \smallskip
    \item\small Recently, Rondônia - once home to 208,000 square kilometers of forest - has become \textbf{one of the most deforested parts of the Amazon}.
    \smallskip
    \item\small Clearing and degradation of Rondônia’s forest have been rapid: 4,200 square kilometers cleared by 1978; 30,000 by 1988; and 53,300 by 1998. By 2003, an estimated 67,764 square kilometers of rainforest had been cleared.
\end{itemize}
\end{frame}

\begin{frame}{State of Rondônia}
\begin{figure}
    \centering
    \includegraphics[width=0.4\linewidth]{Rondonia.png}
    \caption{Location of the state of Rondônia in Brazil}
\end{figure}
\end{frame}

\section{Materials and methods}

\begin{frame}{Dataset}
\begin{itemize}
    \item\small The images used in this project belong to a satellite time series collected from 2000 to 2012 by MODIS on \textbf{NASA's Terra satellite}
    (\url{https://earthobservatory.nasa.gov/world-of-change/Deforestation}).
    \bigskip
    \item\small The Moderate-Resolution Imaging Spectroradiometer (\textbf{MODIS}) is an instrument designed for satellite observation of the Earth with a spatial resolution ranging from 250 to 1000 m.
\end{itemize}
\end{frame}

\begin{frame}{Images}
\begin{itemize}
    \item\small The satellite images under study date back to \textbf{2001} and \textbf{2012}, respectively, and have a spatial resolution of 500 m. 
    \smallskip
    \item\small Healthy forest areas are dark green, while deforested areas are brown (bare ground) or light green (cropland, pastureland, or occasionally second-growth forest). 
    \smallskip
    \item\small As my study attempts to show, over 11 years, \textbf{deforested areas have increased significantly}, and are still increasing, due to anthropogenic impact.
\end{itemize}
\end{frame}

\begin{frame}{Raster images}
    \lstinputlisting[basicstyle=\ttfamily\tiny,language=R,commentstyle=\color{darkgray}, frame=single, stringstyle=\color{blue}, backgroundcolor=\color{lightgray}]{RGB.r} \\
\begin{minipage}[t]{0.45\textwidth}
\centering
    \includegraphics[width=\textwidth]{amazon2001RGB.jpg}
    \captionof{\small Amazon rainforest - 2001}
\end{minipage}\hfill
\begin{minipage}[t]{0.45\textwidth}
\centering
    \includegraphics[width=\textwidth]{amazon2012RGB.jpg}
    \captionof{\small Amazon rainforest - 2012}
\end{minipage}
\end{frame}

\begin{frame}{DVI}
\begin{itemize}
    \item\small The \textbf{Difference Vegetation Index} (DVI) is defined as the difference between the reflectance value in two bands of the electromagnetic spectrum - typically, near-infrared (NIR) and red bands.
    \smallskip
    \item\small DVI can be useful for detecting the presence and density of vegetation. It is calculated using remote sensing data, typically obtained from satellites.
\end{itemize}
\vspace{4mm}
    \begin{equation} %dvi
        DVI={NIR-red}
    \label{eq:dvi}  % to label the equation
    \end{equation}
\end{frame}

\begin{frame}{NDVI}
\begin{itemize}
    \item\small The \textbf{Normalized Difference Vegetation Index} (NDVI) provides standardized values that can be more easily interpreted and compared with other raster images.
    \smallskip
    \item\small NDVI quantifies vegetation by evaluating the presence of \textbf{photosynthetic activity} and measuring the difference between NIR (which vegetation strongly reflects) and red bands (which vegetation absorbs).
    \smallskip
    \item\small NDVI values range from -1 to +1, with higher values indicating a higher density of green vegetation.
\vspace{4mm}
    \begin{equation} %ndvi
        NDVI=\frac{NIR-red}{NIR+red}
    \label{eq:ndvi}  % to label the equation
    \end{equation}
\end{itemize}
\end{frame}

\begin{frame}{Spatio-temporal change detection}
\begin{itemize}
    \item\small The \textbf{spatio-temporal variation in vegetation cover} between 2001 and 2012 was then detected.
    \bigskip
    \item\small It involves the analysis of raster images acquired at different time periods to identify and quantify changes in land use, vegetation cover, or other environmental phenomena over time.
\end{itemize}
\end{frame}

\begin{frame}{Unsupervised classification}
\begin{itemize}
    \item\small Finally, the unsupervised classification of the raster images into two classes (forest and human components) was detected. 
    \bigskip
    \item\small \textbf{Raster images classification} can be used to monitor changes in land use, land cover, or the natural environment over time. For example, it can be used to assess deforestation, urbanization, or other environmental changes.
\end{itemize}
\end{frame}

\section{Results}

\begin{frame}{DVI}
    \lstinputlisting[basicstyle=\ttfamily\tiny,language=R, commentstyle=\color{darkgray}, frame=single, stringstyle=\color{blue}, backgroundcolor=\color{lightgray}]{dvi.r} \\
    \centering
    \includegraphics[width=1\textwidth]{AmazonDVI(2).jpeg}
\end{frame}

\begin{frame}{NDVI}
    \lstinputlisting[basicstyle=\ttfamily\tiny,language=R, commentstyle=\color{darkgray}, frame=single, stringstyle=\color{blue}, backgroundcolor=\color{lightgray}]{ndvi.r} \\
    \centering
    \includegraphics[width=1\textwidth]{AmazonNDVI(2).png}
\end{frame}

\begin{frame}{Vegetation indices}
\begin{itemize}
    \item\small Higher values (lighter areas) represent a higher density of green vegetation, while lower values (darker areas) correspond to the loss of forest cover caused by human activities. 
    \bigskip
    \item\small The two vegetation indices used (DVI and NDVI) show a \textbf{decrease in the presence and density of vegetation} between 2001 and 2012.
\end{itemize}
\end{frame}

\begin{frame}{Spatio-temporal change detection}
    \lstinputlisting[basicstyle=\ttfamily\tiny,language=R, commentstyle=\color{darkgray}, frame=single, stringstyle=\color{blue}, backgroundcolor=\color{lightgray}]{dif.r} \\
    \centering
    \includegraphics[width=0.6\textwidth]{amazonDIF.png}
\end{frame}

\begin{frame}{Spatio-temporal change detection}
Darker areas indicate the biggest vegetation losses, usually the complete clearing of the original rainforest, while lighter areas showed little or no change.
\end{frame}

\begin{frame}{Unsupervised classification}
    \lstinputlisting[basicstyle=\ttfamily\tiny,language=R, commentstyle=\color{darkgray}, frame=single, stringstyle=\color{blue}, backgroundcolor=\color{lightgray}]{histograms.r} \\
    \centering
    \includegraphics[width=0.6\textwidth]{histograms.png}
\end{frame}

\section{Discussion and conclusion}

\begin{frame}{Discussion}
\begin{itemize}
    \item\small The study shows a \textbf{decrease in the Amazon's forest cover} from 72.5 to 70 percent and an \textbf{increase in the human component} from 27.5 to 30 percent.
    \bigskip
    \item\small The results obtained are in line with what has been reported in the scientific literature so far.
\end{itemize}
\end{frame}

\begin{frame}{Discussion}
\begin{itemize}
    \item\small Recently, an international study led by the Federal University of Santa Catarina in Brazil, published in the journal Nature (\url{https://www.nature.com/articles/s41586-023-06970-0}), estimated that 10 to 47 percent of the \textbf{Amazon rainforest is at risk of collapse by 2050}.
    \smallskip
    \item\small The Amazon forest system may soon reach a \textbf{tipping point} due to warming temperatures, extreme drought, deforestation, and wildfires, with unpredictable and far-reaching consequences for the Amazon itself, but also the entire planet.
    \smallskip
    \item\small The study emphasizes the urgency of taking action to reverse this trend, for example by restoring the areas most at risk, curbing deforestation, and focusing on renewable energy sources.
\end{itemize}
\end{frame}

\begin{frame}{Conclusion}
\begin{itemize}
    \item\small \textbf{All major tropical forests} - including those in the Americas, Africa, Southeast Asia, and Indonesia - \textbf{are disappearing}, mostly to make way for human food production, including livestock and crops. 
    \bigskip
    \item\small Although tropical deforestation meets some human needs, it also has profound, sometimes devastating, consequences, including social conflict and human rights abuses, extinction of plants and animals, and climate change - challenges that affect the whole world.
\end{itemize}
\end{frame}

\section{GitHub}

\begin{frame}{Script}
Here you can find my script on GitHub:
\vspace{4mm}\\
\url{https://github.com/irenecassinellii/Spatial_ecology_in_R/blob/main/R_code_exam.R}
\end{frame}

\end{document}
