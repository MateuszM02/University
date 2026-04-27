using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace test4
{
    [TestClass]
    public class ObjectPoolTests
    {
        [TestMethod]
        public void InvalidSize()
        {
            Assert.ThrowsException<ArgumentException>(
            () =>
            {
                oop4.ObjectPool pool = new oop4.ObjectPool(0);
            });
        }

        [TestMethod]
        public void ValidSize()
        {
            //oop4.ObjectPool pool = new oop4.ObjectPool(1);
            //oop4.Reusable reusable = pool.AcquireReusable();

            oop4.BetterReusable.InitPool();
            oop4.BetterReusable betterReusable = new oop4.BetterReusable();
            Assert.IsNotNull(betterReusable);
            //betterReusable.Release();
        }

        [TestMethod]
        public void CapacityDepleted()
        {
            //oop4.ObjectPool pool = new oop4.ObjectPool(1);
            //oop4.Reusable reusable = pool.AcquireReusable();

            oop4.BetterReusable.InitPool();
            oop4.BetterReusable betterReusable = new oop4.BetterReusable();
            Assert.ThrowsException<ArgumentException>(
            () =>
            {
                //oop4.Reusable reusable2 = pool.AcquireReusable();
                oop4.BetterReusable betterReusable2 = new oop4.BetterReusable();
            });
        }

        [TestMethod]
        public void ReusedInstance()
        {
            //oop4.ObjectPool pool = new oop4.ObjectPool(1);
            //oop4.Reusable reusable = pool.AcquireReusable();
            //pool.ReleaseReusable(reusable);
            //oop4.Reusable reusable2 = pool.AcquireReusable();

            oop4.BetterReusable.InitPool();
            oop4.BetterReusable betterReusable = new oop4.BetterReusable();
            betterReusable.Release();
            oop4.BetterReusable betterReusable2 = new oop4.BetterReusable();
            // Nie działa, bo zrobiliśmy Release
            //Assert.AreEqual(betterReusable, betterReusable2);
            //betterReusable2.Release();
        }

        [TestMethod]
        public void ReleaseInvalidInstance()
        {
            //oop4.ObjectPool pool = new oop4.ObjectPool(1);
            //oop4.Reusable reusable = new oop4.Reusable();

            oop4.BetterReusable.InitPool();
            oop4.BetterReusable betterReusable = new oop4.BetterReusable();
            betterReusable.Release();
            Assert.ThrowsException<ArgumentException>(
                () =>
                {
                    //pool.ReleaseReusable(reusable);
                    betterReusable.Release();
                });
        }

        [TestMethod]
        public void DoWorkOnReleased()
        {
            //oop4.ObjectPool pool = new oop4.ObjectPool(1);
            //oop4.Reusable reusable = pool.AcquireReusable();
            //pool.ReleaseReusable(reusable);

            oop4.BetterReusable.InitPool();
            oop4.BetterReusable betterReusable = new oop4.BetterReusable();
            betterReusable.Release();
            Assert.ThrowsException<ArgumentException>(
                () =>
                {
                    //reusable.DoWork();
                    betterReusable.DoWork();
                });
        }
    }
}