namespace lista_4
{
    public static class Zad1
    {
        public static bool isPalindrome(this string s)
        {
            s = new string(s.Where(
                c => !char.IsWhiteSpace(c)
                ).ToArray());
            s = s.ToLower();
            for (int i = 0; i < s.Length/2; i++)
            {
                if (s[i] != s[s.Length-i-1])
                    return false;
            }
            return true;
        }
    }
}
