B2 = WeylCharacterRing("B2", style="coroots")
hits = [(a,b) for a in range(9) for b in range(13) if B2(a,b).degree()==35]
print("B2 irreps of dimension 35 (coroot labels):", hits)
for a,b in hits:
    print("  ", (a,b), "ambient highest weight", list(B2(a,b).highest_weight().to_ambient().to_vector()))
