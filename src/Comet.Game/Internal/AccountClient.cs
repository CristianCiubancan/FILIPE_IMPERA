using Comet.Game.Packets;
using Comet.Game.States;
using Comet.Network.Packets;
using Comet.Network.Sockets;
using Comet.Shared;
using System;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;
using static Comet.Game.Database.ServerConfiguration;

namespace Comet.Game.Internal
{
    public sealed class AccountClient : TcpClientWrapper<AccountServer>
    {
        public static AccountClient Instance { get; set; }
        public static RpcNetworkConfiguration Configuration;
        public static ConnectionState ConnectionStage { get; set; }
        private readonly PacketProcessor<AccountServer> Processor;
        public Client Actor { get; set; }

        public AccountClient()
            : base("8a653a5d1e92b4e1db79".Length)
        {
            Processor = new PacketProcessor<AccountServer>(ProcessAsync);
            Processor.StartAsync(CancellationToken.None).ConfigureAwait(false);
        }

        protected override async Task<AccountServer> ConnectedAsync(Socket socket, Memory<byte> buffer)
        {
            AccountServer client = new(socket, buffer, 0);
            if (socket.Connected)
            {
                Kernel.AccountServer = client;
                Kernel.AccountClient = this;

                await client.SendAsync(new MsgAccServerExchange
                {
                    ServerName = Kernel.Configuration.ServerName,
                    Username = Kernel.Configuration.Username,
                    Password = Kernel.Configuration.Password
                });
            }
            ConnectionStage = ConnectionState.Exchanging;
            return client;
        }

        protected override async Task<bool> ExchangedAsync(AccountServer actor, Memory<byte> buffer)
        {
            await base.ExchangedAsync(actor, buffer);
            await Log.WriteLogAsync(LogLevel.Info, "Connected to the account server!");
            ConnectionStage = ConnectionState.Connected;
            return true;
        }

        protected override void Received(AccountServer actor, ReadOnlySpan<byte> packet)
        {
            Processor.QueueRead(actor, packet.ToArray());
        }
        public override void Send(AccountServer actor, ReadOnlySpan<byte> packet)
        {
            Processor.QueueWrite(actor, packet.ToArray());
        }

        public void Send(AccountServer actor, ReadOnlySpan<byte> packet, Func<Task> task)
        {
            Processor.QueueWrite(actor, packet.ToArray(), task);
        }
        private async Task ProcessAsync(AccountServer actor, byte[] packet)
        {
            // Validate connection
            if (!actor.Socket.Connected)
                return;

            var length = BitConverter.ToUInt16(packet, 0);
            PacketType type = (PacketType)BitConverter.ToUInt16(packet, 2);

            try
            {
                MsgBase<AccountServer> msg = null;
                switch (type)
                {
                    case PacketType.MsgPCNum:
                        msg = new MsgPCNum();
                        break;

                    case PacketType.MsgAccServerAction:
                        msg = new MsgAccServerAction();
                        break;

                    case PacketType.MsgAccServerLoginExchange:
                        msg = new MsgAccServerLoginExchange();
                        break;

                    case PacketType.MsgAccServerCmd:
                        msg = new MsgAccServerCmd();
                        break;

                    case PacketType.MsgAccServerPing:
                        msg = new MsgAccServerPing();
                        break;

                    default:
                        await Log.WriteLogAsync(LogLevel.Warning,
                            "Missing packet {0}, Length {1}\n{2}",
                            type, length, PacketDump.Hex(packet));
                        return;
                }

                // Decode packet bytes into the structure and process
                msg.Decode(packet);
                await msg.ProcessAsync(actor);
            }
            catch (Exception e)
            {
                await Log.WriteLogAsync(LogLevel.Exception, e.Message);
            }
        }

        protected override void Disconnected(AccountServer actor)
        {
            Log.WriteLogAsync(LogLevel.Info, "Disconnected from the account server!").ConfigureAwait(false);

            Kernel.AccountClient = null;
            Kernel.AccountServer = null;
            ConnectionStage = ConnectionState.Disconnected;
        }

        public Task StopAsync()
        {
            return Processor.StopAsync(CancellationToken.None);
        }

        public enum ConnectionState
        {
            Disconnected,
            Exchanging,
            Connected
        }
    }
}
