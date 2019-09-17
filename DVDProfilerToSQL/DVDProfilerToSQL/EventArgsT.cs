using System;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EventArgs<T> : EventArgs
    {
        public T Value { get; }

        public EventArgs(T value)
        {
            Value = value;
        }
    }
}