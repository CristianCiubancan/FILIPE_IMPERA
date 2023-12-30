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
    public static class DetainedItemRepository
    {
        public static async Task<List<DbDetainedItem>> GetAsync()
        {
            await using var db = new ServerDbContext();
            return db.DetainedItems.ToList();
        }

         public static async Task<List<DbDetainedItem>> GetFromHunterAsync(uint hunter)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.DetainedItems.Where(x => x.HunterIdentity == hunter).ToListAsync();
        }

        public static async Task<List<DbDetainedItem>> GetFromDischargerAsync(uint target)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.DetainedItems.Where(x => x.TargetIdentity == target).ToListAsync();
        }

        public static async Task<DbDetainedItem> GetByIdAsync(uint id)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.DetainedItems.FirstOrDefaultAsync(x => x.Identity == id);
        }

        public static async Task<List<DbDetainedItem>> GetByItemAsync(uint idItem)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.DetainedItems.Where(x => x.ItemIdentity == idItem).ToListAsync();
        }
    }
}