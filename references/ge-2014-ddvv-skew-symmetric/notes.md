# Transcription notes

Read on 2026-09-23: the statement and equality case of Theorem 1.1 and the surrounding conventions. The proof, the $n=3$ case analysis and the submersion application (Theorem 1.2, Sections 4 onward) were **not transcribed**.

## Conventions

$\lVert B\rVert^2=\mathop{\mathrm{tr}}(B^tB)=-\mathop{\mathrm{tr}}(B^2)$ for real skew $B$, the ordinary Frobenius norm on $\mathfrak{so}(n)$, **not** the record's $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ bivector normalisation. The factor two matters: any constant carried from Theorem 1.1 into a record computation must be converted first, and none has been.

## Theorem 1.1, in full

For $B_1,\dots,B_m\in\mathfrak{so}(n)$ real skew:
$$n=3:\ \sum_{r,s}\lVert[B_r,B_s]\rVert^2\le\tfrac13\Big(\sum_r\lVert B_r\rVert^2\Big)^2,\qquad n\ge4:\ \sum_{r,s}\lVert[B_r,B_s]\rVert^2\le\tfrac23\Big(\sum_r\lVert B_r\rVert^2\Big)^2.$$
Equality at $n=3$: all $B_r$ vanish under some $O(3)\times O(m)$ action except three, equal to $\lambda$ times the three coordinate rotation generators. Equality at $n\ge4$: all vanish except three of the form $\mathrm{diag}(D_i,0)$ with $D_i\in M(4)$ and $0\in M(n-4)$, so **the equality configuration occupies exactly four dimensions in every dimension above three**.

## Why it was filed rather than used

The outside C-sector report proves its own two-form commutator inequality, $\lVert[U,V]\rVert^2\le\lVert u\rVert^2\lVert v\rVert^2-\langle u,v\rangle^2+\langle u\wedge u,v\wedge v\rangle$, by a block calculation in an eigenbasis of $U$. **That is a two-matrix statement and Ge's is the $m$-matrix one**, so the report proves a special case of a published sharp result while citing the published result elsewhere. Which of the two the record would want depends on whether a proof needs the family form; nothing in [results.md](../../results.md) currently needs either.
