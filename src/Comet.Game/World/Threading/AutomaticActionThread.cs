using Comet.Shared;
using Comet.Database.Entities;
using Comet.Game.States;
using Comet.Game.World.Managers;
using Microsoft.Extensions.Logging;
using Quartz;
using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;

namespace Comet.Game.Threading
{
    [DisallowConcurrentExecution]
    public sealed class AutomaticActionThread : IJob
    {
        private static readonly ILogger logger = LogFactory.CreateLogger<AutomaticActionThread>();

        private const int _ACTION_SYSTEM_EVENT = 2030000;
        private const int _ACTION_SYSTEM_EVENT_LIMIT = 100;

        private readonly ConcurrentDictionary<uint, DbAction> actions;

        public AutomaticActionThread()
        {
            actions = new ConcurrentDictionary<uint, DbAction>(1, _ACTION_SYSTEM_EVENT_LIMIT);

            for (var a = 0; a < _ACTION_SYSTEM_EVENT_LIMIT; a++)
            {
                DbAction action = EventManager.GetAction((uint)(_ACTION_SYSTEM_EVENT + a));
                if (action != null)
                {
                    actions.TryAdd(action.Identity, action);
                }
            }
        }

        public async Task Execute(IJobExecutionContext context)
        {
            foreach (DbAction action in actions.Values)
            {
                try
                {
                    await GameAction.ExecuteActionAsync(action.Identity, null, null, null, "");
                }
                catch (Exception ex)
                {
                    logger.LogCritical(ex, "Error on processing automatic actions!! {Message}", ex.Message);
                }
            }
        }
    }
}
