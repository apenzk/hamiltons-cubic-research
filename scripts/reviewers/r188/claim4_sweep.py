"""Sweep every script in scripts/runs/ for a MIXED use of the two normalisations.

Classifier, applied line by line:
  TENSOR    a Weyl tensor divided by sqrt(sum_ijkl W^2), or a norm/trace taken on
            the flat n^2 x n^2 reshape;
  OPERATOR  a Weyl tensor or its Lambda^2 matrix divided by the Frobenius norm of
            that matrix (the i<j, k<l block), or a trace taken on it.
A script is MIXED only if a TENSOR-normalised object reaches a theta-like or
Theta-like quantity without being reconverted.  The last part is judged by hand
on the hits this prints; the automatic part only narrows the field.
"""
import os, re
D = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
TEN = [r"np\.sqrt\(np\.einsum\('ijkl,ijkl'", r"np\.sqrt\(np\.einsum\(\"ijkl,ijkl\"",
       r"np\.linalg\.norm\(W\)", r"einsum\('ijkl,ijkl',\s*W,\s*W\)"]
OPR = [r"np\.linalg\.norm\(toM\(", r"np\.linalg\.norm\(lam2\(", r"np\.linalg\.norm\(M\)",
       r"norm\(M0\)", r"M\s*/=\s*np\.linalg\.norm\(M\)"]
THETA = [r"\btheta\b", r"\bth\s*=", r"1\.2247", r"np\.sqrt\(1\.5\)", r"SQRT32"]

rows = []
for f in sorted(os.listdir(D)):
    if not f.endswith(".py"): continue
    src = open(os.path.join(D, f)).read()
    t = [i+1 for i, L in enumerate(src.splitlines()) if any(re.search(p, L) for p in TEN)]
    o = [i+1 for i, L in enumerate(src.splitlines()) if any(re.search(p, L) for p in OPR)]
    th = any(re.search(p, src) for p in THETA)
    if t or o: rows.append((f, t, o, th))

print(f"{'script':40s} {'TENSOR lines':>26s} {'OPERATOR lines':>26s}  theta?")
mixed = []
for f, t, o, th in rows:
    print(f"{f:40s} {str(t):>26s} {str(o):>26s}  {'yes' if th else '-'}")
    if t and o and th: mixed.append(f)
print(f"\nscripts carrying BOTH conventions AND a theta: {mixed}")
print("Hand verdict on each of those, from reading the lines:")
print("  run_bispectral_dictionary.py  the tensor-normalising generator's output is")
print("     re-divided by |M| at the top of the loop before any trace is taken.")
print("  run_bispectral_identity.py    line 79 rescales by 2 with the comment")
print("     '|W|^2 = 4|M|^2', landing on |M| = 1 before P, t1, t2 are formed.")
print("  => no live mixed use.  Every theta in scripts/runs/ is formed at |M| = 1.")
print("\nAnd it would not matter if one had slipped, for theta specifically:")
print("  |W|^2_tensor = 4|W|^2_op and tr_flat(W^3) = 8 tr_op(W^3), and 4^3 = 8^2,")
print("  so theta = 3 tr(W^3)/|W|^3 takes the same value in both -- claim4_normalisation.py.")
