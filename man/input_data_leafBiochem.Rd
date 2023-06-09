% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/05b_input_data_leafBiochem.R
\name{input_data_leafBiochem}
\alias{input_data_leafBiochem}
\title{Modifies Leaf biochemical module within input_data_default.csv}
\usage{
input_data_leafBiochem(
  Vcmax25 = 60,
  BallBerrySlope = 8,
  BallBerry0 = 0.01,
  Type = 0,
  kV = 0.64,
  Rdparam = 0.015,
  Kn0 = 2.48,
  Knalpha = 2.83,
  Knbeta = 0.114,
  Tyear = 15,
  beta = 0.51,
  kNPQs = 0,
  qLs = 1,
  stressfactor = 1,
  fqe = 0.01
)
}
\arguments{
\item{Vcmax25}{maximum carboxylation capacity (at optimum temperature of 25C, former Vcmo) (umol m-2 s-1)}

\item{BallBerrySlope}{slope of Ball-Berry stomatal conductance model (former m)}

\item{BallBerry0}{intercept of Ball-Berry stomatal conductance model}

\item{Type}{Photochemical pathway: 0 => ‘C3’, 1 => ‘C4’}

\item{kV}{extinction coefficient for Vcmax in the vertical (maximum at the top). 0 for uniform Vcmax}

\item{Kn0}{parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha);}

\item{Knalpha}{alpha parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha)}

\item{Knbeta}{beta parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha)}

\item{Tyear}{mean annual temperature (deg C)}

\item{beta}{fraction of photons partitioned to PSII (0.507 for C3, 0.4 for C4; Yin et al. 2006 \link{10}; Yin and Struik 2012 \link{11})}

\item{kNPQs}{rate constant of sustained thermal dissipation (Porcar-Castell 2011 \link{3})}

\item{qLs}{fraction of functional reaction centres (Porcar-Castell 2011 \link{3})}

\item{stressfactor}{optional input: stress factor to reduce Vcmax (for example soil moisture, leaf age)}

\item{fqe}{fluorescence quantum yield efficiency at photosystem level}

\item{path}{filepath of the filenames.csv}
}
\value{
Default values are given based on default SCOPE values in github
}
\description{
This function lets you modify input values for leaf biochemistry module inside input_data_default.csv contains.
}
