using Comet.Account.States;
using System.Collections.Concurrent;

namespace Comet.Account.Managers
{
    public static class ClientManager
    {
        private static object clientLock = new();
        private static ConcurrentDictionary<uint, Client> Clients { get; } = new ();

        public static bool AddClient(Client client)
        {
            lock (clientLock)
            {
                return Clients.TryAdd(client.Account.AccountID, client);
            }
        }

        public static bool HasClient(uint idClient)
        {
            lock (clientLock)
            {
                return Clients.ContainsKey(idClient);
            }
        }

        public static Client GetClient(uint guid)
        {
            lock (clientLock)
            {
                return Clients.TryGetValue(guid, out var client) ? client : null;
            }
        }

        public static bool RemoveClient(uint idClient)
        {
            lock (clientLock) 
            {
                return Clients.TryRemove(idClient, out _);
            }            
        }
    }
}
