﻿using System;
using System.IO;
using Microsoft.Extensions.Logging;

namespace Comet.Shared.Loggers
{
    public sealed class CanyonGmFileLogger : ILogger
    {
        private readonly LogProcessor logProcessor;

        public CanyonGmFileLogger(LogProcessor logProcessor)
        {
            this.logProcessor = logProcessor;
        }

        public string FileName { get; init; }

        public IDisposable BeginScope<TState>(TState state) where TState : notnull
        {
            return default;
        }

        public bool IsEnabled(Microsoft.Extensions.Logging.LogLevel logLevel)
        {
            return true;
        }

        public void Log<TState>(Microsoft.Extensions.Logging.LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
        {
            DateTime now = DateTime.Now;
            logProcessor.Queue(new LogQueueMessage
            {
                Path = Path.Combine(Environment.CurrentDirectory, $"GameLogs", now.ToString("yyyyMM")),
                FileName = $"{FileName} {now:yyyy-MM-dd}.log",
                Message = $"{formatter(state, exception)} -- {now:yyyyMMdd:HHmmss.fff}"
            });
        }
    }
}
