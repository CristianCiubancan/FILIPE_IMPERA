// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (C) FTW! Masters
// Keep the headers and the patterns adopted by the project. If you changed anything in the file just insert
// your name below, but don't remove the names of who worked here before.
// 
// This project is a fork from Comet, a Conquer Online Server Emulator created by Spirited, which can be
// found here: https://gitlab.com/spirited/comet
// 
// Comet - Comet.Game - ActionRepository.cs
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

using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comet.Database.Entities;
using Microsoft.EntityFrameworkCore;

namespace Comet.Game.Database.Repositories
{
    public static class CardRepository
    {
        public static async Task<List<DbCard>> GetAsync()
        {
            await using var db = new ServerDbContext();
            return await db.Cards.ToListAsync();
        }

        public static async Task<List<DbCard>> GetAsync(uint accountId)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Cards.Where(x => x.AccountId == accountId && x.Flag == 0 && x.Timestamp == null).ToListAsync();
        }

        public static async Task<int> CountAsync(uint account)
        {
            await using var db = new ServerDbContext();
            return await db.Cards.CountAsync(x => x.AccountId == account && x.Flag == 0 && x.Timestamp == null);
        }
    }
}