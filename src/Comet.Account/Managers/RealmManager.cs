using Comet.Shared;
using Comet.Account.States;
using Microsoft.Extensions.Logging;
using System.Collections.Concurrent;
using System.Linq;

namespace Comet.Account.Managers
{
    public class RealmManager
    {
        private static readonly ILogger logger = LogFactory.CreateLogger<RealmManager>();

        private static readonly ConcurrentDictionary<uint, GameServer> Realms = new();

        private RealmManager() { }

        public static int Count => Realms.Count;

        public static bool AddRealm(GameServer realm)
        {
            return Realms.TryAdd(realm.Realm.RealmID, realm);
        }

        public static bool HasRealm(uint idRealm) => Realms.ContainsKey(idRealm);

        public static GameServer GetRealm(string name) => Realms.Values.FirstOrDefault(x => x.Realm.Name.Equals(name));
        public static GameServer GetRealm(uint idRealm) => Realms.TryGetValue(idRealm, out var result) ? result : null;

        public static bool RemoveRealm(uint idRealm)
        {
            return Realms.TryRemove(idRealm, out _);
        }
    }
}
