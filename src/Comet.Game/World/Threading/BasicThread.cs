#if DEBUG
#define DISABLE_GM_TOOLS
#endif
using System;
using System.Threading.Tasks;
using Comet.Shared;
using Comet.Core;
using Comet.Game.Internal;
using Microsoft.Extensions.Logging;
using Quartz;
using Comet.Game.Packets;

namespace Comet.Game.Threading
{
    [DisallowConcurrentExecution]
    public sealed class BasicThread : IJob
    {
        private static readonly ILogger logger = LogFactory.CreateLogger<BasicThread>();

        private const string CONSOLE_TITLE = "[{0}] Conquer Online Game Server {9} - Players[{1}] Limit[{2}] Max[{3}] - {4} - Start: {8} - {5} - RoleTimerTicks[{6}] RoleCount[{7}]";

        private static readonly TimeOut accountReconnect = new(5);
        private static readonly TimeOut accountPing = new(15);
        private static readonly TimeOut pigletPing = new(15);
        private static readonly TimeOut accountSync = new();
        private static readonly DateTime serverStartTime;
        private TimeOut m_accountPing = new TimeOut(5);
        private static long lastUpdateTick = 0;

        static BasicThread()
        {
            serverStartTime = DateTime.Now;

            accountReconnect.Update();
            accountPing.Update();
            accountSync.Startup(60);
        }

        public async Task Execute(IJobExecutionContext context)
        {
            if (AccountClient.ConnectionStage == AccountClient.ConnectionState.Disconnected)
            {
                logger.LogInformation("Connecting to account server...");

                AccountClient.Instance = new AccountClient();
                if (!await AccountClient.Instance.ConnectToAsync(Program.Configuration.RpcNetwork.IPAddress, Program.Configuration.RpcNetwork.Port))
                {
                    _ = AccountClient.Instance.StopAsync();
                    AccountClient.Instance = null;
                }
            }
            else if (AccountClient.ConnectionStage == AccountClient.ConnectionState.Connected && accountPing.ToNextTime())
            {
                await AccountClient.Instance.Actor.SendAsync(new MsgAccServerPing());
            }

            if (Kernel.AccountClient == null && m_accountPing.ToNextTime())
            {
                await Log.WriteLogAsync(Shared.LogLevel.Info, "Attempting connection with the account server...");

                Kernel.AccountClient = new AccountClient();
                if (await Kernel.AccountClient.ConnectToAsync(AccountClient.Configuration.IPAddress, AccountClient.Configuration.Port))
                {
                    await Log.WriteLogAsync(Shared.LogLevel.Info, "Connected to the account server!");
                }
            }
          
            // TODO: Implement this
            // await MaintenanceManager.OnTimerAsync();

            lastUpdateTick = Environment.TickCount;
        }

    }
}
