# Wolf 1968, extraction

## Theorem 11.1 (p. 106), verbatim from the extraction

> "The table on pages 107-110 gives a complete list of the nonsymmetric simply connected coset spaces $M=G/K$, where (1) $G$ is a connected Lie group acting effectively on $M$ and (2) $K$ is a compact subgroup whose linear isotropy action $\chi$ on the tangent space of $M$ is irreducible over the real number field."

The statement continues with the reduction of an arbitrary effective $M'=G'/K'$ whose identity component $K_0$ acts irreducibly: there is an entry $M=G/K$ in the table, a central $Q\subseteq Z(G)$ and a subgroup $K''\subseteq N_G(K)$ with $K=K_0=N_G(K)_0$, such that $G'=G/Q$ and $K'=(Q\cdot K'')/Q$. So the table classifies up to central quotients and normalizer extensions, which is exactly the freedom this project needs when $K$ is taken possibly disconnected.

Its proof assembles Theorems 1.1, 2.1, 3.1, 4.1, 6.1, 7.1 and 8.1, which split by whether $\mathrm{rank}\,G=\mathrm{rank}\,K$, whether $G$ is exceptional, and whether $K$ is simple.

## Chapter structure, for locating a case

| § | Case |
| --- | --- |
| 1 | $G$ compact simple |
| 2 | equal ranks |
| 3 | $G$ exceptional, $\mathrm{rank}\,G>\mathrm{rank}\,K$ |
| 4 | $G$ classical, $K$ not simple |
| 6 | $G$ unitary, $K$ simple |
| 7 | $G$ symplectic, $K$ simple |
| 8 | $G$ orthogonal, $\chi$ reduces |

§8 is the relevant one here: $G$ orthogonal is the ambient $SO(n)=\Lambda^2\mathbb R^n$ case.

## Caveats recorded while reading

The scan is a 1968 typescript and `pdftotext` mangles it, ligatures, subscripts and the table columns come out unreliable ("Dyukin" for Dynkin, "l"efo~mulate" for reformulate). Statement numbers and section headings survive; the tables on pp. 107–110 do not. Any table row used in an argument must be read off the PDF page directly, or taken from the modern transcription cited in the README.

Wolf notes at p. 2314 of the extraction that his listing "does not agree with Dynkin's table 30 in [6], which is incorrect for $E_8$", a reminder that the classical tables in this area carry known errata, and that the 1984 Acta correction to this paper matters.
