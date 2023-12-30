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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comet.Database.Entities;
using Microsoft.EntityFrameworkCore;

namespace Comet.Game.Database.Repositories
{
    public static class ArenicRepository
    {
        public static async Task<List<DbArenic>> GetAsync()
        {
            await using var db = new ServerDbContext();
            return await db.Arenics.ToListAsync();
        }

        public static async Task<List<DbArenic>> GetAsync(DateTime date)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Arenics
                .Where(x => x.Date == date.Date)
                .ToListAsync();
        }

        public static async Task<List<DbArenic>> GetRankAsync(int from, int limit = 10)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Arenics
                .Where(x => x.Date == DateTime.Now.Date)
                .OrderByDescending(x => x.AthletePoint)
                .ThenByDescending(x => x.DayWins)
                .ThenBy(x => x.DayLoses)
                .Skip(from)
                .Take(limit)
                .Include(x => x.User)
                .ToListAsync();
        }

        public static async Task<int> GetRankCountAsync()
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Arenics
                .Where(x => x.Date == DateTime.Now.Date)
                .OrderByDescending(x => x.AthletePoint)
                .ThenByDescending(x => x.DayWins)
                .ThenBy(x => x.DayLoses)
                .CountAsync();
        }

        public static async Task<List<DbArenic>> GetSeasonRankAsync(DateTime date)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Arenics
                .Where(x => x.Date == date.Date)
                .OrderByDescending(x => x.AthletePoint)
                .ThenByDescending(x => x.DayWins)
                .ThenBy(x => x.DayLoses)
                .Take(10)
                .Include(x => x.User)
                .ToListAsync();
        }

        public static async Task<int> GetSeasonRankCountAsync(DateTime date)
        {
            await using var ctx = new ServerDbContext();
            return await ctx.Arenics
                .Where(x => x.Date == date.Date)
                .OrderByDescending(x => x.AthletePoint)
                .ThenByDescending(x => x.DayWins)
                .ThenBy(x => x.DayLoses)
                .CountAsync();
        }
    }
}