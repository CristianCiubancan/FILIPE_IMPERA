// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Account - RealmsRepository.cs
// Description:
// 
// Creator: FELIPEVIEIRAVENDRAMI [FELIPE VIEIRA VENDRAMINI]
// 
// Developed by:
// Felipe Vieira Vendramini <felipevendramini@live.com>
// 
// Programming today is a race between software engineers striving to build bigger and better
// idiot-proof programs, and the Universe trying to produce bigger and better idiots.
// So far, the Universe is winning.
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#region References

using System.Linq;
using System.Threading.Tasks;
using Comet.Database.Entities;
using Microsoft.EntityFrameworkCore;

#endregion

namespace Comet.Account.Database.Repositories
{
    /// <summary>
    ///     Repository for defining data access layer (DAL) logic for the realm table. Realm
    ///     connection details are loaded into server memory at server startup, and may be
    ///     modified once loaded.
    /// </summary>
    public static class RecordUserRepository
    {
        /// <summary>
        ///     Loads realm connection details and security information to the server's pool
        ///     of known realm routes. Should be invoked at server startup before the server
        ///     listener has been started.
        /// </summary>

        public static async Task<DbRecordUser> GetByIdAsync(uint userId, uint realmId)
        {
            await using var db = new ServerDbContext();
            return await db.RecordUsers.Where(x => x.AccountIdentity == userId && x.ServerIdentity == realmId).FirstOrDefaultAsync();
        }

    }
}