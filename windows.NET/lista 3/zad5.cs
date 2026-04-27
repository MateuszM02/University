using System;

namespace lista_3
{
    public class ListHelper
    {
        public static List<TOutput> ConvertAll<T, TOutput>
            (List<T> list, Converter<T, TOutput> converter)
        {
            List<TOutput> output = [];
            foreach (T elem in list)
            {
                output.Add(converter(elem));
            }
            return output;
        }

        public static List<T> FindAll<T>(List<T> list, Predicate<T> match)
        {
            List<T> output = [];
            foreach (T elem in list)
            {
                if (match(elem))
                    output.Add(elem);
            }
            return output;
        }

        public static void ForEach<T>(List<T> list, Action<T> action)
        {
            for (int i = 0; i < list.Count; i++)
            {
                action(list[i]);
            }
        }

        public static int RemoveAll<T>(List<T> list, Predicate<T> match)
        {
            int removed = 0;
            foreach (T elem in list)
            {
                if (match(elem))
                {
                    removed++;
                    list.Remove(elem);
                }
            }
            return removed;
        }

        public static void Sort<T>(List<T> list, Comparison<T> comparison)
        {
            if (list.Count <= 1) return;
            else if (list.Count == 2)
            {
                if (comparison(list[0], list[1]) > 0)
                    (list[0], list[1]) = (list[1], list[0]);
            }

            int mid = list.Count / 2;
            List<T> left = list.GetRange(0, mid);
            List<T> right = list.GetRange(mid, list.Count - mid);

            Sort(left, comparison);
            Sort(right, comparison);

            Merge(list, left, right, comparison);
        }

        private static void Merge<T>
            (List<T> list, List<T> left, List<T> right, Comparison<T> comparison)
        {
            // ElementAt(i) ?
            // swap tuple czy jest lepsze ?
            //(list[j], list[i]) = (list[i], list[j]);
            int leftIndex = 0, rightIndex = 0, listIndex = 0;

            while (leftIndex < left.Count && rightIndex < right.Count)
            {
                if (comparison(left[leftIndex], right[rightIndex]) <= 0)
                {
                    list[listIndex] = left[leftIndex];
                    leftIndex++;
                }
                else
                {
                    list[listIndex] = right[rightIndex];
                    rightIndex++;
                }
                listIndex++;
            }

            while (leftIndex < left.Count)
            {
                list[listIndex] = left[leftIndex];
                leftIndex++;
                listIndex++;
            }

            while (rightIndex < right.Count)
            {
                list[listIndex] = right[rightIndex];
                rightIndex++;
                listIndex++;
            }
        }

    }
}
