"""Pull sparse_rank verbatim out of run_n12_covariants.py so the tested object
is the code under review, never a transcription."""
import os, re
SRC = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   "..", "..", "runs", "run_n12_covariants.py")

def load(P=2147483647):
    txt = open(SRC).read()
    i = txt.index("def sparse_rank(")
    j = txt.index("\ndef hw_nullity(", i)
    body = txt[i:j]
    ns = {"P": P, "defaultdict": __import__("collections").defaultdict}
    exec(compile(body, SRC, "exec"), ns)
    return ns["sparse_rank"], body
