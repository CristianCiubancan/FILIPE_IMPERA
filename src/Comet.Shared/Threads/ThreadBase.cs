﻿using Microsoft.Extensions.Logging;
using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace Comet.Shared.Threads
{
    public abstract class ThreadBase
    {
        private static readonly ILogger logger = LogFactory.CreateLogger<ThreadBase>();
        private static readonly CancellationTokenSource cancellationTokenSource = new();

        private CancellationToken cancellationToken;

        private readonly string threadName;
        private readonly int interval;

        private Task task;
        private bool running = false;

        public ThreadBase(string threadName, int interval = 1000)
        {
            this.threadName = threadName;
            this.interval = interval;
        }

        public long ElapsedMilliseconds { get; private set; }

        public Task StartAsync()
        {
            if (running)
            {
                return Task.CompletedTask;
            }

            cancellationToken = cancellationTokenSource.Token;
            cancellationToken.ThrowIfCancellationRequested();

            task = Task.Factory.StartNew(ProcessAsync, TaskCreationOptions.LongRunning);

            running = true;
            return Task.CompletedTask;
        }

        protected async Task ProcessAsync()
        {
            await OnStartAsync();

            while (!cancellationToken.IsCancellationRequested)
            {
                Stopwatch sw = Stopwatch.StartNew();
                try
                {
                    await OnProcessAsync();
                }
                catch (Exception ex)
                {
                    // if the owner doesn't handle the exception
                    logger.LogCritical(ex, "{ThreadName} has thrown an exception", threadName);
                }
                finally
                {
                    await Task.Delay(interval, cancellationToken);
                    sw.Stop();
                    ElapsedMilliseconds = sw.ElapsedMilliseconds;
                }
            }

            await OnStopASync();
        }

        public Task StopAsync()
        {
            cancellationTokenSource.Cancel();
            return task;
        }

        protected virtual Task OnStartAsync()
        {
            logger.LogInformation("{ThreadName} is starting!", threadName);
            return Task.CompletedTask;
        }

        protected virtual Task OnProcessAsync()
        {
            logger.LogWarning("{ThreadName} doesn't have a handler!", threadName);
            return Task.CompletedTask;
        }

        protected virtual Task OnStopASync()
        {
            logger.LogInformation("{ThreadName} is closing!", threadName);
            return Task.CompletedTask;
        }
    }
}
