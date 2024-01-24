def find_common_prefix(a: str, b: str):
    prefix = ""
    n = min(len(a), len(b))
    for i in range(n):
        if a[i] == b[i]:
            prefix += a[i]
        else:
            return prefix
    return prefix

def common_prefix(list: list[str]):
    n = len(list)
    # sortuj
    for i in range(n):
        list[i] = list[i].lower()
    prefix = ""
    list.sort()

    for i in range(n):
        for j in range(i+1, n-1):
            prefix2 = find_common_prefix(list[i], list[j])
            prefix3 = find_common_prefix(prefix2, list[j+1])
            if (prefix2 == prefix3): # znaleziono prefiks 3 ciagow
                if (len(prefix2) > len(prefix)):
                    prefix = prefix2
    return prefix

xs = ["Cyprian", "cyberotoman", "cynik", "ceniąc", "czule"]
common_prefix(xs)