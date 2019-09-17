using System;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal interface IProgressReporter
    {
        event EventHandler<EventArgs<string>> Feedback;
        event EventHandler<EventArgs<int>> ProgressMaxChanged;
        event EventHandler<EventArgs<int>> ProgressValueChanged;
    }
}