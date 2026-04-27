using System;
using System.Collections.Generic;

namespace oop4
{
    public class Reusable
    {
        public void DoWork() { }
    }

    public class ObjectPool
    {
        int _poolSize;

        List<Reusable> _pool = new List<Reusable>();
        List<Reusable> _acquired = new List<Reusable>();

        public ObjectPool(int PoolSize)
        {
            if (PoolSize <= 0)
                throw new ArgumentException("Pula musi zezwalać na co najmniej 1 instancję");
            this._poolSize = PoolSize;
        }

        public Reusable AcquireReusable()
        {
            if (_acquired.Count == this._poolSize)
                throw new ArgumentException("Osiągnięto limit instancji");
            else if (_pool.Count == 0)
            {
                Reusable reusable = new Reusable();
                _pool.Add(reusable);
            }

            Reusable element = _pool[0];
            _pool.Remove(element);
            _acquired.Add(element);

            return element;
        }

        public void ReleaseReusable(Reusable reusable)
        {
            if (!_acquired.Contains(reusable))
                throw new ArgumentException("Podany element nie istnieje");
            _acquired.Remove(reusable);
            _pool.Add(reusable);
        }
    }

    public class BetterReusable
    {
        private Reusable _reusable;
        private bool disposed = false;
        private static ObjectPool _pool;

        public BetterReusable()
        {
            _reusable = _pool.AcquireReusable();
        }

        public static void InitPool(int instances = 1)
        {
            _pool = new ObjectPool(instances);
        }

        public void Release()
        {
            AssertNotDisposed();
            _pool.ReleaseReusable(_reusable);
            disposed = true;
        }

        public void DoWork()
        {
            AssertNotDisposed();
            _reusable.DoWork();
        }

        private void AssertNotDisposed()
        {
            if (disposed)
                throw new ArgumentException("Nie wolno wykonywać operacji na zwolnionym obiekcie");
        }
    }
}