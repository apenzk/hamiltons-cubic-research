# Lauret–Rossi Bertone–Tolcachier 2025, extraction

## Scope, from §1 and Remark 2.3

The non-symmetric simply connected strongly isotropy irreducible spaces are the 10 families of Table 1 and the 33 isolated cases of Tables 3 (G classical, 18 rows) and 4 (G exceptional, 15 rows), citing Wolf's four tables on pp. 107–110 of [Wo68] together with [Wo84]. The paper states these were classified independently by Manturov, Wolf and Krämer, with the remaining compact isotropy irreducible spaces classified by Wang–Ziller (Acta Math. 166, 1991).

## Table 1, the entries whose ambient group is orthogonal

The ambient dimension is written $n$ below in this project's convention: the entry sits in $\mathfrak{so}(n)$, with $\mathfrak h$ the isotropy algebra and $r=\dim\mathfrak h$. The paper's own parameter is written $k$ here to avoid a clash.

| No. | Space | ambient $n$ | $\mathfrak h$ | $r=\dim\mathfrak h$ | condition |
| --- | --- | --- | --- | --- | --- |
| V | $Spin(k^2-1)/SU(k)$, $SO(k^2-1)/SU(k)$ | $k^2-1$ | $\mathfrak{su}(k)$ | $k^2-1$ | $k\ge3$ |
| VI | $Spin(2k^2-k-1)/Sp(k)$, $SO(\cdot)/Sp(k)$ | $2k^2-k-1$ | $\mathfrak{sp}(k)$ | $k(2k+1)$ | $k\ge3$ |
| VII | $Spin(2k^2+k)/Sp(k)$, $SO(\cdot)/Sp(k)$ | $2k^2+k$ | $\mathfrak{sp}(k)$ | $k(2k+1)$ | $k\ge3$ |
| VIII | $SO(4k)/(Sp(1)\times Sp(k))$ | $4k$ | $\mathfrak{sp}(1)\oplus\mathfrak{sp}(k)$ | $3+k(2k+1)$ | $k\ge2$ |
| IX | $Spin(k(k-1)/2)/SO(k)$, $SO(\cdot)/SO(k)$ | $k(k-1)/2$ | $\mathfrak{so}(k)$ | $k(k-1)/2$ | $k=5$, $k\ge7$ |
| X | $Spin((k-1)(k+2)/2)/SO(k)$, $SO(\cdot)/SO(k)$ | $(k-1)(k+2)/2$ | $\mathfrak{so}(k)$ | $k(k-1)/2$ | $k\ge5$ |

Families I–III have ambient $SU$ and family IV ambient $Sp$, so they carry no subalgebra of $\mathfrak{so}(n)$.

The embeddings, from the table's $(d\rho)_{\mathbb C}$ column: V is $\sigma_{\eta_1+\eta_{k-1}}$ (the adjoint representation of $\mathfrak{su}(k)$), VI is $\sigma_{\eta_2}$, VII is $\sigma_{2\eta_1}$ (the adjoint of $\mathfrak{sp}(k)$), IX is $\sigma_{\eta_2}$ for $k\ge7$ and $\sigma_{2\eta_2}$ at $k=5$ (the adjoint of $\mathfrak{so}(k)$), and X is $\sigma_{2\eta_1}$ (the traceless symmetric square). Remark 2.5 carries the details of $H\subset G$.

Family VIII has non-simple isotropy, so its invariant operators carry one parameter per factor rather than a single one.

## Table 3, isolated cases with $G$ classical and ambient orthogonal

| No. | $G$ | $H$ | ambient $n$ | $r=\dim\mathfrak h$ |
| --- | --- | --- | --- | --- |
| 3 | $Spin(7)$ | $G_2$ | 7 | 14 |
| 4 | $SO(133)$ | $E_7/\mathbb Z_2$ | 133 | 133 |
| 10 | $Spin(14)$ | $G_2$ | 14 | 14 |
| 11 | $Spin(16)/\mathbb Z_2$ | $SO(9)$ | 16 | 36 |
| 12 | $Spin(26)$ | $F_4$ | 26 | 52 |
| 13 | $Spin(42)$ | $Sp(4)/\mathbb Z_2$ | 42 | 36 |
| 14 | $Spin(52)$ | $F_4$ | 52 | 52 |
| 15 | $SO(70)/\mathbb Z_2$ | $SU(8)/\mathbb Z_8$ | 70 | 63 |
| 16 | $Spin(78)$ | $E_6/\mathbb Z_3$ | 78 | 78 |
| 17 | $Spin(128)/\mathbb Z_2$ | $SO(16)/\mathbb Z_2$ | 128 | 120 |
| 18 | $Spin(248)$ | $E_8$ | 248 | 248 |

Rows 1, 2, 5–9 have ambient $SU$ or $Sp$. A footnote records that $Spin(N)/\mathbb Z_2$ in rows 11 and 17 is not isomorphic to $SO(N)$.

Row 3 is $Spin(7)/G_2=S^7$, and $G_2$ stabilises the associative 3-form, so $(\Lambda^4\mathbb R^7)^{G_2}\ne0$, the one orthogonal entry that fails a Bianchi-type hypothesis outright.
